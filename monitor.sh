#!/bin/bash

# ==============================================
# Linux Server Health Monitor
# Author: Austin Thomas Fernando
# ==============================================

# Colors
GREEN="\033[0;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m"

# Variables
HOSTNAME=$(hostname)
CURRENT_DATE=$(date)
OS=$(uname -s)
KERNEL=$(uname -r)

clear

echo -e "${BLUE}"
echo "=============================================="
echo "      Linux Server Health Monitor"
echo "=============================================="
echo -e "${NC}"

echo -e "${GREEN}Hostname         :${NC} $HOSTNAME"
echo -e "${GREEN}Operating System :${NC} $OS"
echo -e "${GREEN}Kernel Version   :${NC} $KERNEL"
echo -e "${GREEN}Current Time     :${NC} $CURRENT_DATE"
