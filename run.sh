#!/bin/bash
#script: ABul
# File containing the list of directories
PATHS_FILE="paths.txt"

# Log file
LOG_FILE="delete_old_files_$(date +%Y-%m-%d-%H-%M-%S).log"

# Start Logging
echo "Starting script at $(date)" | tee -a $LOG_FILE
echo "Checking for files older than 5 months in directories listed in $PATHS_FILE..." | tee -a $LOG_FILE

# Cutoff date for files (5 months ago in YYYY-MM-DD format)
CUTOFF_DATE=$(date --date='5 months ago' +%Y-%m-%d)

# Read each path from the file
while IFS= read -r DIR
do
  echo "Checking directory: $DIR" | tee -a $LOG_FILE
  # Find files older than the cutoff date and delete them
  find "$DIR" -type f -mtime +150 -print | tee -a $LOG_FILE
  find "$DIR" -type f -mtime +150 -exec rm {} \; | tee -a $LOG_FILE
done < "$PATHS_FILE"

echo "Deletion process completed." | tee -a $LOG_FILE
