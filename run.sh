#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 <query> <key> <output>"
  exit 1
fi

query="$1"
key="$2"
output="$3"

mkdir $query

python intelx-crawls.py -q "$query" -k "$key" -o "$(pwd)/$query/$output"
sort "$(pwd)/$query/$output" | uniq -u > "$(pwd)/$query/unique.txt"
grep -i "$query" "$(pwd)/$query/unique.txt" > "$(pwd)/$query/result.txt"