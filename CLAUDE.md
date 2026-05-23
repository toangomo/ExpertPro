# ExpertPro — Claude Code Instructions

## Nhiệm vụ chính

Đây là workspace của Expert-Pro agent. Khi nhận bất kỳ yêu cầu nào từ người dùng
(qua Telegram hoặc terminal), nhiệm vụ chính là **nghiên cứu + tạo slide + gửi kết quả**.

---

## Routing — BẮT BUỘC đọc trước khi xử lý bất kỳ tin nhắn nào

### Khi nhận tin nhắn yêu cầu nghiên cứu / tìm hiểu / phân tích:

**LUÔN LUÔN** chuyển toàn bộ task cho agent `Expert-Pro` bằng cách dùng `Agent` tool:

```
Trigger keywords (tiếng Việt hoặc tiếng Anh):
- "nghiên cứu", "tìm hiểu", "phân tích", "research", "tìm kiếm thông tin"
- "cho tôi biết về", "giải thích", "so sánh", "đánh giá", "tổng hợp"
- "báo cáo về", "deep dive", "làm slide về", "slide về"
- Hoặc bất kỳ yêu cầu nào muốn tìm hiểu một chủ đề
```

Khi gọi agent Expert-Pro, **bắt buộc truyền đầy đủ context**:
- Nội dung yêu cầu (chủ đề cần nghiên cứu)
- `chat_id` từ tin nhắn Telegram (nếu có)
- `message_id` từ tin nhắn Telegram (nếu có)

### Khi nhận tin nhắn KHÔNG phải nghiên cứu:

Xử lý trực tiếp (hỏi thêm thông tin, trả lời câu hỏi nhanh, xác nhận lệnh, v.v.)

---

## Xử lý tin nhắn Telegram

Khi nhận channel notification từ Telegram:

```xml
<channel source="telegram">
  <message id="[message_id]" chat_id="[chat_id]" from="[user_id]">
    [nội dung tin nhắn]
  </message>
</channel>
```

**Bước 1:** Extract `chat_id`, `message_id`, nội dung tin nhắn.

**Bước 2:** Phân loại yêu cầu:
- Là nghiên cứu/tìm hiểu → Gọi agent Expert-Pro (xem routing ở trên)
- Là câu hỏi nhanh → Trả lời trực tiếp qua `mcp__telegram__reply`
- Là lệnh điều khiển (`/status`, `/help`, v.v.) → Xử lý theo lệnh

**Bước 3 (nếu gọi Expert-Pro):** Truyền đầy đủ thông tin vào prompt của agent:

```
Hãy nghiên cứu chủ đề sau và tạo slide HTML, sau đó gửi kết quả qua Telegram.

CHỦ ĐỀ: [nội dung tin nhắn]
TELEGRAM_CHAT_ID: [chat_id]
TELEGRAM_MESSAGE_ID: [message_id]
```

---

## Thư mục output

File slide HTML được lưu tại: `E:\Claude-Code\ExpertPro\outputs\`

Nếu thư mục chưa tồn tại, tạo trước khi lưu file.
