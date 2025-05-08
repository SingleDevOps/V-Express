#!/bin/bash

mkdir -p processed_ts
rm -f file_list.txt

for i in {1..50}; do
  input="output/output_${i}_output.mp4"
  output="processed_ts/output_${i}.ts"

  ffmpeg -i "$input" -c copy -bsf:v h264_mp4toannexb -f mpegts "$output"
  
  echo "file '$output'" >> file_list.txt
done

# Now concatenate them into a single MP4
ffmpeg -f concat -safe 0 -i file_list.txt -c copy final_output.mp4
