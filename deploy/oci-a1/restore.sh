#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${1:-/var/backups/ai-agents/latest}"
[ -d "$BACKUP_DIR" ] || { echo "Backup not found: $BACKUP_DIR"; exit 1; }
(cd "$BACKUP_DIR" && sha256sum -c SHA256SUMS)

docker compose down
for volume in agent_zero_usr hermes_home; do
  archive="$BACKUP_DIR/${volume}.tar.gz"
  [ -f "$archive" ] || { echo "Missing $archive"; exit 1; }
  docker volume create "$volume" >/dev/null
  docker run --rm \
    -v "${volume}:/data" \
    -v "$BACKUP_DIR:/backup:ro" \
    alpine:3.20 sh -c "rm -rf /data/* /data/.[!.]* /data/..?* 2>/dev/null || true; tar -xzf /backup/${volume}.tar.gz -C /data"
done

docker compose up -d
./verify.sh
