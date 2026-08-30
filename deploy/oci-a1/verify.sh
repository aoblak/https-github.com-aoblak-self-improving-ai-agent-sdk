#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
docker compose config -q
docker compose ps

bad="$(docker compose ps --format json | grep -E 'unhealthy|exited|dead' || true)"
if [ -n "$bad" ]; then
  echo "$bad"
  echo "Deployment verification failed."
  exit 1
fi

curl -fsS --max-time 10 http://127.0.0.1:8080/ >/dev/null
echo "Deployment verification OK."
