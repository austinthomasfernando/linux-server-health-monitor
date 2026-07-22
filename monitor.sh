#!/bin/bash

# ==================================================
# Linux Server Health Monitor
# Version : 2.1
# Author  : Austin Thomas Fernando
# ==================================================

# ---------- Colors ----------
GREEN="\033[0;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m"

# ---------- Basic Information ----------
HOSTNAME=$(hostname)
CURRENT_DATE=$(date)
OS=$(uname -s)
KERNEL=$(uname -r)
UPTIME=$(uptime)

clear

echo -e "${BLUE}"
echo "=================================================="
echo "          Linux Server Health Monitor"
echo "=================================================="
echo -e "${NC}"

echo -e "${GREEN}Hostname         :${NC} $HOSTNAME"
echo -e "${GREEN}Operating System :${NC} $OS"
echo -e "${GREEN}Kernel Version   :${NC} $KERNEL"
echo -e "${GREEN}Current Time     :${NC} $CURRENT_DATE"

echo ""
echo "--------------------------------------------------"
echo "SYSTEM HEALTH"
echo "--------------------------------------------------"

# ==================================================
# Linux
# ==================================================
if [[ "$OS" == "Linux" ]]; then

    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2+$4}')

    MEMORY=$(free -h | awk '/Mem:/ {print $3 " / " $2}')

    DISK=$(df -h / | awk 'NR==2 {print $5}')

    IP=$(hostname -I | awk '{print $1}')

# ==================================================
# macOS
# ==================================================
else

    # CPU Usage
    CPU=$(top -l 1 | awk '/CPU usage/ {print $3}')

    # Installed RAM
    TOTAL_RAM=$(sysctl -n hw.memsize)

    if command -v bc >/dev/null 2>&1; then
        MEMORY=$(echo "scale=2; $TOTAL_RAM/1024/1024/1024" | bc)
    else
        MEMORY=$(awk "BEGIN {printf \"%.2f\", $TOTAL_RAM/1024/1024/1024}")
    fi

    DISK=$(df -h / | awk 'NR==2 {print $5}')

    IP=$(ipconfig getifaddr en0 2>/dev/null)

    if [ -z "$IP" ]; then
        IP=$(ipconfig getifaddr en1 2>/dev/null)
    fi

fi

echo -e "${GREEN}CPU Usage        :${NC} $CPU"

if [[ "$OS" == "Linux" ]]; then
    echo -e "${GREEN}Memory Usage     :${NC} $MEMORY"
else
    echo -e "${GREEN}Installed RAM    :${NC} ${MEMORY} GB"
fi

echo -e "${GREEN}Disk Usage       :${NC} $DISK"
echo -e "${GREEN}System Uptime    :${NC} $UPTIME"

echo ""
echo "--------------------------------------------------"
echo "TOP 5 CPU PROCESSES"
echo "--------------------------------------------------"

if [[ "$OS" == "Linux" ]]; then
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
else
    ps -Ao pid,comm,%cpu | sort -k3 -nr | head -6
fi

echo ""
echo "--------------------------------------------------"
echo "NETWORK"
echo "--------------------------------------------------"

echo -e "${GREEN}IP Address       :${NC} ${IP:-Not Found}"

if ping -c 1 google.com >/dev/null 2>&1; then
    echo -e "${GREEN}Internet         : Connected${NC}"
else
    echo -e "${RED}Internet         : Disconnected${NC}"
fi

echo ""
echo "--------------------------------------------------"
echo "STATUS"
echo "--------------------------------------------------"

echo -e "${GREEN}✓ CPU Check Completed${NC}"
echo -e "${GREEN}✓ Memory Check Completed${NC}"
echo -e "${GREEN}✓ Disk Check Completed${NC}"
echo -e "${GREEN}✓ Network Check Completed${NC}"

echo ""
echo -e "${BLUE}Health Monitor Finished Successfully${NC}"