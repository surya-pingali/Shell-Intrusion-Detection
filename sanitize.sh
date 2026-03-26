#!/bin/bash
# This script cleans the raw authentication log.

# The first argument passed to the script is the input file.
INPUT_FILE=$1

# sed performs multiple operations using the -e flag:
# 1. /\[CORRUPT-DATA\]/d deletes lines with the corrupt tag.
# 2. s/user=root/user=SYS_ADMIN/g replaces root with SYS_ADMIN.
# 3. s/user=admin/user=SYS_ADMIN/g replaces admin with SYS_ADMIN.
# 4. s/|/,/g replaces all pipe symbols with commas.
# The result is saved to clean_log.csv.

sed -e '/\[CORRUPT-DATA\]/d' \
    -e 's/user=root/user=SYS_ADMIN/g' \
    -e 's/user=admin/user=SYS_ADMIN/g' \
    -e 's/|/,/g' "$INPUT_FILE" > clean_log.csv
