#!/bin/bash

# Directory setup
AUDIO_DIR="./audio_files"
REF_IMAGE_1="./person1.jpg"
REF_IMAGE_2="./person2.jpg"
OUTPUT_DIR="./output"

# Loop through audio files and alternate images
index=0
for audio_file in "$AUDIO_DIR"/*.wav; do
  if (( index % 2 == 0 )); then
    ref_image="$REF_IMAGE_1"
  else
    ref_image="$REF_IMAGE_2"
  fi
  
  base_name=$(basename "$audio_file" .wav)
  output_path="$OUTPUT_DIR/${base_name}_output.mp4"

  # Run V-Express inference
  python3 inference.py \
    --reference_image_path "$ref_image" \
    --audio_path "$audio_file" \
    --output_path "$output_path" \
    --retarget_strategy "fix_face" \
    --num_inference_steps 2 \
    --reference_attention_weight 0.5 \
    --audio_attention_weight 1.0 \
    --save_gpu_memory

  ((index++))
done
