#!/usr/bin/env bash
set -euo pipefail

SNAP_ROOT="${SNAP_ROOT:-/var/backups/ever_export}"
REMOTE_USER="$1"
REMOTE_HOST="$2"
REMOTE_PORT="${3:-22}"
REMOTE_TARGET="${4:-/home/eversync/ever_export/}"

if [ -z "$REMOTE_USER" ] || [ -z "$REMOTE_HOST" ]; then
  echo "Usage: $0 <remote_user> <remote_host> [port] [remote_target]"
  exit 1
fi

echo "Finding latest snapshot on server..."
LATEST=$(ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "ls -1 ${SNAP_ROOT} 2>/dev/null | sort -r | head -n1")
if [ -z "$LATEST" ]; then
  echo "No snapshot found on server"
  exit 1
fi
echo "Restoring snapshot: $LATEST"
ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "rsync -av --delete ${SNAP_ROOT}/${LATEST}/ ${REMOTE_TARGET}"
echo "Rollback complete"
