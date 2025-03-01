#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Get the directory from the argument
directory=$1

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory $directory does not exist."
    exit 1
fi

# Print table header
echo "--------------------------------------------"
printf "| %-20s | %-6s | %-6s | %-6s |\n" "File Name" "Lines" "Words" "Chars"
echo "--------------------------------------------"

# Initialize total counters
total_lines=0
total_words=0
total_chars=0

# Loop through all text files in the directory
for file in "$directory"/*.txt; do
    # Check if there are any .txt files
    if [ ! -e "$file" ]; then
        echo "No .txt files found in $directory"
        exit 0
    fi

    # Get statistics using wc command
    stats=$(wc "$file")
    lines=$(echo "$stats" | awk '{print $1}')
    words=$(echo "$stats" | awk '{print $2}')
    chars=$(echo "$stats" | awk '{print $3}')
    filename=$(basename "$file")

    # Display file statistics
    printf "| %-20s | %-6s | %-6s | %-6s |\n" "$filename" "$lines" "$words" "$chars"

    # Accumulate totals
    total_lines=$((total_lines + lines))
    total_words=$((total_words + words))
    total_chars=$((total_chars + chars))
done

# Print total statistics
echo "--------------------------------------------"
printf "| %-20s | %-6s | %-6s | %-6s |\n" "Total" "$total_lines" "$total_words" "$total_chars"
echo "--------------------------------------------"
