# Shell Based Intrusion Detection System

## Overview
This repository contains a shell-based Intrusion Detection System (IDS) designed to analyze authentication logs, identify brute-force attackers, and generate a firewall script to block them. The system automates log forensics utilizing shell scripting utilities, specifically `sed`, `grep`, and `awk`, combined with shell loops and conditional logic. This project was developed for the CS253 course at the Indian Institute of Technology Kanpur.

## Features
The system processes data through four primary functional scripts:

* **Log Sanitization (`sanitize.sh`):** Cleans raw authentication logs by deleting corrupted data lines. It anonymizes privileged accounts by masking `root` and `admin` as `SYS_ADMIN`. It also converts pipe delimiters to commas to enforce a standard CSV-like format.
* **Brute Force Detection (`detect.sh`):** Parses the sanitized log to count failed password events for each unique IP address. It filters for IP addresses that strictly exceed 10 failed attempts. A manual shell loop cross-references these identified IPs against a provided whitelist. If a suspect IP is not whitelisted, a blocking `iptables` command is generated and appended to a firewall rules output file.
* **Port Target Analysis (`report.sh`):** Reads the sanitized log and generates a summary of the targeted ports for all failed login attempts. The output is printed as a formatted table to the terminal.
* **Threat Timeline Generation (`timeline.sh`):** Isolates all failed password attempts. It extracts the two-digit hour from the timestamp of each event. The script then aggregates and prints the total number of failed requests made in each hour of the day in ascending order.

## Prerequisites
Execution requires a Unix/Linux-based shell environment (e.g., native Linux, macOS Terminal, Windows Subsystem for Linux, or Git Bash). The following standard POSIX utilities must be available:
* `bash`
* `sed`
* `grep`
* `awk`
* `cut`
* `sort`
* `uniq`
* `tr`

## Usage
The scripts must be executed sequentially. Ensure all script files possess execution permissions before running.

```bash
chmod +x sanitize.sh detect.sh report.sh timeline.sh
```

**1. Sanitize the raw log:**
```bash
./sanitize.sh auth.log
```

**2. Detect attackers and generate firewall rules:**
```bash
./detect.sh clean_log.csv whitelist.txt firewall_rules.sh
```

**3. Generate the targeted port analysis:**
```bash
./report.sh
```

**4. Generate the chronological threat timeline:**
```bash
./timeline.sh clean_log.csv
```
