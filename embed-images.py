"""Nhúng ảnh assets/*.png vào data URI -> index-standalone.html (self-contained).
Giữ index.html gốc (relative path) để dễ sửa. Chạy lại mỗi khi thêm ảnh."""
import base64, re, pathlib

root = pathlib.Path(__file__).resolve().parent
html = (root / "index.html").read_text(encoding="utf-8")

def repl(m):
    name = m.group(1)
    p = root / "assets" / name
    if not p.exists():
        print("!! thiếu:", name)
        return m.group(0)
    b = base64.b64encode(p.read_bytes()).decode()
    return f'src="data:image/png;base64,{b}"'

out = re.sub(r'src="assets/([^"]+\.png)"', repl, html)
(root / "index-standalone.html").write_text(out, encoding="utf-8")
print("Da tao index-standalone.html (", len(out), "bytes )")
