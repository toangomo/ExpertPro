---
name: SN-Slide
description: >
  Dùng skill này khi người dùng muốn TẠO BẢN TRÌNH BÀY, SLIDE, PRESENTATION từ
  nội dung bất kỳ — văn bản, ý tưởng, dữ liệu, báo cáo — dưới dạng file HTML
  với phong cách Modern Tech, thiết kế hiện đại, thông tin có hệ thống.

  Trigger keywords: "tạo slide", "tạo presentation", "tạo bản trình bày",
  "làm slide", "làm presentation", "trình bày nội dung này thành slide",
  "convert thành slide", "slide về", "presentation về", "deck về",
  "xuất slide", "tạo deck", "make slides", "create presentation",
  "tạo html slide", "trình chiếu", "slideshow".

  KHÔNG dùng cho: giải thích khái niệm đơn giản, viết báo cáo văn bản,
  tạo tài liệu thông thường. Ranh giới: nếu người dùng chỉ muốn text/markdown
  → dùng format thông thường. Nếu họ muốn nội dung có thể trình chiếu, visual,
  interactive → dùng skill này.
---

# Skill: SN-Slide — Tạo Slide HTML Phong Cách Modern Tech

## Tổng quan

Skill này tạo file HTML slide hoàn chỉnh, tự chứa (standalone), có thể mở thẳng
trên browser. Mỗi output là một file `.html` duy nhất với CSS và JS nhúng sẵn.

**Design Identity:**
- **Triết lý:** Clarity through structure — thông tin phức tạp trở nên dễ hiểu qua thiết kế có hệ thống
- **Phong cách:** Modern Tech — tối giản, tinh tế, chính xác, có chiều sâu
- **Màu chính:** `#004aef` (Electric Blue) — điểm nhấn, hành động, liên kết
- **Màu phụ:** `#00ffaa` (Mint), `#ffce00` (Amber), `#0dd1ff` (Cyan)
- **Nền:** `#080c14` (Deep Navy) — nền tối mặc định; `#f8f9fc` (Cloud White) — nền sáng
- **Texture:** Subtle grid/dot pattern, glass cards, gradient accents

---

## GIAI ĐOẠN 0 — Phân tích yêu cầu

### 0.1 Đặt 5 câu hỏi nhanh (tự suy luận nếu không được cung cấp)

```
Q1: Nội dung chính là gì? (text/data/ý tưởng/báo cáo/quy trình?)
Q2: Slide dùng để làm gì? (thuyết trình trực tiếp / tự đọc / chia sẻ online?)
Q3: Bao nhiêu slide? (ước lượng: 1 ý chính = 1 slide)
Q4: Ngôn ngữ nội dung? (tiếng Việt / tiếng Anh?)
Q5: Nền tối hay sáng? (mặc định: tối)
```

Nếu người dùng cung cấp nội dung nhưng không nói rõ → tự phân tích và ghi rõ assumption.

### 0.2 Phân tích loại thông tin để chọn layout phù hợp

```
NARRATIVE   → nội dung tường thuật, giải thích → layout TEXT-FOCUS, QUOTE
PROCESS     → quy trình, các bước → layout STEPS, TIMELINE, FLOW
COMPARISON  → so sánh phương án, đặc điểm → layout COMPARISON, TABLE
DATA        → số liệu, thống kê, KPI → layout STAT, DASHBOARD, CHART
CONCEPT     → khái niệm, định nghĩa, mô hình → layout DEFINITION, PILLARS
TECHNICAL   → code, architecture, system → layout CODE, DIAGRAM
```

### 0.3 Lên cấu trúc slide trước khi viết code

```
SLIDE 1     — Cover (tiêu đề + tagline + context)
SLIDE 2     — Overview / Agenda (nếu > 5 slide) HOẶC Problem Statement
SLIDE 3–N   — Nội dung (1 ý chính / slide, có narrative flow)
SLIDE N+1   — Key Takeaways (bullet kết luận quan trọng nhất)
SLIDE N+2   — Next Steps / CTA (nếu cần)
```

**Nguyên tắc narrative flow:**
- Mỗi slide trả lời 1 câu hỏi cụ thể
- Tiêu đề slide = insight / kết luận, không phải chủ đề
- Giữa các slide phải có logic dẫn dắt (vì sao → như thế nào → kết quả)
- Người đọc không cần nghe thuyết trình vẫn hiểu được nội dung

---

## GIAI ĐOẠN 1 — Quy tắc thiết kế

### 1.1 Modern Tech Design Rules (BẮT BUỘC)

**Nền và không gian:**
```css
/* Nền tối mặc định */
background: #080c14;  /* Deep Navy */
/* Có thể thêm texture tinh tế */
background-image: radial-gradient(ellipse at 20% 50%, rgba(0,74,239,0.08) 0%, transparent 60%),
                  radial-gradient(ellipse at 80% 20%, rgba(13,209,255,0.06) 0%, transparent 50%);

/* Nền sáng (khi phù hợp với nội dung) */
background: #f8f9fc;
```

**Card và container:**
```css
/* Glass card — dùng cho card nội dung trên nền tối */
background: rgba(255,255,255,0.04);
border: 1px solid rgba(255,255,255,0.1);
backdrop-filter: blur(12px);
border-radius: 12px;

/* Solid card — dùng cho highlight, call-out */
background: rgba(0,74,239,0.12);
border: 1px solid rgba(0,74,239,0.35);
border-radius: 12px;

/* Elevated card — dùng cho nội dung quan trọng */
background: #111827;
border: 1px solid rgba(255,255,255,0.08);
border-radius: 16px;
box-shadow: 0 20px 60px rgba(0,0,0,0.4), 0 0 0 1px rgba(255,255,255,0.05);
```

**Typography:**
```css
/* Heading: sắc nét, có trọng lượng nhưng không thô */
font-weight: 700;          /* không dùng 900 */
letter-spacing: -0.02em;   /* tight tracking cho heading lớn */
line-height: 1.1;

/* Body: dễ đọc, thoải mái */
font-weight: 400;
letter-spacing: 0;
line-height: 1.6;

/* Accent text: dùng màu, không phải uppercase */
color: var(--blue);
font-weight: 600;

/* KHÔNG dùng: text-transform: uppercase toàn bộ heading */
/* KHÔNG dùng: letter-spacing dương lớn cho heading chính */
```

**Accent và điểm nhấn:**
```css
/* Gradient text cho headline quan trọng */
background: linear-gradient(135deg, #004aef 0%, #0dd1ff 100%);
-webkit-background-clip: text;
-webkit-text-fill-color: transparent;

/* Glow effect cho số liệu nổi bật */
text-shadow: 0 0 40px rgba(0,74,239,0.6);

/* Line accent — thay cho border dày */
border-left: 3px solid var(--blue);   /* vertical accent */
border-bottom: 2px solid var(--mint); /* underline accent */

/* Tag / badge */
background: rgba(0,74,239,0.15);
border: 1px solid rgba(0,74,239,0.4);
border-radius: 4px;
padding: 3px 10px;
font-size: 12px;
font-weight: 600;
color: var(--cyan);
letter-spacing: 0.08em;
text-transform: uppercase;
```

**KHÔNG dùng:**
```
✗ border-radius: 0 (không bo tròn)
✗ box-shadow: 6px 6px 0 (hard shadow offset)
✗ border: 3px+ solid (viền quá dày)
✗ text-transform: uppercase cho toàn bộ body text
✗ Màu flat tương phản quá mạnh mà không có context
```

### 1.2 Information Design Principles

```
Hierarchy:    Cover title 56–80px → Section 36–48px → Card title 24–32px
              → Body 16–18px → Caption/Label 12–13px
              Mỗi cấp phải khác biệt rõ ràng (size + weight + color)

Breathing:    Padding rộng — slide cần "thở"
              Min padding: 80px sides, 60px top/bottom
              Card padding: 32–40px
              Gap giữa elements: 24–32px minimum

Grouping:     Nội dung liên quan → nhóm trong cùng card/section
              Dùng proximity và visual boundary (không phải chỉ border)
              Rule: nếu cần nối bằng text "và", xem xét merge hoặc split khác

Emphasis:     Chỉ 1 điểm nhấn chính mỗi slide (số liệu / insight / hành động)
              Dùng size và màu, không phải bold toàn bộ
              80/20: 20% nội dung mang 80% thông điệp — make it visible

Flow cues:    Số thứ tự (01, 02...) cho danh sách có thứ tự
              Arrow / connector cho quy trình
              Progress indicator cho timeline
              Comparison bracket cho so sánh
```

### 1.3 Bảng màu theo loại nội dung

| Loại slide | Background | Accent chính | Accent phụ | Ghi chú |
|---|---|---|---|---|
| Cover | `#080c14` + gradient overlay | `#004aef` | `#0dd1ff` | Gradient text cho title |
| Section divider | `#004aef` | `#ffffff` | `#ffce00` | Full-color break |
| Data / Stats | `#080c14` | `#00ffaa` | `#0dd1ff` | Số liệu glow effect |
| Process / Steps | `#080c14` | `#0dd1ff` | `#004aef` | Connector lines cyan |
| Comparison | `#080c14` | `#004aef` vs `#00ffaa` | — | Color-code hai phía |
| Quote / Insight | `#0d1117` | `#ffce00` | `#ffffff` | Quote mark lớn |
| Technical / Code | `#060a10` | `#00ffaa` | `#0dd1ff` | Syntax colors nhẹ |
| Takeaways | `#080c14` | `#00ffaa` | `#004aef` | Checkmark accent |
| Light variant | `#f8f9fc` | `#004aef` | `#0a0a14` | Khi cần in / chia sẻ sáng |

### 1.4 Layout patterns (chọn theo loại thông tin)

```
[COVER]       — Title lớn + tagline + category tag + subtle visual
[AGENDA]      — Numbered list + mô tả ngắn từng phần
[TEXT-FOCUS]  — Heading + body paragraph + 1 highlight quote/stat bên phải
[STAT]        — 1–3 số liệu lớn với label + trend + context
[DASHBOARD]   — 4–6 metric cards dạng grid
[STEPS]       — Danh sách có số (01/02/03) + mô tả ngắn từng bước
[FLOW]        — Horizontal / vertical flow với connector arrows
[TIMELINE]    — Timeline với milestones + labels
[COMPARISON]  — 2 cột so sánh (vs / before-after / option A-B)
[TABLE]       — Bảng so sánh nhiều tiêu chí
[DEFINITION]  — Khái niệm lớn + breakdown thành thành phần
[PILLARS]     — 3–4 trụ cột / nguyên tắc trong grid cards
[QUOTE]       — Pull quote lớn + attribution + context
[CODE]        — Code block + annotation / explanation
[DIAGRAM]     — ASCII / CSS diagram + mô tả
[SPLIT]       — 50/50 nội dung + visual / ví dụ cụ thể
[TAKEAWAYS]   — Checklist / bullet kết luận + CTA
```

---

## GIAI ĐOẠN 2 — Viết HTML

### 2.1 Cấu trúc file bắt buộc

Mỗi slide là một `<section class="slide slide-[layout]">`:

```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Tên presentation]</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Space+Grotesk:wght@500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  <style>/* CSS nhúng sẵn — xem 2.2 */</style>
</head>
<body>
  <!-- Slide deck -->
  <div class="deck">
    <section class="slide slide-cover active" data-slide="1">...</section>
    <section class="slide slide-content" data-slide="2">...</section>
    <!-- ... -->
  </div>

  <!-- Navigation bar — bottom center -->
  <div class="nav-bar">
    <button class="nav-btn" id="btn-prev" onclick="navigate(-1)" disabled>
      <svg><!-- left arrow --></svg>
    </button>
    <div class="nav-info">
      <span class="slide-counter"><b id="current">1</b> <span class="sep">/</span> <span id="total">N</span></span>
    </div>
    <button class="nav-btn" id="btn-next" onclick="navigate(1)">
      <svg><!-- right arrow --></svg>
    </button>
  </div>

  <!-- Progress bar — top edge -->
  <div class="progress-track"><div class="progress-fill" id="progress"></div></div>

  <!-- Slide number — top right -->
  <div class="slide-num" id="slide-num">01</div>

  <script>/* JS — xem 2.3 */</script>
</body>
</html>
```

### 2.2 CSS Variables và base styles

```css
:root {
  /* Brand colors */
  --blue:       #004aef;
  --blue-light: #2563ff;
  --blue-dim:   rgba(0, 74, 239, 0.15);
  --mint:       #00ffaa;
  --mint-dim:   rgba(0, 255, 170, 0.12);
  --amber:      #ffce00;
  --amber-dim:  rgba(255, 206, 0, 0.12);
  --cyan:       #0dd1ff;
  --cyan-dim:   rgba(13, 209, 255, 0.12);

  /* Backgrounds */
  --bg-base:    #080c14;
  --bg-surface: #0d1117;
  --bg-card:    rgba(255, 255, 255, 0.04);
  --bg-card-hover: rgba(255, 255, 255, 0.07);

  /* Text */
  --text-primary:   #f0f4ff;
  --text-secondary: rgba(240, 244, 255, 0.6);
  --text-muted:     rgba(240, 244, 255, 0.35);

  /* Borders */
  --border-subtle:  rgba(255, 255, 255, 0.08);
  --border-default: rgba(255, 255, 255, 0.14);
  --border-strong:  rgba(255, 255, 255, 0.25);
  --border-accent:  rgba(0, 74, 239, 0.4);

  /* Shadows */
  --shadow-card: 0 4px 24px rgba(0, 0, 0, 0.3);
  --shadow-elevated: 0 20px 60px rgba(0, 0, 0, 0.5);

  /* Typography */
  --font-display: 'Space Grotesk', 'Inter', system-ui, sans-serif;
  --font-body:    'Inter', system-ui, sans-serif;
  --font-mono:    'JetBrains Mono', 'Fira Code', monospace;

  /* Spacing */
  --slide-pad-x: 80px;
  --slide-pad-y: 60px;
  --gap:         32px;
  --gap-sm:      16px;
  --gap-lg:      48px;

  /* Radius */
  --radius-sm:  6px;
  --radius-md:  12px;
  --radius-lg:  20px;

  /* Transitions */
  --transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Reset và base */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  background: var(--bg-base);
  color: var(--text-primary);
  font-family: var(--font-body);
  font-size: 16px;
  line-height: 1.6;
  overflow: hidden;
  height: 100vh;
}

/* Slide container */
.deck {
  width: 100vw;
  height: 100vh;
  position: relative;
}

.slide {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: var(--slide-pad-y) var(--slide-pad-x);
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.4s ease;
  overflow: hidden;
}

.slide.active {
  opacity: 1;
  pointer-events: all;
}

/* Background texture cho slide tối */
.slide::before {
  content: '';
  position: absolute;
  inset: 0;
  background-image:
    radial-gradient(ellipse at 15% 50%, rgba(0,74,239,0.07) 0%, transparent 55%),
    radial-gradient(ellipse at 85% 15%, rgba(13,209,255,0.05) 0%, transparent 45%);
  pointer-events: none;
}

/* Typography scale */
.display    { font-family: var(--font-display); font-size: clamp(40px, 6vw, 80px); font-weight: 700; letter-spacing: -0.03em; line-height: 1.05; }
.h1         { font-family: var(--font-display); font-size: clamp(32px, 4vw, 56px); font-weight: 700; letter-spacing: -0.02em; line-height: 1.1; }
.h2         { font-family: var(--font-display); font-size: clamp(24px, 3vw, 40px); font-weight: 600; letter-spacing: -0.015em; line-height: 1.2; }
.h3         { font-size: clamp(18px, 2vw, 28px); font-weight: 600; letter-spacing: -0.01em; line-height: 1.3; }
.body-lg    { font-size: clamp(16px, 1.5vw, 20px); line-height: 1.65; }
.body       { font-size: 16px; line-height: 1.6; }
.caption    { font-size: 13px; color: var(--text-secondary); }
.label      { font-size: 12px; font-weight: 600; letter-spacing: 0.08em; text-transform: uppercase; color: var(--text-muted); }
.mono       { font-family: var(--font-mono); }

/* Gradient text utility */
.gradient-text {
  background: linear-gradient(135deg, var(--blue-light) 0%, var(--cyan) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* Cards */
.card {
  background: var(--bg-card);
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-md);
  padding: var(--gap);
  backdrop-filter: blur(12px);
}

.card-accent {
  background: var(--blue-dim);
  border: 1px solid var(--border-accent);
  border-radius: var(--radius-md);
  padding: var(--gap);
}

.card-elevated {
  background: var(--bg-surface);
  border: 1px solid var(--border-default);
  border-radius: var(--radius-lg);
  padding: var(--gap);
  box-shadow: var(--shadow-elevated);
}

/* Tags / badges */
.tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 12px;
  background: var(--blue-dim);
  border: 1px solid var(--border-accent);
  border-radius: var(--radius-sm);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--cyan);
}

/* Dividers */
.divider { height: 1px; background: var(--border-subtle); margin: var(--gap-sm) 0; }
.accent-line { height: 3px; width: 48px; background: var(--blue); border-radius: 2px; margin-bottom: var(--gap-sm); }

/* Grid layouts */
.grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: var(--gap); }
.grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: var(--gap); }
.grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: var(--gap-sm); }
.split  { display: grid; grid-template-columns: 1fr 1fr; gap: var(--gap-lg); align-items: center; }

/* Stats */
.stat-number {
  font-family: var(--font-display);
  font-size: clamp(48px, 7vw, 96px);
  font-weight: 700;
  letter-spacing: -0.04em;
  line-height: 1;
  color: var(--mint);
}
.stat-unit  { font-size: 0.4em; font-weight: 500; color: var(--text-secondary); }
.stat-label { font-size: 14px; color: var(--text-secondary); margin-top: 8px; }
.stat-trend { font-size: 13px; font-weight: 600; }
.stat-trend.up   { color: var(--mint); }
.stat-trend.down { color: #ff4d6d; }

/* Numbered list (steps) */
.step-list { list-style: none; display: flex; flex-direction: column; gap: var(--gap-sm); }
.step-item { display: flex; gap: 20px; align-items: flex-start; }
.step-num {
  flex-shrink: 0;
  width: 40px; height: 40px;
  background: var(--blue-dim);
  border: 1px solid var(--border-accent);
  border-radius: var(--radius-sm);
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-mono);
  font-size: 13px; font-weight: 600;
  color: var(--blue-light);
}

/* Feature list */
.feature-list { list-style: none; display: flex; flex-direction: column; gap: 12px; }
.feature-list li { display: flex; gap: 12px; align-items: flex-start; }
.feature-list li::before {
  content: '—';
  color: var(--blue);
  font-weight: 600;
  flex-shrink: 0;
  margin-top: 2px;
}

/* Quote */
.quote-wrapper { position: relative; padding: 32px 40px; }
.quote-mark {
  position: absolute;
  top: 0; left: 0;
  font-size: 120px;
  line-height: 1;
  color: var(--amber);
  opacity: 0.3;
  font-family: Georgia, serif;
}
.quote-text { font-size: clamp(20px, 2.5vw, 32px); font-weight: 500; line-height: 1.4; font-style: italic; }
.quote-source { margin-top: 20px; font-size: 14px; color: var(--text-secondary); }

/* Progress indicator */
.progress-dots { display: flex; gap: 8px; align-items: center; }
.progress-dot { width: 8px; height: 8px; border-radius: 50%; background: var(--border-default); }
.progress-dot.done { background: var(--blue); }
.progress-dot.active { background: var(--cyan); width: 24px; border-radius: 4px; }

/* Code block */
.code-block {
  background: #060a10;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-md);
  padding: 24px;
  font-family: var(--font-mono);
  font-size: 14px;
  line-height: 1.7;
  overflow-x: auto;
}
.code-highlight { background: rgba(0,74,239,0.2); border-left: 2px solid var(--blue); }

/* Navigation */
.nav-bar {
  position: fixed;
  bottom: 32px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  gap: 20px;
  background: rgba(13, 17, 23, 0.85);
  border: 1px solid var(--border-default);
  border-radius: 100px;
  padding: 10px 20px;
  backdrop-filter: blur(16px);
  z-index: 100;
}

.nav-btn {
  width: 36px; height: 36px;
  background: transparent;
  border: 1px solid var(--border-subtle);
  border-radius: 50%;
  color: var(--text-primary);
  cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  transition: var(--transition);
}
.nav-btn:hover:not(:disabled) { background: var(--blue-dim); border-color: var(--border-accent); }
.nav-btn:disabled { opacity: 0.3; cursor: not-allowed; }

.slide-counter { font-size: 14px; font-weight: 500; color: var(--text-secondary); min-width: 56px; text-align: center; }
.slide-counter b { color: var(--text-primary); }
.sep { margin: 0 4px; }

/* Progress bar */
.progress-track {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: var(--border-subtle);
  z-index: 100;
}
.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--blue), var(--cyan));
  transition: width 0.4s ease;
}

/* Slide number badge */
.slide-num {
  position: fixed;
  top: 24px; right: 32px;
  font-family: var(--font-mono);
  font-size: 12px;
  font-weight: 500;
  color: var(--text-muted);
  z-index: 100;
}
```

### 2.3 JS Navigation — nhúng sẵn trong file

```javascript
const slides = document.querySelectorAll('.slide');
const total = slides.length;
let current = 0;

document.getElementById('total').textContent = total;
updateSlideNum();

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
  document.getElementById('progress').style.width = `${((current + 1) / total) * 100}%`;
  document.getElementById('btn-prev').disabled = current === 0;
  document.getElementById('btn-next').disabled = current === total - 1;
  updateSlideNum();
  history.replaceState(null, '', `#slide-${current + 1}`);
}

function updateSlideNum() {
  document.getElementById('slide-num').textContent = String(current + 1).padStart(2, '0');
}

// Keyboard
document.addEventListener('keydown', e => {
  if (e.key === 'ArrowRight' || e.key === 'ArrowDown' || e.key === ' ') { e.preventDefault(); navigate(1); }
  if (e.key === 'ArrowLeft'  || e.key === 'ArrowUp')                    { e.preventDefault(); navigate(-1); }
  if (e.key === 'f' || e.key === 'F') document.documentElement.requestFullscreen?.();
  if (e.key === 'Escape') document.exitFullscreen?.();
  if (e.key === 'Home') { current = -1; navigate(1); }
  if (e.key === 'End')  { current = total - 2; navigate(1); }
});

// Touch swipe
let touchX = 0;
document.addEventListener('touchstart', e => { touchX = e.touches[0].clientX; }, { passive: true });
document.addEventListener('touchend',   e => {
  const dx = e.changedTouches[0].clientX - touchX;
  if (Math.abs(dx) > 50) navigate(dx < 0 ? 1 : -1);
}, { passive: true });

// Hash navigation on load
const hash = location.hash.match(/#slide-(\d+)/);
if (hash) { const idx = parseInt(hash[1]) - 1; if (idx > 0 && idx < total) { current = idx - 1; navigate(1); } }

// Init progress
document.getElementById('progress').style.width = `${(1 / total) * 100}%`;
```

### 2.4 Quy tắc viết nội dung slide

**Lượng text:**
```
Title slide:    Tiêu đề (1–2 dòng) + tagline (1 dòng) + tag category
Content slide:  1 heading + tối đa 3–4 bullet HOẶC 1 đoạn ngắn (40–60 từ)
Stat slide:     Số liệu + label + 1 câu context
Quote slide:    1 quote (20–40 từ) + attribution
Code slide:     10–15 dòng code + 2–3 bullet annotation
```

**Hierarchy trong một slide:**
```
1. Heading: trả lời "Slide này nói gì?" → 1 dòng, là kết luận
2. Sub: trả lời "Tại sao?" hoặc "Như thế nào?" → 1 dòng context
3. Body: bằng chứng, số liệu, bước thực hiện, ví dụ
4. Caption: nguồn, ghi chú, caveat
```

**Từ nối và structure markers:**
```
Dùng số thứ tự: 01 / 02 / 03 thay vì bullets khi có thứ tự
Dùng → cho flow / kết quả
Dùng vs cho so sánh
Dùng tag [INSIGHT] [WARNING] [TIP] cho call-out
```

---

## GIAI ĐOẠN 3 — Kiểm tra trước khi xuất

### Checklist chất lượng

**Nội dung:**
- [ ] Mỗi slide trả lời đúng 1 câu hỏi cụ thể?
- [ ] Tiêu đề slide là insight / kết luận, không phải topic?
- [ ] Người đọc không cần thuyết trình viên vẫn hiểu được?
- [ ] Có narrative flow — slide sau logic từ slide trước?
- [ ] Không có slide nào vượt quá 60 từ body text?
- [ ] Số liệu, ngày tháng, tên riêng chính xác?

**Thiết kế:**
- [ ] Gradient/texture nền tinh tế, không chiếm visual?
- [ ] Card dùng glass effect hoặc solid với border nhẹ?
- [ ] Chỉ 1 điểm nhấn màu chính mỗi slide?
- [ ] Font weight và size tạo hierarchy rõ ràng?
- [ ] Spacing đủ rộng — không có cảm giác chật?
- [ ] Contrast text/background đạt WCAG AA (4.5:1)?

**Kỹ thuật:**
- [ ] File HTML standalone (tự chứa, không cần CDN ngoại trừ Google Fonts)?
- [ ] Arrow key và Space navigation hoạt động?
- [ ] Progress bar và slide counter đúng?
- [ ] Fullscreen (F key) hoạt động?
- [ ] Touch/swipe hoạt động?
- [ ] URL hash sync hoạt động (#slide-3)?
- [ ] Không có console error?

---

## GIAI ĐOẠN 4 — Xuất file

### 4.1 Tên file

```
Format: [slug-nội-dung]-slides.html
Ví dụ:  ai-trong-giao-duc-slides.html
        q4-2024-review-slides.html
        product-strategy-slides.html
```

Lưu tại: `E:\Claude-Code\ExpertPro\outputs\`

### 4.2 Thông báo sau khi tạo xong

```
Thông báo:
1. Tên file + đường dẫn đầy đủ
2. Số lượng slide + cấu trúc tóm tắt
3. Cách xem: "Mở bằng browser, dùng ← → hoặc Space để chuyển slide"
4. Phím tắt: ← → Space | F (fullscreen) | Home/End
5. Hỏi: muốn điều chỉnh layout, màu sắc, hay nội dung nào không?
```

---

## Xử lý tình huống đặc biệt

### Khi nội dung quá nhiều text

```
→ Tóm tắt bullet (max 4 bullets/slide, mỗi bullet 1 dòng)
→ Tách thành nhiều slide nếu thực sự cần
→ Đưa chi tiết vào speaker notes: <div class="speaker-notes" hidden>
→ Báo người dùng: "Tôi đã tóm tắt phần [X] thành 3 điểm chính..."
```

### Khi có số liệu / data

```
→ Dùng layout STAT với số lớn + màu mint glow
→ Thêm trend indicator: ↑ +12% (màu mint) hoặc ↓ -5% (màu đỏ)
→ Context line: "So với Q3/2023" hoặc "Trên 1000 người dùng"
→ Nếu có nhiều số: dùng layout DASHBOARD với grid cards
→ Không vẽ chart SVG phức tạp — số liệu đơn giản hóa thành Big Stat
```

### Khi nội dung là quy trình / workflow

```
→ Dùng layout STEPS với số thứ tự 01/02/03
→ Hoặc layout FLOW với connector arrows
→ Mỗi bước: tên ngắn (2–4 từ) + mô tả 1 dòng + output/kết quả
→ Nếu nhiều hơn 5 bước: chia thành 2 slide (Phase 1 / Phase 2)
```

### Khi nội dung là so sánh

```
→ Dùng layout COMPARISON: 2 cột rõ ràng, color-coded
→ Tiêu đề mỗi cột: tên phương án / trạng thái
→ Mỗi dòng: 1 tiêu chí so sánh
→ Highlight winner/preferred option bằng border accent màu mint
→ Tránh so sánh quá 5 tiêu chí trên 1 slide
```

### Khi nội dung là code / technical

```
→ Dark background bắt buộc (#060a10)
→ Font mono, syntax colors đơn giản (không dùng full syntax highlighter)
→ Màu: keywords = cyan, strings = mint, comments = text-muted
→ Giới hạn 10–12 dòng code/slide
→ Highlight dòng quan trọng bằng background rgba(0,74,239,0.2)
→ Thêm annotation bên phải hoặc bên dưới bằng bullet ngắn
```

### Khi nội dung là khái niệm / định nghĩa

```
→ Dùng layout DEFINITION: term lớn + breakdown thành 3–4 thành phần
→ Hoặc PILLARS: 3–4 card với icon (emoji OK) + title + 1–2 câu mô tả
→ Ưu tiên analogy và ví dụ cụ thể hơn định nghĩa trừu tượng
→ Thêm "Tại sao quan trọng?" như 1 sub-point
```

### Khi chỉ có topic, chưa có nội dung

```
→ Tạo structure gợi ý với placeholder có ý nghĩa
→ Mark bằng [TODO: thêm số liệu thực tế] để người dùng biết
→ Giải thích brief structure: "Tôi đề xuất X slide theo cấu trúc..."
→ Hỏi xem structure có phù hợp trước khi điền đầy đủ
```
