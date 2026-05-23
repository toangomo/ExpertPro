# Hướng Dẫn Lệnh Telegram Agent

## Danh sách lệnh đầy đủ

### Lệnh trạng thái

| Lệnh | Mô tả | Response ví dụ |
|------|-------|---------------|
| `/status` | Trạng thái task hiện tại | "⏳ Đang chạy bước 2/5 (40%)..." |
| `/list` | Danh sách tất cả tasks | List có icon trạng thái |
| `/report` | Báo cáo chi tiết | Full report format |
| `/history` | 5 task gần nhất | List tóm tắt |

### Lệnh điều khiển task

| Lệnh | Mô tả | Lưu ý |
|------|-------|-------|
| `/stop` | Dừng task đang chạy | Cần xác nhận nếu task quan trọng |
| `/pause` | Tạm dừng task | Có thể resume sau |
| `/resume` | Tiếp tục task đã pause | - |
| `/retry` | Thử lại task thất bại | Với cùng config |
| `/skip` | Bỏ qua bước hiện tại | Có thể gây lỗi nếu bước phụ thuộc |

### Lệnh file

| Lệnh | Mô tả | Ví dụ |
|------|-------|-------|
| `/send <path>` | Gửi file | `/send output/report.pdf` |
| `/send last` | Gửi file output cuối cùng | - |
| `/send all` | Gửi tất cả output files | Max 10 files |

### Lệnh thông tin

| Lệnh | Mô tả |
|------|-------|
| `/help` | Hiển thị danh sách lệnh |
| `/ask <câu hỏi>` | Hỏi agent về task |
| `/config` | Xem cấu hình hiện tại |

---

## Ví dụ hội thoại thực tế

### Ví dụ 1: Chạy task và nhận báo cáo

```
[User → Telegram] /status
[Agent → Telegram] 
  ⏳ *Đang xử lý*
  Task: Crawl và phân tích 50 URLs
  Tiến độ: [████████░░░░░░░░] 47%
  Bước hiện tại: Phân tích URL 23/50
  Ước tính còn: ~3 phút

[User → Telegram] /report
[Agent → Telegram]
  📋 *BÁO CÁO HIỆN TẠI*
  ━━━━━━━━━━━━━━━━━━━━
  Đã xử lý: 23/50 URLs
  Thành công: 21 | Lỗi: 2
  
  Lỗi:
  • https://site-A.com — timeout
  • https://site-B.com — 404
  
  Tiếp tục xử lý các URL còn lại...
```

### Ví dụ 2: Nhận file kết quả

```
[Task hoàn thành → Agent tự notify]
[Agent → Telegram]
  ✅ *Hoàn thành!*
  Task: Crawl 50 URLs
  Thời gian: 8 phút 23 giây
  Kết quả: 47/50 thành công (94%)

[Agent gửi file]
  📎 crawl-results.csv (127 KB)
  📎 error-log.txt (2 KB)

[User → Telegram] /ask tại sao 3 URL thất bại?
[Agent → Telegram]
  3 URL thất bại:
  • site-A.com — Request timeout (>30s)
  • site-B.com — HTTP 404 Not Found  
  • site-C.com — SSL certificate error
  
  Muốn tôi retry 3 URLs này không?
```

### Ví dụ 3: Agent cần xác nhận từ user

```
[Agent → Telegram]
  ❓ *CẦN XÁC NHẬN*
  ━━━━━━━━━━━━━━━━
  Tìm thấy file output cũ từ hôm qua:
  • output_2026-05-22.csv (existing)
  
  Ghi đè hay tạo file mới?
    *1* — Ghi đè file cũ
    *2* — Tạo file mới (output_2026-05-23.csv)
    *3* — Hủy task
  
  _Task đang tạm dừng..._

[User → Telegram] 2
[Agent → Telegram]
  👍 Sẽ tạo file mới: output_2026-05-23.csv
  Tiếp tục task...
```

### Ví dụ 4: Dừng task khẩn cấp

```
[User → Telegram] /stop
[Agent → Telegram]
  ⚠️ Đang dừng task: Crawl 50 URLs
  Tiến độ đã lưu: 23/50 URLs
  
  Gõ /resume để tiếp tục sau.

[User → Telegram] xong rồi, gửi kết quả một phần cho tôi
[Agent → Telegram]
  📎 Đây là kết quả 23 URLs đã xử lý:
  [gửi file partial-results.csv]
```

---

## Xử lý edge cases

### User gửi lệnh không hợp lệ

```
[User → Telegram] /delete tất cả files
[Agent → Telegram]
  ⛔ Không thể thực hiện lệnh này qua Telegram.
  
  Lý do: Xóa file là thao tác không thể hoàn tác.
  Vui lòng thực hiện trực tiếp trong terminal.
```

### Nhiều users cùng nhắn (nếu group)

Agent ưu tiên theo thứ tự:
1. Tin nhắn từ `allowFrom` list
2. Trong group: chỉ xử lý khi được @mention
3. Lệnh mâu thuẫn: thực hiện lệnh đến sau, thông báo cho người gửi trước

### Task queue khi agent bận

```
[User → Telegram] chạy thêm task B ngay
[Agent → Telegram]
  📌 Đã thêm Task B vào hàng chờ.
  Vị trí: #2 (sau Task A đang chạy)
  
  Task A còn ~5 phút.
  Sẽ bắt đầu Task B lúc ~14:35.
```

---

## Format tin nhắn

### Markdown được hỗ trợ trong Telegram

| Format | Cú pháp |
|--------|---------|
| **Bold** | `*text*` |
| _Italic_ | `_text_` |
| `Code inline` | `` `code` `` |
| ```Code block``` | ` ```code block``` ` |
| ~~Strikethrough~~ | `~text~` |
| [Link](url) | `[text](url)` |

### Emoji chuẩn để dùng

| Ý nghĩa | Emoji |
|---------|-------|
| Đang chạy/xử lý | ⏳ |
| Thành công | ✅ |
| Lỗi/thất bại | ❌ |
| Cảnh báo | ⚠️ |
| Thông tin | ℹ️ |
| Câu hỏi | ❓ |
| File/tài liệu | 📎 |
| Bắt đầu | 🚀 |
| Báo cáo | 📋 |
| Tiến độ | 📊 |
| Bị chặn | ⛔ |
| Tạm dừng | ⏸️ |
| Thời gian | 🕐 |
