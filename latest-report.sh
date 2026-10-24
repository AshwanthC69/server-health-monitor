#!/bin/bash

LOG_FILE="$HOME/cloud-lab/server-health-monitor/health-report.log"

awk '
/^===== SERVER HEALTH REPORT =====$/ {
    report = $0 ORS
    next
}
{
    report = report $0 ORS
}
/^===== END OF REPORT =====$/ {
    latest = report
}
END {
    printf "%s", latest
}' "$LOG_FILE"
