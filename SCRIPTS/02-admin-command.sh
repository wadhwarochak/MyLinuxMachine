#!/usr/bin/env bash
###############################################################################
# Script Name   : system_stats.sh
# Description   : Displays system health and resource usage for Linux admin
# Author        : Rochak Wadhwa
# Created Date  : 2025-03-15
# Version       : 1.0
###############################################################################

set -euo pipefail
IFS=$'\n\t'

echo "===================================================="
echo "        SYSTEM STATUS REPORT"
echo "        Host: $(hostname)"
echo "        Date: $(date)"
echo "===================================================="

# OS & Kernel
echo -e "\n--- OS & Kernel ---"
uname -a
echo "Uptime : $(uptime -p)"

# CPU Usage
echo -e "\n--- CPU Usage ---"
top -bn1 | grep "Cpu(s)" | \
awk '{print "User: "$2"% | System: "$4"% | Idle: "$8"%"}'

# Load Average
echo -e "\n--- Load Average ---"
uptime | awk -F'load average:' '{ print $2 }'

# Memory Usage
echo -e "\n--- Memory Usage ---"
free -h

# Disk Usage
echo -e "\n--- Disk Usage (Mounted Filesystems) ---"
df -h | grep -E '^Filesystem|^/dev/'

# Top 5 Memory-Consuming Processes
echo -e "\n--- Top 5 Processes by Memory ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Top 5 CPU-Consuming Processes
echo -e "\n--- Top 5 Processes by CPU ---"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

# Network Information
echo -e "\n--- Network Information ---"
ip -brief address

# Logged-in Users
echo -e "\n--- Logged-in Users ---"
who

# Disk Inode Usage
echo -e "\n--- Inode Usage ---"
df -ih | grep -E '^Filesystem|^/dev/'

echo -e "\n===================================================="
echo "        END OF REPORT"
echo "===================================================="

