#!/bin/bash


# Function to display usage

usage(){

	echo " USAGE :$0 /home/ubuntu/logs/day10.log "
	exit 1
}

# Check if the log file path is provided

if [ $# -ne 1 ]; then
	usage
fi

LOG_FILE=$1

# Check if the log file exists

if [ ! -f "$LOG_FILE" ]; then

	echo "Error: Log File $LOG_FILE does not exits."
	exit 1
fi

# Variables

ERROR_KEYWORD="ERROR"
CRITICAL_KEYWORD="CRITICAL"
DATE=$(date +"%Y-%m-%d")
SUMMARY_REPORT="summary_report_$DATE.txt"
ARCHIVE_DIR='processed_logs'

# Create a summary report
{
	echo "Date of analysis: $DATE"
	echo "Log File Name: $LOG_FILE"

} > "$SUMMARY_REPORT"

# Total Line Processed
TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "Total Line Processed: $TOTAL_LINES" >> "$SUMMARY_REPORT"

# Count the number of ERROR message
ERROR_COUNT=$(grep -c "$ERROR_KEYWORD" "$LOG_FILE")
echo "Total error count: $ERROR_COUNT" >> "$SUMMARY_REPORT"

# list the Critical events with line numbers
echo "List of Critical events with line numbers:" >> "$SUMMARY_REPORT"
grep -n "$CRITICAL_KEYWORD" "$LOG_FILE" >> "$SUMMARY_REPORT"


# Identify the top 5 most comman error messages

declare -A error_messages
while IFS= read -r line; do
	if [[ "$line" == *"$ERROR_KEYWORD"* ]]; then
		message=$(echo "$line" | awk -F"$ERROR_KEYWORD" '{print $2}' )
		((error_messages["$message"]++))
	fi
done < "$LOG_FILE"


# Sort & Display top 5 error messages
echo "Top 5 error Messages with their occurance count: " >> "$SUMMARY_REPORT"

for message in "${!error_messages[@]}"; do
	echo "${error_messages[$message]} $message"
done | sort -rn | head -n 5 >> "$SUMMARY_REPORT"

# Optional: Archive or move processed log files
if [ ! -d "$ARCHIVE_DIR" ]; then
	mkdir -p "$ARCHIVE_DIR"
fi
mv "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file has been moved to $ARCHIVE_DIR."

# Print the Summary Report
cat "$SUMMARY_REPORT"




