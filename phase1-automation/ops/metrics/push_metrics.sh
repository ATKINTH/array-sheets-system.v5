#!/usr/bin/env bash
# push_metrics.sh
PUSHGATEWAY_URL="${PUSHGATEWAY_URL:-http://pushgateway.example.org:9091/metrics/job/ever_push}"
HOST="$(hostname -s)"
LAST_STATUS="$1"  # success/fail
METHOD="$2"       # rsync/scp/rclone/transfer

cat <<EOF | curl --data-binary @- "${PUSHGATEWAY_URL}"
# TYPE ever_push_last_status gauge
ever_push_last_status{host="${HOST}",method="${METHOD}"} $( [ "$LAST_STATUS" = "success" ] && echo 1 || echo 0 )
# TYPE ever_push_last_timestamp gauge
ever_push_last_timestamp{host="${HOST}",method="${METHOD}"} $(date +%s)
EOF
