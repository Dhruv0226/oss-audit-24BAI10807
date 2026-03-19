#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Dhruv Sanjay Chaudhari | Reg No: 24BAI10807
# Course: Open Source Software | OSS Capstone Project
# Software Audited: Linux Kernel
# ============================================================

# --- Target package for this audit ---
# For Linux Kernel, we inspect the kernel image package itself
PACKAGE="linux-image-$(uname -r)"   # Dynamically get the running kernel's package name
GENERIC_PACKAGE="linux-image-generic"  # Fallback generic package name

echo "================================================================"
echo "         FOSS PACKAGE INSPECTOR                                  "
echo "================================================================"
echo ""

# --- Check if the running kernel package is installed using dpkg ---
# dpkg -l lists installed packages; grep -q returns exit code 0 if found
if dpkg -l "$PACKAGE" &>/dev/null; then
    echo "  [FOUND] Package: $PACKAGE"
    echo ""
    echo "  Package Details:"
    echo "  ----------------------------------------------------------------"
    # Use dpkg -s to show full status, pipe through grep to extract key fields
    dpkg -s "$PACKAGE" 2>/dev/null | grep -E 'Package|Version|Status|Maintainer|Description'
else
    # Fallback: check for the generic linux-image package
    echo "  Package '$PACKAGE' not found directly. Checking generic package..."
    echo ""
    if dpkg -l "$GENERIC_PACKAGE" &>/dev/null; then
        echo "  [FOUND] Package: $GENERIC_PACKAGE"
        dpkg -s "$GENERIC_PACKAGE" 2>/dev/null | grep -E 'Package|Version|Status|Maintainer|Description'
    else
        echo "  [INFO] The Linux Kernel is already running — it IS the OS foundation."
        echo "  Checking kernel version via uname instead:"
        echo ""
        echo "  Kernel Release : $(uname -r)"
        echo "  Kernel Version : $(uname -v)"
        echo "  Build Date     : $(uname -v | grep -oP '#\d+.*')"
    fi
fi

echo ""
echo "  ----------------------------------------------------------------"
echo "  ADDITIONAL SYSTEM PACKAGE INFO"
echo "  ----------------------------------------------------------------"

# Show number of installed packages for context
INSTALLED_COUNT=$(dpkg -l | grep "^ii" | wc -l)
echo "  Total installed packages on this system: $INSTALLED_COUNT"
echo ""

# --- Case statement: philosophy note based on package/software name ---
# This demonstrates the case construct for pattern matching
echo "  PHILOSOPHY NOTE"
echo "  ----------------------------------------------------------------"

# Normalize for case matching
case "linux-kernel" in
    linux-kernel)
        echo "  Linux Kernel: The collaborative miracle — millions of lines"
        echo "  of code maintained by thousands of volunteers and companies,"
        echo "  given freely to the world under GPL v2. Without it, the"
        echo "  modern internet would not exist as we know it."
        ;;
    httpd|apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Powering ~30% of all websites globally under Apache 2.0."
        ;;
    mysql)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual license model tells a story about commerce and community."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris — plays anything, anywhere."
        echo "  A testament to what open-source passion projects become."
        ;;
    firefox)
        echo "  Firefox: A non-profit fighting for an open, user-respecting web."
        ;;
    python3|python)
        echo "  Python: A language shaped entirely by community consensus."
        ;;
    git)
        echo "  Git: Linus built this when proprietary tools failed him."
        echo "  Now every developer on Earth depends on it."
        ;;
    *)
        echo "  Open source: software built in the open, for everyone."
        ;;
esac

echo ""
echo "================================================================"
