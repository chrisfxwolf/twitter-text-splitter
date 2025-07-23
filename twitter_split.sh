#!/bin/bash

#
#	 Twitter character limit (280) minus header space
#
# 	Author 	:: 	chrisfxwol
#	Version ::	1.0
#	Data  	::	23 July 2025
#
MAX_CHARS=270

# Function to display usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -f FILE    Read text from file"
    echo "  -h         Display this help message"
    echo ""
    echo "If no file is specified, the script will read from standard input."
    echo "Example: cat text.txt | $0"
}

# Parse command line arguments
FILE=""
while getopts "f:h" opt; do
    case $opt in
        f)
            FILE="$OPTARG"
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
    esac
done

# Read input text
if [ -n "$FILE" ]; then
    if [ ! -f "$FILE" ]; then
        echo "Error: File '$FILE' not found." >&2
        exit 1
    fi
    TEXT=$(cat "$FILE")
else
    # Read from stdin if no file provided
    TEXT=$(cat)
fi

# Remove extra whitespace and normalize
TEXT=$(echo "$TEXT" | sed 's/[[:space:]]\+/ /g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# If text is empty, exit
if [ -z "$TEXT" ]; then
    echo "Error: No text provided." >&2
    exit 1
fi

# Split text into words
read -ra WORDS <<< "$TEXT"

# Calculate number of posts needed
posts=()
current_post=""
current_length=0

for word in "${WORDS[@]}"; do
    word_length=${#word}
    
    # Check if adding this word would exceed the limit
    if [ $current_length -eq 0 ]; then
        # First word in post
        current_post="$word"
        current_length=$word_length
    elif [ $((current_length + 1 + word_length)) -le $MAX_CHARS ]; then
        # Add word to current post
        current_post="$current_post $word"
        current_length=$((current_length + 1 + word_length))
    else
        # Start new post
        posts+=("$current_post")
        current_post="$word"
        current_length=$word_length
    fi
done

# Add the last post if it exists
if [ -n "$current_post" ]; then
    posts+=("$current_post")
fi

# Get total number of posts
total_posts=${#posts[@]}

# Output posts with headers
for i in "${!posts[@]}"; do
    post_number=$((i + 1))
    echo "-- $post_number/$total_posts --"
    echo "${posts[$i]}"
    echo ""
done
