# Twitter Text Splitter

A bash script that automatically divides long text into properly formatted Twitter/X posts with sequential numbering.

## Features

- ✂️ Splits long text into Twitter-sized chunks (280 characters including headers)
- 🔢 Automatically numbers posts (n/k format)
- 📁 Reads from files or standard input
- 🔄 Preserves word boundaries for readability
- 🐧 Works on Linux, macOS, and WSL
- 🆓 Open source and free to use

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/twitter-text-splitter.git
   cd twitter-text-splitter

## How to use

Ther is a servar method to use this script.

## Method 1: From a file
```bash
./twitter_split.sh -f your_text_file.txt
```

## Method 2: From standard input
```bash
echo "Your long text here" | ./twitter_split.sh
```

## Method 3: From a pipe
```bash
cat your_text_file.txt | ./twitter_split.sh
```

## If you need help type
```bash
./twitter_split.sh -h
```

