#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 <query> <key> <output>"
  exit 1
fi

query="$1"
key="$2"
output="$3"

python intelx-crawls.py -q "$query" -k "$key" -o "$(pwd)/output/$output"
sort "$(pwd)/output/$output" | uniq -u > "$(pwd)/output/unique.txt"
grep -i "$query" "$(pwd)/output/unique.txt" > "$(pwd)/output/result.txt"