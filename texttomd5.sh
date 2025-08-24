#!/bin/bash

# Example Of Running The Script: ./texttomd5.sh words.txt output.txt
input_filepath="$1"
output_filepath="$2" # Optional output file path


echo "Calculating MD5 hashes for words in: $input_filepath"


if [ -n "$output_filepath" ]; then
  echo "Output will be saved to: $output_filepath"
  exec 3>&1 
  exec > "$output_filepath"  
else
  echo "Output will be printed to console."
fi

while IFS= read -r word; do
  if [ -z "$word" ]; then
    continue
  fi

  hash=$(echo -n "$word" | md5sum | awk '{print $1}')
  echo "Word: \"$word\" -> MD5 Hash: $hash"
done < "$input_filepath"


if [ -n "$output_filepath" ]; then
  exec 1>&3
fi

echo "MD5 hashes generated for all words in the file."
