import json
import os
import requests

# Configuration
JSON_FILE = "coingecko.json"       # Path to your JSON file
OUTPUT_DIR = "../server/downloaded_images"  # Folder to save the images

# Ensure output directory exists
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Read and parse JSON
with open(JSON_FILE, "r") as file:
    data = json.load(file)

# Download each image
for i, item in enumerate(data):
    url = item.get("image")
    if not url:
        print(f"Skipping entry {i} - no image field")
        continue
        download(url)
def url_to_name():
    name = url.split('?')[0].split('/')
    return name[len(name)-1]
def download(url):
    try:
        filename = url_to_name(url)

        # Get image extension from URL

        filepath = os.path.join(OUTPUT_DIR, filename)
        if os.path.exists(filepath):
            return

        response = requests.get(url, timeout=10)
        response.raise_for_status()

        # Save the image
        with open(filepath, "wb") as f:
            f.write(response.content)
        print(f"Downloaded: {i} {filename}")
    except Exception as e:
        print(f"Failed to download {url}: {e}")
