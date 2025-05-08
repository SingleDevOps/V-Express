import os
import subprocess

AUDIO_DIR = "./audio_files"
REF_IMAGE_1 = "./person1.jpg"
REF_IMAGE_2 = "./person2.jpg"
OUTPUT_DIR = "./output"

# Create output directory if it doesn't exist
os.makedirs(OUTPUT_DIR, exist_ok=True)

audio_files = [f for f in os.listdir(AUDIO_DIR) if f.lower().endswith('.mp3')]

for index, audio_file in enumerate(audio_files):
    ref_image = REF_IMAGE_1 if index % 2 == 0 else REF_IMAGE_2
    base_name = os.path.splitext(audio_file)[0]
    output_path = os.path.join(OUTPUT_DIR, f"{base_name}_output.mp4")
    audio_path = os.path.join(AUDIO_DIR, audio_file)

    cmd = [
        "python", "inference.py",
        "--reference_image_path", ref_image,
        "--audio_path", audio_path,
        "--output_path", output_path,
        "--retarget_strategy", "fix_face",
        "--num_inference_steps", "3",
        "--reference_attention_weight", "0.5",
        "--audio_attention_weight", "1.0",
        "--image_size", "128",
        "--save_gpu_memory"
    ]

    print(f"Processing {audio_file} with {ref_image}...")
    subprocess.run(cmd, check=True)

print("All files processed.")
