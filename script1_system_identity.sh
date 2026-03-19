#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Dhruv Sanjay Chaudhari | Reg No: 24BAI10807
# Course: Open Source Software | OSS Capstone Project
# Software Audited: Linux Kernel
# ============================================================

# --- Student Information Variables ---
STUDENT_NAME="Dhruv Sanjay Chaudhari"         # Replace with your name
REG_NO="24BAI10807"             # Replace with your registration number
SOFTWARE_CHOICE="Linux Kernel"     # The open-source software being audited

# --- Gather System Information using command substitution $() ---
KERNEL=$(uname -r)                          # Current Linux kernel version
DISTRO=$(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
USER_NAME=$(whoami)                          # Currently logged-in username
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable system uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Formatted current date
CURRENT_TIME=$(date '+%H:%M:%S %Z')         # Formatted current time
ARCH=$(uname -m)                            # System architecture (e.g. x86_64)
HOSTNAME=$(hostname)                        # Machine hostname

# --- Display the Welcome Banner ---
echo "================================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT            "
echo "================================================================"
echo ""

# --- Student Info Section ---
echo "  Student   : $STUDENT_NAME"
echo "  Reg No    : $REG_NO"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "----------------------------------------------------------------"

# --- System Info Section ---
echo "  SYSTEM INFORMATION"
echo "----------------------------------------------------------------"
echo "  Hostname      : $HOSTNAME"
echo "  Distribution  : $DISTRO"
echo "  Kernel Version: $KERNEL"
echo "  Architecture  : $ARCH"
echo ""

# --- User Info Section ---
echo "  USER INFORMATION"
echo "----------------------------------------------------------------"
echo "  Logged-in User: $USER_NAME"
echo "  Home Directory: $HOME_DIR"
echo ""

# --- Time and Uptime Section ---
echo "  TIME & UPTIME"
echo "----------------------------------------------------------------"
echo "  Current Date  : $CURRENT_DATE"
echo "  Current Time  : $CURRENT_TIME"
echo "  System Uptime : $UPTIME"
echo ""

# --- License Section ---
# The Linux Kernel is licensed under GPL v2 (GNU General Public License version 2)
echo "  OPEN SOURCE LICENSE"
echo "----------------------------------------------------------------"
echo "  The Linux Kernel is licensed under the"
echo "  GNU General Public License version 2 (GPL v2)."
echo ""
echo "  This means:"
echo "  - You are FREE to use, study, modify, and redistribute it."
echo "  - Any modified version you distribute MUST also be GPL v2."
echo "  - The source code must always be available to recipients."
echo "  - No user can be denied these four freedoms."
echo ""
echo "================================================================"
echo "  'Free as in freedom, not free as in free beer.' — R. Stallman"
echo "================================================================"
