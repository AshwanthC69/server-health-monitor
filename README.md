# Server Health Monitor

## Project Overview
A beginner-friendly Bash project that monitors system health on Linux and generates a report.

## Features
- Checks disk usage.
- Checks memory usage.
- Checks system load.
- Displays health statuses.
- Validates parsed values.
- Saves reports automatically to a log file.
- Displays the latest complete report.

## Technologies Used
- Linux (Ubuntu on WSL)
- Bash scripting
- Linux commands: `df`, `free`, `uptime`, `awk`, `grep`, `tee`

## Project Files
- `health-check.sh` — runs the health checks.
- `health-report.log` — stores health reports.
- `latest-report.sh` — displays the latest complete report.

## How to Run

Run the health monitor:

```bash
./health-check.sh
```

View the latest report:

```bash
./latest-report.sh
```

View the saved reports:

```bash
cat health-report.log
```

## Health Thresholds
- Disk and memory: below 80% is healthy, 80–89% is warning, and 90% or higher is critical.
- System load: above 4 triggers a warning.

## Learning Outcomes
Practiced Bash scripting, Linux system monitoring, conditional statements, input validation, logging, and basic debugging.

## Limitations
This project currently monitors the Linux environment where it runs. Automated scheduling and external alerts are not implemented.

