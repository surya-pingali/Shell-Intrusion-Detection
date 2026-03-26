#!/bin/bash
# This script detects attackers and generates firewall rules.

CLEAN_LOG=$1
WHITELIST=$2
OUTPUT_FILE=$3

# Clear the output file to start fresh
> "$OUTPUT_FILE"

# 1. Isolate "Failed password" lines.
# 2. Extract the IP address using grep and cut.
# 3. Count occurrences of each IP using sort and uniq.
# 4. Use awk to filter only IPs with more than 10 failures.
grep "Failed password" "$CLEAN_LOG" | grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | awk '$1 > 10 {print $1, $2}' | while read COUNT IP; do
    
    # Manually check the whitelist using a loop
    IS_SAFE=0
    while read SAFE_IP; do
        # Remove empty spaces from the whitelist IP
        SAFE_IP=$(echo "$SAFE_IP" | tr -d '\r ')
        if [ "$IP" = "$SAFE_IP" ]; then
            IS_SAFE=1
            break
        fi
    done < "$WHITELIST"

    # If the IP was not found in the whitelist, generate the block rule
    if [ $IS_SAFE -eq 0 ]; then
        echo "iptables -A INPUT -s $IP -j DROP # Blocked after $COUNT failed attempts" >> "$OUTPUT_FILE"
    fi
done