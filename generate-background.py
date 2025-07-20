import os
import requests
from datetime import datetime
from PIL import Image, ImageDraw, ImageFont
from io import BytesIO

ACCESS_KEY = "l3LHpNYnNkrn4Et44jIZ2gN172knUok1u2xEqFReCr0"  # Replace with your key
OUTPUT_PATH = os.path.expanduser("~/zoom_background.jpg")
FALLBACK_IMAGE = os.path.expanduser("~/office/fallback.jpg")

QUOTES = [
    "Believe you can and you're halfway there.",
    "Success is the sum of small efforts repeated.",
    "Stay positive. Work hard. Make it happen.",
    "You are stronger than you think.",
]

# Determine theme based on time
hour = datetime.now().hour
if hour < 12:
    query = "morning landscape"
elif hour < 18:
    query = "afternoon city"
else:
    query = "evening sky"

quote = QUOTES[hour % len(QUOTES)]

# Unsplash API URL
url = "https://api.unsplash.com/photos/random"
params = {
    "query": query,
    "orientation": "landscape",
    "client_id": ACCESS_KEY,
}

try:
    res = requests.get(url, params=params)
    res.raise_for_status()
    image_url = res.json()["urls"]["regular"]

    img_response = requests.get(image_url)
    img_response.raise_for_status()
    img = Image.open(BytesIO(img_response.content)).convert("RGBA")
    print("✅ Downloaded background image")

except Exception as e:
    print(f"⚠️ Failed to fetch image. Reason: {e}")
    if os.path.exists(FALLBACK_IMAGE):
        img = Image.open(FALLBACK_IMAGE).convert("RGBA")
        print("📁 Using fallback image.")
    else:
        raise RuntimeError("❌ No fallback image found and fetch failed")

# Overlay quote
overlay = Image.new("RGBA", img.size, (255, 255, 255, 0))
draw = ImageDraw.Draw(overlay)

try:
    font = ImageFont.truetype("DejaVuSans-Bold.ttf", 36)
except IOError:
    font = ImageFont.load_default()

draw.text((50, img.height - 80), quote, font=font, fill=(255, 255, 255, 255))
final_img = Image.alpha_composite(img, overlay).convert("RGB")
final_img.save(OUTPUT_PATH)

print(f"🖼️ Zoom background saved at: {OUTPUT_PATH}")
