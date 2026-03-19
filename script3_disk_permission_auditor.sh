#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Dhruv Sanjay Chaudhari | Reg No: 24BAI10807
# Course: Open Source Software | OSS Capstone Project
# Software Audited: Linux Kernel
# ============================================================

# --- List of important system directories to audit ---
# These are standard FHS (Filesystem Hierarchy Standard) directories
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/lib/modules")

echo "================================================================"
echo "         DISK AND PERMISSION AUDITOR                            "
echo "================================================================"
echo ""
echo "  Auditing standard Linux system directories..."
echo "  Format: permissions  owner  group | Size"
echo ""
printf "  %-20s %-30s %s\n" "DIRECTORY" "PERMISSIONS (type owner group)" "SIZE"
echo "  ----------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do
    # Check if the directory actually exists before inspecting it
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls -ld and awk
        # awk '{print $1, $3, $4}' picks columns: perms, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Get human-readable disk usage; 2>/dev/null suppresses permission errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted output; left-align with printf for neat columns
        printf "  %-20s %-30s %s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo ""
echo "================================================================"
echo "  LINUX KERNEL SPECIFIC DIRECTORY CHECK                        "
echo "================================================================"
echo ""
echo "  The Linux Kernel stores key files in specific locations."
echo "  Checking them now..."
echo ""

# --- Array of kernel-specific paths to inspect ---
KERNEL_PATHS=(
    "/boot"               # Kernel images and bootloader config live here
    "/lib/modules"        # Loadable kernel modules (.ko files) live here
    "/proc"               # Virtual filesystem: live kernel/process data
    "/sys"                # Virtual filesystem: hardware and kernel parameters
    "/etc/sysctl.conf"    # Kernel runtime parameter configuration file
    "/etc/modprobe.d"     # Module loading configuration directory
)

# Loop through kernel-specific paths
for KPATH in "${KERNEL_PATHS[@]}"; do
    if [ -e "$KPATH" ]; then
        # -e checks if path exists (works for files AND directories)
        TYPE="file"
        [ -d "$KPATH" ] && TYPE="dir"  # Override type if it's a directory

        # Get permissions using ls -ld (works for both files and dirs)
        KPERMS=$(ls -ld "$KPATH" | awk '{print $1, $3, $4}')
        KSIZE=$(du -sh "$KPATH" 2>/dev/null | cut -f1)

        printf "  %-30s [%s] perms=%-25s size=%s\n" "$KPATH" "$TYPE" "$KPERMS" "${KSIZE:-N/A}"
    else
        printf "  %-30s [not found]\n" "$KPATH"
    fi
done

echo ""
echo "  ----------------------------------------------------------------"
echo "  KEY INSIGHT: The Linux Kernel runs as root (UID 0)."
echo "  /boot is owned by root to prevent tampering."
echo "  /proc and /sys expose live kernel data — read-only for users."
echo "  /lib/modules holds drivers that can be loaded/unloaded safely."
echo "================================================================"
