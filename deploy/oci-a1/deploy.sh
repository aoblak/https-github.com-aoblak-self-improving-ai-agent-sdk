#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

BACKUP_ROOT="${BACKUP_ROOT:-/var/backups/ai-agents}"
export BACKUP_ROOT

./backup.sh
PREVIOUS_IMAGE="$(docker inspect agent-zero --format '{{.Config.Image}}' 2>/dev/null || true)"

rollback() {
  echo "Deploy failed; restoring last verified persistent state."
  ./restore.sh "$BACKUP_ROOT/latest" || true
  exit 1
}
trap rollback ERR

docker compose pull agent-zero
docker compose build --pull hermes
docker compose up -d --remove-orphans
sleep 10
./verify.sh
trap - ERR

echo "Deployment promoted successfully. Previous Agent Zero image: ${PREVIOUS_IMAGE:-none}"
