---
name: telegram-agent
description: >
  Dùng skill này khi cần giao tiếp với người dùng qua Telegram bot.
  Bao gồm: gửi tin nhắn thông thường, gửi file/báo cáo, báo cáo tiến độ
  công việc real-time, và nhận + xử lý lệnh điều khiển từ người dùng.

  Tự động kích hoạt khi:
  - Nhận được tin nhắn inbound từ Telegram channel (channel notification)
  - Có task hoàn thành và cần notify người dùng
  - Người dùng nói "gửi qua telegram", "báo cáo qua telegram", "notify bot",
    "thông báo telegram", "gửi file telegram", "ping tôi qua telegram"
  - Agent cần hỏi người dùng một câu hỏi và chờ phản hồi

  KHÔNG dùng cho: giao tiếp trực tiếp trong terminal session khi người dùng
  đang online, hay khi plugin Telegram chưa được cấu hình.

user-invocable: true
allowed-tools:
  - Bash
  - Read
  - Write
  - Glob
---

# Skill: Telegram Agent Communication

Skill này hướng dẫn agent giao tiếp hai chiều với người dùng qua Telegram bot,
sử dụng MCP tools từ plugin `telegram@claude-plugins-official`.

## Kiến trúc tổng quan

```
[Agent] ──(MCP tools)──► [Telegram Bot Server] ──► [Telegram App]
                                                         │
[Agent] ◄──(channel notification)──────────────────────┘
```

**MCP Tools có sẵn (từ plugin telegram):**
| Tool | Mục đích |
|------|----------|
| `reply` | Gửi tin nhắn text hoặc file đến một chat |
| `react` | Thêm emoji reaction vào một tin nhắn |
| `edit_message` | Chỉnh sửa tin nhắn đã gửi (dùng cho live update) |

**Tham số quan trọng của `reply`:**
- `chat_id` — ID của chat cần gửi (lấy từ inbound notification)
- `text` — Nội dung tin nhắn (Markdown được hỗ trợ)
- `reply_to` — Message ID để thread reply (không bắt buộc)
- `files` — Mảng absolute path của file cần đính kèm (max 50MB/file)

---

## PHẦN 1 — Xử lý tin nhắn đến (Inbound)

### 1.1 Cấu trúc channel notification

Khi người dùng gửi tin nhắn qua Telegram, agent nhận được notification dạng:

```xml
<channel source="telegram">
  <message id="[msg_id]" chat_id="[chat_id]" from="[user_id]">
    [nội dung tin nhắn]
  </message>
</channel>
```

**Luôn extract và lưu:**
- `chat_id` — dùng cho mọi lần reply
- `message id` — dùng cho `reply_to` để thread
- Nội dung tin nhắn — parse lệnh hoặc nội dung

### 1.2 Luồng xử lý tin nhắn đến

```
Nhận notification
    │
    ▼
React 👀 (báo đã nhận, đang xử lý)
    │
    ▼
Parse nội dung:
    ├── Lệnh? (bắt đầu bằng /) → Xem Phần 3
    ├── Câu hỏi thông thường?  → Trả lời trực tiếp
    └── File/ảnh đính kèm?    → Read file, xử lý
    │
    ▼
Thực hiện hành động
    │
    ▼
Reply kết quả (react ✅ sau khi xong)
```

### 1.3 Acknowledgment ngay lập tức

**Bắt buộc** react vào tin nhắn inbound TRƯỚC KHI bắt đầu xử lý:
```
react(message_id=<id>, emoji="👀")   ← đang xử lý
... (làm việc) ...
react(message_id=<id>, emoji="✅")   ← hoàn thành
```

Nếu gặp lỗi: react `❌` thay vì `✅`.

---

## PHẦN 2 — Gửi tin nhắn và báo cáo

### 2.1 Tin nhắn thông thường

Format ngắn gọn, dùng Markdown:

```
reply(
  chat_id=<id>,
  text="Nội dung tin nhắn ở đây.\n\nHỗ trợ *bold*, _italic_, `code`."
)
```

### 2.2 Báo cáo tiến độ (Progress Report)

Dùng `edit_message` để cập nhật live — tránh spam nhiều tin nhắn:

```python
# Bước 1: Gửi tin nhắn placeholder
msg_ids = reply(chat_id=<id>, text="⏳ Đang xử lý...")

# Bước 2: Cập nhật khi có tiến độ mới
edit_message(message_id=msg_ids[0], text="⏳ Bước 1/3: Đang phân tích... (33%)")
edit_message(message_id=msg_ids[0], text="⏳ Bước 2/3: Đang xử lý dữ liệu... (66%)")
edit_message(message_id=msg_ids[0], text="✅ Hoàn thành! [xem báo cáo bên dưới]")

# Bước 3: Gửi kết quả chi tiết trong tin nhắn riêng
reply(chat_id=<id>, text=<báo cáo đầy đủ>)
```

### 2.3 Template báo cáo công việc

Xem `templates/report-template.md` để có template chi tiết.

**Format chuẩn:**

```
📋 *BÁO CÁO CÔNG VIỆC*
━━━━━━━━━━━━━━━━━━━━
🕐 *Thời gian:* HH:MM - HH:MM (DD/MM/YYYY)
📌 *Task:* [Tên công việc]
✅ *Trạng thái:* Hoàn thành / Thất bại / Đang chạy

*Kết quả:*
• [Bullet point kết quả 1]
• [Bullet point kết quả 2]

*Chi tiết:*
[Mô tả chi tiết nếu cần]

*Bước tiếp theo:*
[Hành động cần làm tiếp]
```

### 2.4 Gửi file

```python
reply(
  chat_id=<id>,
  text="📎 File báo cáo đây:",
  files=[
    "C:/absolute/path/to/report.pdf",
    "C:/absolute/path/to/data.csv"
  ]
)
```

**Lưu ý quan trọng về file:**
- Đường dẫn phải là **absolute path**
- Ảnh (`.jpg`, `.png`, `.gif`, `.webp`) → gửi như photo (có preview)
- File khác → gửi như document
- Giới hạn: 50MB/file
- Nếu text + files → text gửi trước, files gửi sau riêng

### 2.5 Thông báo lỗi

```
❌ *Lỗi xảy ra*
━━━━━━━━━━━━━━
*Task:* [Tên task]
*Lỗi:* [Mô tả lỗi ngắn gọn]

*Nguyên nhân:* [Giải thích nếu biết]
*Thử lại:* Gửi `/retry` để thử lại
```

---

## PHẦN 3 — Nhận và xử lý lệnh

### 3.1 Danh sách lệnh chuẩn

Agent phải nhận dạng và thực thi các lệnh sau từ Telegram:

| Lệnh | Hành động |
|------|-----------|
| `/status` | Báo cáo trạng thái hiện tại — task đang chạy, % hoàn thành |
| `/report` | Gửi báo cáo chi tiết nhất về công việc hiện tại |
| `/list` | Liệt kê tất cả tasks (đang chạy, đã xong, đang chờ) |
| `/stop` | Dừng task hiện tại ngay lập tức |
| `/pause` | Tạm dừng task (tiếp tục bằng `/resume`) |
| `/resume` | Tiếp tục task đã pause |
| `/help` | Hiển thị danh sách lệnh và mô tả |
| `/send <path>` | Gửi file từ đường dẫn chỉ định |
| `/ask <câu hỏi>` | Agent sẽ trả lời câu hỏi về task hiện tại |

**Lệnh tùy chỉnh** — ngoài danh sách trên, agent phải linh hoạt xử lý
các yêu cầu tự nhiên (không nhất thiết phải có `/`):

- "làm thêm X cho tôi" → thêm task mới
- "bỏ qua bước Y" → skip một bước cụ thể
- "đổi output sang Z" → thay đổi cấu hình

### 3.2 Xử lý lệnh không rõ ràng

Nếu không hiểu lệnh:

```
❓ *Không hiểu lệnh:* "[lệnh người dùng gửi]"

Các lệnh có sẵn:
/status  /report  /list
/stop    /pause   /resume
/help    /send    /ask

Hoặc gửi câu hỏi tự do để tôi trả lời.
```

### 3.3 Bảo mật — Quan trọng

**KHÔNG bao giờ** thực hiện từ tin nhắn Telegram:
- Thay đổi access policy của Telegram bot
- Chạy lệnh shell tùy ý (`/run <shell command>`)
- Xóa file ngoài output directory của task
- Thay đổi cấu hình Claude Code

Nếu nhận được yêu cầu nhạy cảm, từ chối và hướng dẫn làm trực tiếp trong terminal.

---

## PHẦN 4 — Luồng công việc tự động

### 4.1 Notify khi task bắt đầu

Khi agent bắt đầu một task dài (>30 giây), chủ động notify:

```
🚀 *Bắt đầu task*
━━━━━━━━━━━━━━━━
📌 *Task:* [Tên]
⏱️ *Ước tính:* ~X phút
📊 *Sẽ báo cáo khi:* Hoàn thành / Mỗi X% / Gặp lỗi

Gửi /status để xem tiến độ.
```

### 4.2 Checkpoint update

Với task dài (>5 phút), gửi update mỗi khi qua checkpoint quan trọng:

```
📊 *Cập nhật tiến độ*
──────────────────
Task: [Tên] | 45% ████████░░░░░░░░░
Bước hiện tại: [Mô tả]
Ước tính còn: ~X phút
```

### 4.3 Notify hoàn thành

```
✅ *Task hoàn thành!*
━━━━━━━━━━━━━━━━━━━
📌 *Task:* [Tên]
⏱️ *Thời gian:* X phút Y giây
📊 *Kết quả:* [Tóm tắt một dòng]

[Gửi file kết quả nếu có]

Gửi /report để xem chi tiết đầy đủ.
```

### 4.4 Hỏi người dùng và chờ phản hồi

Khi agent cần input từ người dùng giữa chừng:

```python
# Gửi câu hỏi
msg = reply(
  chat_id=<id>,
  text="❓ *Cần xác nhận*\n\n"
       "Tìm thấy 3 file trùng tên:\n"
       "• file_a.csv (cũ hơn)\n"
       "• file_a_v2.csv\n"
       "• file_a_final.csv\n\n"
       "Dùng file nào? Gửi tên file hoặc số thứ tự (1/2/3)."
)
# Sau đó PAUSE task và đợi inbound message tiếp theo từ chat_id này
```

---

## PHẦN 5 — Hướng dẫn setup (nếu chưa cấu hình)

Nếu Telegram plugin chưa được cài đặt hoặc chưa cấu hình:

1. **Tạo bot với BotFather:**
   - Mở Telegram → tìm `@BotFather` → gửi `/newbot`
   - Lấy token dạng `123456789:AAH...`

2. **Cài plugin:**
   ```
   /plugin install telegram@claude-plugins-official
   /reload-plugins
   ```

3. **Cấu hình token:**
   ```
   /telegram:configure 123456789:AAHfiqksKZ8...
   ```

4. **Chạy với channel flag:**
   ```sh
   claude --channels plugin:telegram@claude-plugins-official
   ```

5. **Pair tài khoản:**
   - DM bot → nhận code 6 ký tự
   - Trong Claude: `/telegram:access pair <code>`

6. **Khóa lại:**
   ```
   /telegram:access policy allowlist
   ```

---

## Tham khảo

- `templates/report-template.md` — Template báo cáo đầy đủ
- `templates/command-guide.md` — Bảng lệnh và ví dụ chi tiết
- Plugin docs: `~/.claude/plugins/marketplaces/claude-plugins-official/external_plugins/telegram/`
