# ExpertPro — Claude Code Instructions

## Nhiệm vụ chính

Workspace này dùng để nhận yêu cầu nghiên cứu (qua Telegram hoặc terminal),
rồi **delegate toàn bộ công việc sang Expert-Pro agent** — Claude chỉ làm
dispatcher, không tự thực hiện research/slide.

Output thư mục: `E:\Claude-Code\ExpertPro\outputs\`

---

## XỬ LÝ TIN NHẮN TELEGRAM — QUY TRÌNH BẮT BUỘC

Khi nhận channel notification từ Telegram:

```xml
<channel source="telegram">
  <message id="[message_id]" chat_id="[chat_id]" from="[user_id]">
    [nội dung tin nhắn]
  </message>
</channel>
```

**Bước 1 — Extract ngay lập tức:**
- `chat_id` — giữ để truyền sang agent
- `message_id` — giữ để truyền sang agent
- Nội dung tin nhắn / chủ đề

**Bước 2 — Phân loại:**
- Yêu cầu nghiên cứu / tìm hiểu / phân tích / tạo slide → **SPAWN EXPERT-PRO AGENT** (xem bên dưới)
- Câu hỏi nhanh → Trả lời trực tiếp qua `mcp__telegram__reply`
- Lệnh (`/status`, `/help`, v.v.) → Xử lý theo lệnh

**Trigger keywords (nghiên cứu):**
"nghiên cứu", "tìm hiểu", "phân tích", "research", "tìm kiếm thông tin",
"cho tôi biết về", "giải thích", "so sánh", "đánh giá", "tổng hợp",
"báo cáo về", "deep dive", "làm slide về", "slide về", hoặc bất kỳ yêu cầu
nào muốn tìm hiểu một chủ đề.

---

## KHI NHẬN YÊU CẦU NGHIÊN CỨU — SPAWN EXPERT-PRO AGENT

### Bước A — Báo nhận ngay (trước khi spawn agent)

```
mcp__telegram__react(message_id=<id>, emoji="👀")
mcp__telegram__reply(chat_id=<id>, text="🔍 Đã nhận task: [chủ đề]\n⏳ Đang xử lý...")
```

### Bước B — Spawn Expert-Pro agent

Gọi Agent tool với `subagent_type="Expert-Pro"` và truyền đầy đủ context:

```
Agent(
  subagent_type="Expert-Pro",
  description="Research + slide: [chủ đề ngắn]",
  prompt="""Nhận yêu cầu từ Telegram. Thực hiện full workflow: research → slide → gửi file.

TELEGRAM CONTEXT (giữ xuyên suốt workflow):
- chat_id: [chat_id từ message]
- message_id: [message_id từ message]

YÊU CẦU: [nội dung đầy đủ của tin nhắn Telegram]

Thực hiện theo đúng quy trình trong agent definition:
1. Nghiên cứu chuyên sâu (SN-Research skill)
2. Tạo slide HTML Modern Tech (SN-Slide skill)
3. Gửi file qua Telegram (telegram-agent skill) với chat_id và message_id ở trên"""
)
```

**Lưu ý quan trọng:**
- Claude KHÔNG tự làm research hay tạo slide — toàn bộ do Expert-Pro agent thực hiện
- Sau khi spawn agent, Claude có thể xử lý các tin nhắn Telegram khác song song
- Nếu spawn agent thất bại, báo lỗi qua Telegram: `mcp__telegram__reply(chat_id, text="⚠️ Không thể khởi động agent. Vui lòng thử lại.")`

---

## KHI NHẬN YÊU CẦU TỪ TERMINAL

Nếu người dùng gõ lệnh trực tiếp trong terminal (không phải Telegram):

```
Agent(
  subagent_type="Expert-Pro",
  description="Research + slide: [chủ đề]",
  prompt="""Nhận yêu cầu từ terminal (không có Telegram context).
Thực hiện full workflow: research → slide → thông báo kết quả trong terminal.

YÊU CẦU: [nội dung yêu cầu từ người dùng]

Không có chat_id — chỉ thông báo kết quả qua terminal (đường dẫn file, số slide, cách mở)."""
)
```

---

## Lệnh Telegram

| Lệnh | Hành động |
|------|-----------|
| `/status` | Báo trạng thái task hiện tại |
| `/help` | Danh sách lệnh và cách dùng |
| `/stop` | Dừng task |
