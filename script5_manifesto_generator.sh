#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: Dhruv Sanjay Chaudhari | Reg No: 24BAI10807
# Course: Open Source Software | OSS Capstone Project
# Software Audited: Linux Kernel
# ============================================================
# This script asks the user three questions interactively,
# then generates a personalised open source philosophy
# statement and saves it to a .txt file.

# --- Aliases concept (demonstrated via comment and local function) ---
# In real shell usage: alias lsl='ls -la' creates a shorthand command.
# Here we define a helper function as a "script alias" for repeated output.
print_divider() {
    echo "================================================================"
}

print_divider
echo "         OPEN SOURCE MANIFESTO GENERATOR                       "
print_divider
echo ""
echo "  Answer three questions to generate your personal manifesto."
echo "  Your answers will be woven into a philosophy statement."
echo ""

# --- Interactive input using 'read' ---
# -p flag shows the prompt text before waiting for input

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Get metadata for the manifesto document ---
DATE=$(date '+%d %B %Y')           # Formatted date e.g. 19 March 2026
USER_NAME=$(whoami)                 # Get the current username
OUTPUT="manifesto_${USER_NAME}.txt"  # Dynamic output filename using string concatenation

print_divider
echo "  Generating your manifesto..."
echo ""

# --- Compose the manifesto paragraph using string concatenation ---
# We build it line-by-line using >> (append) to the output file
# First use > (overwrite) to start fresh, then >> (append) for each line

# Clear/create the file fresh
> "$OUTPUT"

# Write the manifesto content to the file using echo and >>
echo "================================================================" >> "$OUTPUT"
echo "   MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "   Generated on: $DATE" >> "$OUTPUT"
echo "   Author: $USER_NAME" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "I believe in the philosophy of open source software." >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Paragraph 1: personal connection to open source
echo "Every day, I rely on $TOOL — a piece of software that someone" >> "$OUTPUT"
echo "chose to build openly and share with the world at no cost." >> "$OUTPUT"
echo "That choice was not an accident. It was a statement: that knowledge" >> "$OUTPUT"
echo "belongs to everyone, that tools should be transparent, and that" >> "$OUTPUT"
echo "technology is strongest when it is built collectively." >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Paragraph 2: personal philosophy using their one-word answer
echo "To me, freedom in the context of software means $FREEDOM." >> "$OUTPUT"
echo "The Linux Kernel, which powers everything from supercomputers to" >> "$OUTPUT"
echo "smartphones, embodies this. Its source code is readable, modifiable," >> "$OUTPUT"
echo "and redistributable by anyone on Earth. No corporation owns it." >> "$OUTPUT"
echo "No single person controls it. It belongs to all of us." >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Paragraph 3: their contribution promise
echo "I commit to carrying this philosophy forward. One day, I will build" >> "$OUTPUT"
echo "$BUILD — and I will share it freely, just as those who came before" >> "$OUTPUT"
echo "me shared their work with me. Standing on the shoulders of giants" >> "$OUTPUT"
echo "means accepting the responsibility to lift others in turn." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Open source is not just a license. It is a way of thinking." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "   'Free software is a matter of liberty, not price.'" >> "$OUTPUT"
echo "   — Richard M. Stallman, GNU Project" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# --- Confirm and display the manifesto ---
echo "  [SAVED] Manifesto written to: $OUTPUT"
echo ""
print_divider
echo ""

# Display the full manifesto using cat
cat "$OUTPUT"

echo ""
print_divider
echo "  Your manifesto has been saved. Add it to your project report!"
print_divider
