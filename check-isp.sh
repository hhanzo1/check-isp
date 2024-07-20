#!/bin/bash

ISP='8.8.8.8'
BASE_URL='https://uptimekuma.yourdomain.com/api/push/HhcsE3Mc3r?status=up&msg=OK&ping='

# Set up logging
LOG_FILE="/boot/config/plugins/user.scripts/scripts/check-isp/check-isp.log"
MAX_LOG_SIZE=1048576 # 1 MB

# Function to log messages
log() {
    local TIMESTAMP
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$TIMESTAMP $1" >> "$LOG_FILE"
}

# Function to check if log file exists and create if not
check_log_file() {
    if [ ! -f "$LOG_FILE" ]; then
        touch "$LOG_FILE"
    fi
}

# Function to check log file size and delete if it exceeds the limit
rotate_log_file() {
    if [ $(stat -c%s "$LOG_FILE") -ge $MAX_LOG_SIZE ]; then
        rm "$LOG_FILE"
        echo "Deleted $LOG_FILE due to size limit reached."
        touch "$LOG_FILE"
    fi
}

# Main script execution
check_log_file
rotate_log_file
log "START"
log "ISP: $ISP"
log "BASE_URL: $BASE_URL"

# Perform the ping test and extract the average ping time
PING_RESULT=$(ping -c 1 "$ISP" 2>/dev/null | awk -F'time=' '/time=/{ print $2 }' | awk '{ print $1 }')
PING_RESULT=${PING_RESULT:-'N/A'}

# Construct the request URL with the dynamic ping value
URL="${BASE_URL}${PING_RESULT}"
log "FULL_URL: $URL"

# Execute the HTTP request
RESPONSE=$(curl --max-time 5 -s -o /dev/null -w "%{http_code}" "$URL")
if [ $? -eq 0 ]; then
    log "CURL command executed. Response status: $RESPONSE"
else
    log "Failed to execute CURL command."
fi
