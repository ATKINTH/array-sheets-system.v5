#!/usr/bin/env bash
set -euo pipefail
#
# push_reports_full.sh
# Hybrid push: rsync -> scp -> rclone -> transfer.sh
#
LOCAL_DIR="${LOCAL_DIR:-./reports}"
SNAP_ROOT="${SNAP_ROOT:-/var/backups/ever_export}"
LOG_DIR="${LOG_DIR:-$HOME/ever_setup_logs}"
mkdir -p "$LOG_DIR"
mkdir -p "$SNAP_ROOT"

timestamp() { date +"%Y%m%d_%H%M%S"; }
log() { echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] $*" | tee -a "$LOG_DIR/push_reports.log"; }

usage() {
  cat <<EOF
Usage: $0 --host host --user user [--port port] [--remote-dir path]
This script tries: rsync (ssh) -> scp -> rclone (cloud remote) -> transfer.sh (fallback)
Secrets and keys must be configured out of band. This script never writes secrets to repo.
EOF
}

# (วางส่วนที่เหลือของไฟล์ครบตามที่ให้ก่อนหน้า)
