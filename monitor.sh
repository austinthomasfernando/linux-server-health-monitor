#!/bin/bash

# ===============================
# Linux Server Health Monitor
# Version 1.0
# Author: Austin Thomas Fernando
# ===============================

# Colors
GREEN="\033[0;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m"

clear

echo -e "${BLUE}"
echo "=============================================="
echo "       Linux Server Health Monitor"
echo "=============================================="
echo -e "${NC}"
HOSTNAME=$(hostname)

echo -e "${GREEN}Hostname:${NC} $HOSTNAME"
CURRENT_DATE=$(date)

echo -e "${GREEN}Current Time:${NC} $CURRENT_DATE"
OS=$(uname -s)

echo -e "${GREEN}Operating System:${NC} $OS"
KERNEL=$(uname -r)

echo -e "${GREEN}Kernel Version:${NC} $KERNEL"
