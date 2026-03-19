#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Dhruv Sanjay Chaudhari | Reg No: 24BAI10807
# Course: Open Source Software | OSS Capstone Project
# Software Audited: Linux Kernel
# ============================================================
# Usage: ./script4_log_analyzer.sh [logfile] [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# If no arguments given, defaults are used automatically.

# --- Handle command-line arguments with defaults ---
# $1 = first argument (log file path), default to /var/log/syslog
# $2 = second argument (keyword to search), default to "error"
LOGFILE="${1:-/var/log/syslog}"
KEYWORD="${2:-error}"

# --- Counter variables start at zero ---
COUNT=0          # Count of matching lines
TOTAL=0          # Count of total lines in file
MAX_RETRY=3      # Maximum retry attempts if file is empty
ATTEMPT=1        # Current attempt counter

echo "================================================================"
echo "         LOG FILE ANALYZER                                      "
echo "================================================================"
echo ""
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD'"
echo ""

# --- Validate that the file exists before proceeding ---
if [ ! -f "$LOGFILE" ]; then
    echo "  [ERROR] File not found: $LOGFILE"
    echo ""
    echo "  Trying alternative log files..."
    echo ""

    # Try common Ubuntu log file alternatives
    for ALT_LOG in /var/log/kern.log /var/log/auth.log /var/log/dmesg; do
        if [ -f "$ALT_LOG" ]; then
            echo "  [FOUND] Using alternative: $ALT_LOG"
            LOGFILE="$ALT_LOG"
            break   # Stop searching once we find one
        fi
    done

    # If still not found after trying alternatives, exit gracefully
    if [ ! -f "$LOGFILE" ]; then
        echo "  [FATAL] No suitable log file found. Exiting."
        exit 1
    fi
fi

# --- Do-while style retry loop if the file is empty ---
# Bash has no native do-while, so we use: while true + break
while true; do
    # Check if file is empty using -s (true if file exists and is non-empty)
    if [ -s "$LOGFILE" ]; then
        echo "  [OK] Log file has content. Starting analysis..."
        break   # File has content, exit the retry loop
    else
        # File is empty — inform user and count the attempt
        echo "  [WARN] Attempt $ATTEMPT/$MAX_RETRY: '$LOGFILE' is empty."

        # Check if we've exhausted all retries
        if [ "$ATTEMPT" -ge "$MAX_RETRY" ]; then
            echo "  [INFO] File is empty after $MAX_RETRY attempts."
            echo "  No data to analyze. Exiting gracefully."
            exit 0
        fi

        # Increment attempt counter and wait before retrying
        ATTEMPT=$((ATTEMPT + 1))
        sleep 1   # Wait 1 second before retrying
    fi
done

echo ""

# --- Main analysis: while-read loop goes through each line ---
# IFS= preserves leading/trailing whitespace in lines
# -r prevents backslash interpretation
while IFS= read -r LINE; do
    # Increment total line counter for every line read
    TOTAL=$((TOTAL + 1))

    # Check if the current line contains the keyword (case-insensitive with -i)
    # grep -iq: -i = case insensitive, -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment match counter
    fi

done < "$LOGFILE"   # Redirect file contents into the while loop as input

echo "  ANALYSIS COMPLETE"
echo "  ----------------------------------------------------------------"
echo "  Total lines scanned    : $TOTAL"
echo "  Lines matching '$KEYWORD' : $COUNT"

# Calculate percentage if total > 0 to avoid division by zero
if [ "$TOTAL" -gt 0 ]; then
    # Bash only does integer math; multiply by 100 first for whole-number %
    PERCENT=$(( COUNT * 100 / TOTAL ))
    echo "  Match percentage       : ~${PERCENT}%"
fi

echo ""

# --- Print last 5 matching lines using grep + tail ---
echo "  LAST 5 LINES CONTAINING '$KEYWORD':"
echo "  ----------------------------------------------------------------"

# grep -i = case-insensitive, then tail -5 = last 5 results
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" 2>/dev/null | tail -5)

if [ -n "$MATCHES" ]; then
    # -n checks if string is non-empty
    # Print each matching line with indentation
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  (No matching lines found for keyword '$KEYWORD')"
fi

echo ""
echo "================================================================"
echo "  Kernel log tip: run 'dmesg | grep -i error' for kernel errors"
echo "================================================================"
