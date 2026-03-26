#!/bin/bash
# This script summarizes the targeted ports for failed logins.

echo "Target Port Analysis"
echo "--------------------"

# Extract lines with failed passwords.
# Search for the word 'port' followed by an equals sign and numbers.
# Clean the text, count the occurrences, sort descending by count, and print the formatted table.

grep "Failed password" clean_log.csv | grep -o 'port[ =]*[0-9]*' | tr -d ' ' | cut -d'=' -f2 | sort | uniq -c | sort -nr | while read COUNT PORT; do
    printf "Port %-5s : %d attempts\n" "$PORT" "$COUNT"
done
