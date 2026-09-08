# Kịch bản quay: Cài Hermes lên VPS (demo bằng Docker)

> Mục tiêu: quay video hướng dẫn học viên **SSH vào VPS → cài Hermes → chọn model DeepSeek → chat → nối Telegram**.
> Cách làm: dùng 1 container Docker Ubuntu có SSH = "VPS giả" ở `localhost:2222` — quay được bước ssh thật, xóa đi là sạch, không đụng VPS production.
> Công cụ quay: OBS / Win+G (Game Bar) / ShareX. Em không quay hộ được — anh quay, làm theo script này.

---

## PHẦN A — CHUẨN BỊ (làm TRƯỚC, KHÔNG quay)

**A1. Bật Docker Desktop** — mở app, đợi báo "Engine running".

**A2. Tạo "VPS giả" (container Ubuntu + SSH):**
```powershell
docker run -d --name hermes-vps -p 2222:22 ubuntu:24.04 sleep infinity
docker exec hermes-vps bash -c "apt-get update && apt-get install -y openssh-server curl sudo nano && mkdir -p /run/sshd && echo 'root:demo123' | chpasswd && sed -i 's/#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && service ssh start"
```
→ Giờ có "VPS" đăng nhập bằng: user `root`, mật khẩu `demo123`, cổng `2222`.

**A3. Test thử 1 lần (chưa quay)** — chắc chắn vào được:
```powershell
ssh -p 2222 root@localhost
# gõ yes nếu hỏi host key, nhập demo123 → vào được → gõ  exit  để thoát
```
Nếu vào được là ổn. (Nếu báo lỗi host key do quay lại nhiều lần: `ssh-keygen -R "[localhost]:2222"`.)

**A4. Chuẩn bị sẵn (để không lộ/khựng khi quay):**
- **Key DeepSeek** (dạng `sk-…`) copy sẵn — sẽ dán ở Bước 3. ⚠️ *Che/blur khi edit video.*
- **Token Telegram** từ @BotFather copy sẵn — Bước 5. ⚠️ *Che/blur khi edit.*
- Muốn quay lại từ đầu cho sạch: `docker rm -f hermes-vps` rồi làm lại A2.

---

## PHẦN B — KỊCH BẢN QUAY (bắt đầu bấm record)

### Bước 1 — SSH vào VPS
**Gõ:**
```
ssh -p 2222 root@localhost
```
**Lời dẫn:** "Trên VPS thật của bạn, lệnh là `ssh root@<địa-chỉ-IP>`. Ở đây mình demo trên máy nên thêm cổng 2222. Nhập mật khẩu — lưu ý mật khẩu **không hiện ký tự** khi gõ, đó là bình thường."
**Verify:** dòng lệnh đổi thành `root@...:~#` = đã ở trong server.

### Bước 2 — Cài Hermes bằng 1 lệnh
**Gõ:**
```
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
source ~/.bashrc
```
**Lời dẫn:** "Chỉ 1 dòng. Trình cài tự lo hết: Python, Node, công cụ phụ — bạn không cần chuẩn bị gì."
**Verify:**
```
hermes --version
```
→ hiện số phiên bản = cài xong.

### Bước 3 — Chọn model + cắm DeepSeek
**Gõ:**
```
nano ~/.hermes/.env
```
Dán dòng (⚠️ che khi edit): `DEEPSEEK_API_KEY=sk-xxxxxxxx` → lưu (Ctrl+O, Enter, Ctrl+X).
**Rồi:**
```
hermes model
```
→ chọn **DeepSeek** → **deepseek-v4-flash**.
**Lời dẫn:** "DeepSeek rẻ mà đủ mạnh cho việc hằng ngày. Đây là 'bộ não' của trợ lý — đổi lúc nào cũng được bằng `hermes model`."

### Bước 4 — Chat thử (khoảnh khắc "wow")
**Gõ:**
```
hermes
```
Hỏi thử: *"Chào, bạn là ai và làm được gì?"* → agent trả lời.
**Lời dẫn:** "Vậy là trợ lý đã sống trên "VPS". Gõ `/exit` để thoát."

### Bước 5 — Nối Telegram (điều khiển từ điện thoại)
**Chuẩn bị (có thể quay màn hình điện thoại/Telegram desktop):** @BotFather → `/newbot` → đặt tên → copy **token**.
**Gõ trong VPS:**
```
hermes gateway
```
→ dán token khi được hỏi (⚠️ che khi edit).
**Verify:** mở Telegram, nhắn bot *"còn đó không?"* → bot trả lời.

### Bước 6 — Chạy nền 24/7 (CHỈ GIẢI THÍCH, không chạy trong Docker)
**Lời dẫn:** "Trên VPS thật, để trợ lý chạy 24/7 kể cả khi tắt SSH, ta dùng systemd:"
**Hiện lệnh trên màn (đọc, không cần chạy):**
```
systemctl --user enable hermes-gateway
systemctl --user start hermes-gateway
loginctl enable-linger root
```
> Lưu ý kỹ thuật: systemd không chạy trong Docker container thường → không demo trực tiếp được. Nếu muốn quay bước này CHẠY THẬT, quay riêng 1 đoạn ngắn trên VPS thật (một VPS trống, không phải production).

---

## Sau khi quay xong
- Xóa VPS giả: `docker rm -f hermes-vps`
- Edit video: **blur** mọi chỗ hiện key DeepSeek + token Telegram + mật khẩu.

---

## Em có thể hỗ trợ thêm
- **Test trước khối A2 + Bước 2** (tới `hermes --version`) để chắc lệnh chạy mượt trước khi anh quay — cần anh bật Docker Desktop, rồi bảo em.
- Chỉnh lời dẫn dài/ngắn theo tốc độ nói của anh.
