#!/bin/bash
# This script builds a timeline of when attacks occurred.

INPUT_FILE=$1

# Find failed password lines.
# Extract the timestamp (first column) and isolate the hour (characters before the colon).
# Count occurrences and print.

grep "Failed password" "$INPUT_FILE" | cut -d' ' -f2 | cut -d':' -f1 | sort | uniq -c | while read COUNT HOUR; do
    echo "Hour $HOUR: $COUNT failed attempts"
done
