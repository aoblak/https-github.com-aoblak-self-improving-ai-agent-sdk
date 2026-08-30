#!/usr/bin/env bash
set -euo pipefail

ROOT="${BACKUP_ROOT:-/var/backups/ai-agents}"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
DEST="$ROOT/$STAMP"
mkdir -p "$DEST"

for volume in agent_zero_usr hermes_home; do
  docker run --rm \
    -v "${volume}:/data:ro" \
    -v "$DEST:/backup" \
    alpine:3.20 sh -c "cd /data && tar -czf /backup/${volume}.tar.gz ."
done

sha256sum "$DEST"/*.tar.gz > "$DEST/SHA256SUMS"
ln -sfn "$DEST" "$ROOT/latest"
echo "Backup complete: $DEST"
