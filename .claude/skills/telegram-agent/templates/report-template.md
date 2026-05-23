# Templates Báo Cáo Telegram

## 1. Báo cáo ngắn (Quick Status)

Dùng khi: task đơn giản, kết quả rõ ràng, < 5 phút

```
✅ Xong! [Tóm tắt một dòng kết quả]

📎 [Tên file] — nếu có file đính kèm
```

---

## 2. Báo cáo chuẩn (Standard Report)

Dùng khi: task trung bình, có nhiều bước, cần context

```
📋 *BÁO CÁO: [Tên Task]*
━━━━━━━━━━━━━━━━━━━━━━━━
🕐 [HH:MM] → [HH:MM] · [X phút]
✅ *Trạng thái:* Hoàn thành

*Kết quả:*
• [Kết quả chính 1]
• [Kết quả chính 2]
• [Kết quả chính 3]

📎 *File đính kèm:* [tên file] nếu có

_Gửi /report để xem chi tiết đầy đủ_
```

---

## 3. Báo cáo chi tiết (Full Report)

Dùng khi: task phức tạp, cần audit trail, có nhiều output

```
📊 *BÁO CÁO CHI TIẾT*
━━━━━━━━━━━━━━━━━━━━━

📌 *Task:* [Tên đầy đủ]
🆔 *ID:* [task-id nếu có]
🕐 *Bắt đầu:* [DD/MM/YYYY HH:MM]
🕑 *Kết thúc:* [DD/MM/YYYY HH:MM]
⏱️ *Thời gian:* [X phút Y giây]
✅ *Trạng thái:* [Hoàn thành / Thất bại / Hoàn thành một phần]

──────────────────────────
📈 *KẾT QUẢ*

[Mô tả kết quả chi tiết]

• Mục A: [Kết quả]
• Mục B: [Kết quả]
• Mục C: [Kết quả]

──────────────────────────
🔍 *CÁC BƯỚC ĐÃ THỰC HIỆN*

1. [Bước 1] ✅
2. [Bước 2] ✅
3. [Bước 3] ⚠️ [có ghi chú]
4. [Bước 4] ✅

──────────────────────────
⚠️ *LƯU Ý / VẤN ĐỀ GẶP PHẢI*

[Mô tả nếu có vấn đề xảy ra trong quá trình]

──────────────────────────
📎 *OUTPUT FILES*

• `[tên file 1]` — [mô tả]
• `[tên file 2]` — [mô tả]

──────────────────────────
➡️ *BƯỚC TIẾP THEO ĐỀ XUẤT*

• [Hành động 1]
• [Hành động 2]
```

---

## 4. Báo cáo lỗi (Error Report)

```
❌ *TASK THẤT BẠI*
━━━━━━━━━━━━━━━━━

📌 *Task:* [Tên]
🕐 *Thời điểm lỗi:* [HH:MM DD/MM]
💥 *Lỗi:* [Mô tả lỗi ngắn gọn]

*Chi tiết:*
```[stack trace hoặc error message ngắn]```

*Nguyên nhân có thể:*
• [Nguyên nhân 1]
• [Nguyên nhân 2]

*Cách khắc phục:*
• Thử lại: gửi `/retry`
• Hoặc nói cho tôi biết cách xử lý
```

---

## 5. Cập nhật tiến độ (Progress Update)

Dùng với `edit_message` để update live:

```
⏳ *Đang xử lý: [Tên Task]*
━━━━━━━━━━━━━━━━━━━━━━━━━━

[████████░░░░░░░░] 50%

Bước hiện tại: [Mô tả bước]
Ước tính còn: ~X phút

_Tự động cập nhật..._
```

**Các trạng thái progress bar:**

| % | Bar |
|---|-----|
| 0% | `[░░░░░░░░░░░░░░░░]` |
| 25% | `[████░░░░░░░░░░░░]` |
| 50% | `[████████░░░░░░░░]` |
| 75% | `[████████████░░░░]` |
| 100% | `[████████████████]` |

---

## 6. Câu hỏi xác nhận (Confirmation Request)

```
❓ *CẦN XÁC NHẬN*
━━━━━━━━━━━━━━━━

[Mô tả tình huống cần xác nhận]

Chọn:
  *1* — [Lựa chọn A]
  *2* — [Lựa chọn B]
  *3* — [Lựa chọn C]

Hoặc gõ câu trả lời tự do.
_Task đang tạm dừng..._
```

---

## 7. Thông báo khởi động (Task Start)

```
🚀 *BẮT ĐẦU TASK*
━━━━━━━━━━━━━━━━━

📌 *Task:* [Tên]
📝 *Mô tả:* [Mô tả ngắn]
⏱️ *Ước tính:* ~[X] phút
📊 *Sẽ thông báo:* Mỗi bước lớn + khi xong

_Gửi /status để xem tiến độ bất kỳ lúc nào_
_Gửi /stop để dừng_
```

---

## Nguyên tắc viết báo cáo

1. **Ngắn gọn trước** — Thông tin quan trọng nhất lên đầu
2. **Số liệu cụ thể** — "Xử lý 1,247 records" thay vì "Xử lý nhiều records"
3. **Trạng thái rõ ràng** — Luôn cho biết task thành công hay thất bại
4. **Action items** — Kết thúc bằng "bước tiếp theo" hoặc câu hỏi nếu cần input
5. **Giới hạn 4096 ký tự** — Telegram tự chunk nếu dài hơn
