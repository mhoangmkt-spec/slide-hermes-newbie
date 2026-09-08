# Gen ảnh doodle cho deck Hermes — Gemini Nano Banana 2 (gemini-3.1-flash-image)
# ĐIỀU KIỆN: đã nạp credits Gemini (AI Studio billing) + GEMINI_API_KEY trong
#   D:\Cito Workplace\01_Projects\khoa-hoc-nghien-cuu-chuyen-sau\.env
# Ảnh xuất ở: khoa-hoc-nghien-cuu-chuyen-sau\assets\generated\  (copy sang slide sau)

$gen = "D:\Cito Workplace\01_Projects\khoa-hoc-nghien-cuu-chuyen-sau\scripts\generate_image.py"
$pre = "minimalist black ink line-art doodle, hand-drawn single-weight strokes, no shading, no fill, lots of negative space, friendly, flat #FBF4E3 cream background. NO text, NO extra icons — "

# --- 2 ảnh ưu tiên ---
python $gen --aspect "1:1" --out "hermes-hero.png"   --prompt "$pre a friendly robot-butler AI assistant with a small headset, holding a smartphone showing a chat bubble, one hand raised waving hello"
python $gen --aspect "3:4" --out "hermes-s2.png"     --prompt "$pre a smartphone with a chat bubble popping out, and a small friendly assistant character handing over a report document"

# --- 3 ảnh spot (tùy chọn) ---
python $gen --aspect "4:3" --out "hermes-memory.png" --prompt "$pre a human head in profile, top opened showing small filing drawers inside, a little plug on the side"
python $gen --aspect "4:3" --out "hermes-host.png"   --prompt "$pre a cozy small house with a computer inside, a moon and a sun together, an always-awake 24/7 feel"
python $gen --aspect "1:1" --out "hermes-loop.png"   --prompt "$pre a character climbing a rising spiral of gears and books, a lightbulb glowing above"

Write-Output "Xong. Ảnh ở: D:\Cito Workplace\01_Projects\khoa-hoc-nghien-cuu-chuyen-sau\assets\generated\"
