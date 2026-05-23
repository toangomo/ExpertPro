# ExpertPro — Claude Code Instructions

## Nhiệm vụ chính

Workspace này dùng để nhận yêu cầu nghiên cứu (qua Telegram hoặc terminal),
thực hiện research, tạo slide HTML, và gửi kết quả. Claude thực hiện trực tiếp
— không delegate sang subagent.

Output thư mục: `E:\Claude-Code\ExpertPro\outputs\`

---

## XỬ LÝ TIN NHẮN TELEGRAM — BẮT BUỘC THEO ĐÚNG QUY TRÌNH

Khi nhận channel notification từ Telegram:

```xml
<channel source="telegram">
  <message id="[message_id]" chat_id="[chat_id]" from="[user_id]">
    [nội dung tin nhắn]
  </message>
</channel>
```

**Bước 1 — Extract ngay lập tức:**
- `chat_id` — giữ xuyên suốt toàn bộ quy trình
- `message_id` — dùng cho react và reply_to
- Nội dung tin nhắn

**Bước 2 — Phân loại:**
- Yêu cầu nghiên cứu / tìm hiểu / phân tích / tạo slide → Chạy **FULL WORKFLOW** bên dưới
- Câu hỏi nhanh → Trả lời trực tiếp qua `mcp__telegram__reply`
- Lệnh (`/status`, `/help`, v.v.) → Xử lý theo lệnh

**Trigger keywords (nghiên cứu):**
"nghiên cứu", "tìm hiểu", "phân tích", "research", "tìm kiếm thông tin",
"cho tôi biết về", "giải thích", "so sánh", "đánh giá", "tổng hợp",
"báo cáo về", "deep dive", "làm slide về", "slide về", hoặc bất kỳ yêu cầu
nào muốn tìm hiểu một chủ đề.

---

## FULL WORKFLOW — NGHIÊN CỨU + SLIDE + GỬI FILE

### BƯỚC 0 — Báo nhận (làm NGAY, trước mọi thứ)

```
mcp__telegram__react(message_id=<id>, emoji="👀")
mcp__telegram__reply(chat_id=<id>, text="🔍 Đã nhận task: [chủ đề]\n⏳ Đang nghiên cứu...")
```

---

### BƯỚC 1 — Nghiên cứu (6–10 WebSearch)

Xác định:
```
CHỦ ĐỀ: [một câu cụ thể]
CÂU HỎI CHÍNH: [câu hỏi có thể trả lời được]
```

Search đa góc độ:
1. Evidence ủng hộ: `[topic] research findings [năm]`
2. Evidence phản bác: `[topic] criticism problems`
3. Nguồn gốc số liệu: `[claim] original study source`
4. Expert views: `[topic] expert analysis`

Với mỗi claim quan trọng: cần ≥ 2 nguồn độc lập. Tìm cả evidence phản bác.

Tổng hợp nội bộ (KHÔNG gửi ra Telegram):
```
BOTTOM LINE: [kết luận chính 1–2 câu]
KEY FINDINGS: [3–5 findings + evidence]
DATA POINTS: [số liệu nổi bật + context]
IMPLICATIONS: [actionable insights]
```

Gửi progress update ngắn:
```
mcp__telegram__reply(chat_id=<id>, text="✅ Research xong. Đang tạo slide...")
```

---

### BƯỚC 2 — Tạo slide HTML (Modern Tech Design)

#### 2.1 Cấu trúc slide

```
SLIDE 1 — Cover (tiêu đề + tagline = bottom line)
SLIDE 2 — Key Findings (3–5 bullets)
SLIDE 3–N — Chi tiết (1 finding/slide, tiêu đề = kết luận)
SLIDE N+1 — Data & Evidence
SLIDE N+2 — Implications / Next Steps
SLIDE N+3 — Takeaways + Limitations
```

#### 2.2 Design System — CSS Variables (BẮT BUỘC)

```css
:root {
  --blue:       #004aef;
  --blue-light: #2563ff;
  --blue-dim:   rgba(0, 74, 239, 0.15);
  --mint:       #00ffaa;
  --mint-dim:   rgba(0, 255, 170, 0.12);
  --amber:      #ffce00;
  --cyan:       #0dd1ff;
  --cyan-dim:   rgba(13, 209, 255, 0.12);
  --bg-base:    #080c14;
  --bg-surface: #0d1117;
  --bg-card:    rgba(255, 255, 255, 0.04);
  --text-primary:   #f0f4ff;
  --text-secondary: rgba(240, 244, 255, 0.6);
  --text-muted:     rgba(240, 244, 255, 0.35);
  --border-subtle:  rgba(255, 255, 255, 0.08);
  --border-default: rgba(255, 255, 255, 0.14);
  --border-accent:  rgba(0, 74, 239, 0.4);
  --font-display: 'Space Grotesk', 'Inter', system-ui, sans-serif;
  --font-body:    'Inter', system-ui, sans-serif;
  --font-mono:    'JetBrains Mono', monospace;
  --slide-pad-x: 80px;
  --slide-pad-y: 60px;
  --gap: 32px;
  --radius-md: 12px;
  --radius-lg: 20px;
}
```

**Modern Tech rules:**
- Card: `border-radius: 12px`, `backdrop-filter: blur(12px)`, viền mỏng 1px
- Heading: `font-weight: 700`, `letter-spacing: -0.02em` — KHÔNG dùng 900 hay uppercase
- Gradient text: `background: linear-gradient(135deg, #004aef, #0dd1ff)` + `-webkit-background-clip: text`
- KHÔNG dùng: `border-radius: 0`, `box-shadow: 6px 6px 0`, viền 3px+

#### 2.3 HTML Template bắt buộc

```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Tên presentation]</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Space+Grotesk:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  <style>/* CSS variables + base styles + layout classes */</style>
</head>
<body>
  <div class="deck">
    <section class="slide active" data-slide="1">...</section>
    <section class="slide" data-slide="2">...</section>
  </div>
  <div class="nav-bar">
    <button id="btn-prev" onclick="navigate(-1)" disabled>←</button>
    <span><b id="current">1</b> / <span id="total">N</span></span>
    <button id="btn-next" onclick="navigate(1)">→</button>
  </div>
  <div class="progress-track"><div class="progress-fill" id="progress"></div></div>
  <div class="slide-num" id="slide-num">01</div>
  <script>
    const slides = document.querySelectorAll('.slide');
    const total = slides.length;
    let current = 0;
    document.getElementById('total').textContent = total;

    function navigate(dir) {
      const next = current + dir;
      if (next < 0 || next >= total) return;
      slides[current].classList.remove('active');
      current = next;
      slides[current].classList.add('active');
      updateUI();
    }

    function updateUI() {
      document.getElementById('current').textContent = current + 1;
      document.getElementById('progress').style.width = `${((current+1)/total)*100}%`;
      document.getElementById('btn-prev').disabled = current === 0;
      document.getElementById('btn-next').disabled = current === total - 1;
      document.getElementById('slide-num').textContent = String(current+1).padStart(2,'0');
    }

    document.addEventListener('keydown', e => {
      if (['ArrowRight','ArrowDown',' '].includes(e.key)) { e.preventDefault(); navigate(1); }
      if (['ArrowLeft','ArrowUp'].includes(e.key)) { e.preventDefault(); navigate(-1); }
      if (e.key === 'f') document.documentElement.requestFullscreen?.();
    });

    let tx = 0;
    document.addEventListener('touchstart', e => { tx = e.touches[0].clientX; }, {passive:true});
    document.addEventListener('touchend', e => {
      const dx = e.changedTouches[0].clientX - tx;
      if (Math.abs(dx) > 50) navigate(dx < 0 ? 1 : -1);
    }, {passive:true});

    document.getElementById('progress').style.width = `${(1/total)*100}%`;
  </script>
</body>
</html>
```

#### 2.4 Quy tắc nội dung

- Mỗi slide: 1 thông điệp duy nhất, tiêu đề = kết luận (không phải topic)
- Max 50 từ body text/slide
- Số liệu: hiển thị to + màu mint + context bên dưới
- Dùng `01/02/03` cho danh sách có thứ tự

---

### BƯỚC 3 — Lưu file

Tên file: `[slug-chủ-đề]-slides.html`

```
Write file vào: E:\Claude-Code\ExpertPro\outputs\[slug]-slides.html
```

Sau khi Write: dùng `Read` để xác nhận file tồn tại và không rỗng.

---

### BƯỚC 4 — Gửi qua Telegram (2 lần gọi RIÊNG BIỆT)

**Lần 1 — Text summary:**
```
mcp__telegram__reply(
  chat_id=<chat_id gốc>,
  reply_to=<message_id gốc>,
  text="✅ *Hoàn thành!*\n\n📊 *Chủ đề:* [tên]\n📑 *Số slide:* [N]\n\n*Highlights:*\n• [Finding 1]\n• [Finding 2]\n• [Finding 3]\n\n📎 File slide đính kèm — mở bằng browser, dùng ← → để chuyển."
)
```

**Lần 2 — File đính kèm (gọi RIÊNG, KHÔNG kết hợp với text):**
```
mcp__telegram__reply(
  chat_id=<chat_id gốc>,
  files=["E:\\Claude-Code\\ExpertPro\\outputs\\[slug]-slides.html"]
)
```

**Lần 3 — React hoàn thành:**
```
mcp__telegram__react(message_id=<message_id gốc>, emoji="✅")
```

**Nếu KHÔNG có chat_id** (task từ terminal): chỉ thông báo trong terminal, không gửi Telegram.

**Nếu gửi file thất bại:**
```
mcp__telegram__reply(chat_id, text="⚠️ Gửi file thất bại. File đã lưu tại:\nE:\\Claude-Code\\ExpertPro\\outputs\\[slug]-slides.html")
```

---

## NGUYÊN TẮC BẮT BUỘC

1. **KHÔNG gửi nội dung research dạng text** qua Telegram — kể cả tóm tắt, bullet, key findings
2. Text gửi Telegram chỉ có: (1) react 👀, (2) progress update 1 câu, (3) summary ngắn sau khi đã gửi file
3. Text và file **PHẢI gửi 2 lần riêng biệt** — không kết hợp trong 1 `reply` call
4. Luôn `Read` xác nhận file tồn tại trước khi gửi
5. `chat_id` và `message_id` phải giữ từ đầu đến cuối

---

## Lệnh Telegram

| Lệnh | Hành động |
|------|-----------|
| `/status` | Báo trạng thái task hiện tại |
| `/help` | Danh sách lệnh |
| `/stop` | Dừng task |
