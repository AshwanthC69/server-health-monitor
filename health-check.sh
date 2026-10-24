#!/bin/bash

LOG_FILE="$HOME/cloud-lab/server-health-monitor/health-report.log"
exec > >(tee -a "$LOG_FILE") 2>&1
set -o pipefail

echo "===== SERVER HEALTH REPORT ====="
echo "Date: $(date)"
echo

echo "--- Disk Usage ---"
df -h /

usage=$(df / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

if ! [[ "$usage" =~ ^[0-9]+$ ]]; then
    echo "DISK STATUS: ERROR (Unable to read disk usage)"
elif [ "$usage" -ge 90 ]; then
    echo "DISK STATUS: CRITICAL ($usage% used)"
elif [ "$usage" -ge 80 ]; then
    echo "DISK STATUS: WARNING ($usage% used)"
else
    echo "DISK STATUS: HEALTHY ($usage% used)"
fi

echo
echo "--- Memory Usage ---"
free -h

mem_usage=$(free | awk '/^Mem:/ {printf "%.0f", ($2-$7)*100/$2}')

if ! [[ "$mem_usage" =~ ^[0-9]+$ ]]; then
    echo "MEMORY STATUS: ERROR (Unable to read memory usage)"
elif [ "$mem_usage" -ge 90 ]; then
    echo "MEMORY STATUS: CRITICAL ($mem_usage% used)"
elif [ "$mem_usage" -ge 80 ]; then
    echo "MEMORY STATUS: WARNING ($mem_usage% used)"
else
    echo "MEMORY STATUS: HEALTHY ($mem_usage% used)"
fi

echo
echo "--- System Load ---"
uptime

load=$(uptime | awk -F'load average: ' '{print $2}' | cut -d',' -f1 | xargs)

if ! [[ "$load" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "CPU LOAD STATUS: ERROR (Unable to read system load)"
elif awk -v cpu_load="$load" 'BEGIN {exit !(cpu_load > 4)}'; then
    echo "CPU LOAD STATUS: WARNING (Load: $load)"
else
    echo "CPU LOAD STATUS: HEALTHY (Load: $load)"
fi

echo "===== END OF REPORT ====="
