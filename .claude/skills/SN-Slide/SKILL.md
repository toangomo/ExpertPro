---
name: SN-Slide
description: >
  Dùng skill này khi người dùng muốn TẠO BẢN TRÌNH BÀY, SLIDE, PRESENTATION từ
  nội dung bất kỳ — văn bản, ý tưởng, dữ liệu, báo cáo — dưới dạng file HTML
  với phong cách Neo-Brutalism và Information Design.

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

# Skill: SN-Slide — Tạo Slide HTML Phong Cách Neo-Brutalism

## Tổng quan

Skill này tạo file HTML slide hoàn chỉnh, tự chứa (standalone), có thể mở thẳng
trên browser. Mỗi output là một file `.html` duy nhất với CSS và JS nhúng sẵn.

**Brand Identity:**
- **Màu chính:** `#004aef` (Deep Electric Blue)
- **Màu phụ:** `#00ffaa` (Neon Mint), `#ffce00` (Volt Yellow), `#0dd1ff` (Cyan Arc)
- **Phong cách:** Neo-Brutalism + Information Design
- **Nền:** `#0a0a14` (Dark Space) hoặc `#f0f0ea` (Brutalist Off-White) tùy nội dung

---

## GIAI ĐOẠN 0 — Phân tích yêu cầu

### 0.1 Đặt 5 câu hỏi nhanh (tự suy luận nếu không được cung cấp)

```
Q1: Nội dung chính là gì? (text/data/ý tưởng/báo cáo?)
Q2: Slide dùng để làm gì? (thuyết trình trực tiếp / tự đọc / demo?)
Q3: Bao nhiêu slide? (ước lượng: 1 ý chính = 1 slide)
Q4: Ngôn ngữ nội dung? (tiếng Việt / tiếng Anh?)
Q5: Nền tối hay sáng? (mặc định: tối)
```

Nếu người dùng cung cấp nội dung nhưng không nói rõ → tự phân tích và ghi rõ assumption.

### 0.2 Lên cấu trúc slide trước khi viết code

```
SLIDE 1 — Title (tiêu đề chính + tagline)
SLIDE 2 — Agenda / Overview (nếu > 5 slide)
SLIDE 3–N — Nội dung (1 ý chính / slide)
SLIDE N+1 — Summary / Key Takeaways
SLIDE N+2 — CTA / Thank You (nếu cần)
```

**Nguyên tắc 1 slide = 1 thông điệp:**
- Mỗi slide truyền tải đúng 1 ý chính
- Tiêu đề slide = kết luận, không phải chủ đề
- Ưu tiên visual hơn text thuần túy

---

## GIAI ĐOẠN 1 — Quy tắc thiết kế

### 1.1 Neo-Brutalism Rules (BẮT BUỘC)

```css
/* Viền: dày, thẳng, không bo tròn */
border: 3px solid #004aef;
border-radius: 0;

/* Shadow: offset cứng, không blur */
box-shadow: 6px 6px 0 #004aef;

/* Chữ: bold, đậm, to */
font-weight: 800 hoặc 900;
text-transform: uppercase (cho heading);
letter-spacing: 0.05em đến 0.1em;

/* Layout: grid thẳng, asymmetric, có tension */
/* Màu: sử dụng contrast mạnh, không dùng màu trung tính nhạt */
/* Hover effect: offset shadow tăng lên */
```

### 1.2 Information Design Principles

```
Hierarchy:  Tiêu đề 48–72px → Sub 24–32px → Body 16–20px → Caption 12–14px
Contrast:   Chữ trên nền tối: #ffffff hoặc accent màu
            Chữ trên nền sáng: #0a0a14 hoặc #004aef
Spacing:    Padding rộng (min 60px sides), white space là điểm mạnh
Alignment:  Dùng grid 12 cột, align consistent
Data viz:   Số liệu lớn + bold + màu accent, không cần chart phức tạp
```

### 1.3 Bảng màu theo loại nội dung

| Loại slide | Background | Primary text | Accent |
|---|---|---|---|
| Title | `#004aef` | `#ffffff` | `#ffce00` |
| Data/Stats | `#0a0a14` | `#ffffff` | `#00ffaa` |
| Quote | `#ffce00` | `#0a0a14` | `#004aef` |
| Process/Steps | `#0a0a14` | `#ffffff` | `#0dd1ff` |
| Summary | `#00ffaa` | `#0a0a14` | `#004aef` |
| Divider | `#0a0a14` | `#004aef` | `#ffffff` |

### 1.4 Layout patterns (chọn theo nội dung)

```
[FULL] — 1 thông điệp lớn, chữ chiếm toàn màn hình
[SPLIT-L] — Chữ trái 50% + Visual/số liệu phải 50%
[SPLIT-R] — Visual trái + Chữ phải
[GRID-2] — 2 cột bằng nhau
[GRID-3] — 3 cột (ví dụ: 3 benefits, 3 steps)
[GRID-4] — 4 ô (metrics dashboard)
[LIST] — Danh sách có icon/số thứ tự to
[QUOTE] — Quote lớn + attribution
[STAT] — 1–3 số liệu lớn + context
[TIMELINE] — Horizontal timeline với events
```

---

## GIAI ĐOẠN 2 — Viết HTML

### 2.1 Cấu trúc file bắt buộc

Dùng template tại `templates/slide-base.html` làm khung.

Mỗi slide là một `<section class="slide slide-[layout]">`:

```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Tên presentation]</title>
  <style>/* CSS nhúng sẵn */</style>
</head>
<body>
  <div class="deck">
    <!-- Slide 1: Title -->
    <section class="slide slide-title active" data-slide="1">
      ...
    </section>
    <!-- Slide 2–N -->
    ...
  </div>
  
  <!-- Navigation -->
  <nav class="nav-controls">
    <button class="btn-prev" onclick="prevSlide()">←</button>
    <span class="slide-counter"><span id="current">1</span> / <span id="total">N</span></span>
    <button class="btn-next" onclick="nextSlide()">→</button>
  </nav>
  
  <!-- Progress bar -->
  <div class="progress-bar"><div class="progress-fill" id="progress"></div></div>
  
  <script>/* JS navigation nhúng sẵn */</script>
</body>
</html>
```

### 2.2 CSS Variables — LUÔN dùng

```css
:root {
  --blue:   #004aef;
  --mint:   #00ffaa;
  --yellow: #ffce00;
  --cyan:   #0dd1ff;
  --dark:   #0a0a14;
  --white:  #ffffff;
  --off-white: #f0f0ea;
  --border: 3px solid var(--blue);
  --shadow: 6px 6px 0 var(--blue);
  --font-heading: 'Space Grotesk', 'Inter', system-ui, sans-serif;
  --font-body: 'Inter', system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', 'Fira Code', monospace;
}
```

### 2.3 JS Navigation — nhúng sẵn trong file

```javascript
// Features cần có:
// - Arrow keys (← →) để chuyển slide
// - Space để next
// - Click nav buttons
// - Touch swipe support
// - URL hash sync (#slide-3)
// - Keyboard shortcut F → fullscreen
// - Keyboard shortcut ESC → exit fullscreen
```

### 2.4 Quy tắc viết HTML content

```
Typography:
- Heading chính: <h1> hoặc <h2>, class="slide-title"
- Sub heading: <h3>, class="slide-subtitle"  
- Body: <p>, class="slide-body"
- Big number/stat: <div class="big-stat">
- Quote: <blockquote class="quote-text">
- Code: <pre><code>

Elements:
- Dùng <ul class="feature-list"> cho danh sách có bullet
- Dùng <ol class="step-list"> cho danh sách có thứ tự
- Dùng <div class="grid-[n]"> cho layout nhiều cột
- Dùng <div class="card"> cho box nội dung
- Dùng <div class="tag"> cho label/badge
- Dùng <div class="divider"> cho đường kẻ ngang
```

### 2.5 Responsive và accessibility

```
- Slide: 16:9 ratio mặc định (1280×720px hoặc 100vw/56.25vw)
- Mobile: stack layout khi < 768px
- Font size: dùng clamp() để scale theo viewport
- Alt text: đặt aria-label cho decorative elements
- Color contrast: minimum 4.5:1 (WCAG AA)
```

---

## GIAI ĐOẠN 3 — Kiểm tra trước khi xuất

### Checklist chất lượng

**Nội dung:**
- [ ] Mỗi slide có đúng 1 thông điệp chính?
- [ ] Tiêu đề slide là kết luận, không phải chủ đề?
- [ ] Không có slide nào quá nhiều text (max 50 từ body text)?
- [ ] Số liệu, ngày tháng, tên riêng chính xác?

**Thiết kế:**
- [ ] Viền dày, không bo tròn, shadow offset?
- [ ] Màu brand được dùng đúng vai trò?
- [ ] Font weight bold/heavy cho heading?
- [ ] Contrast đạt WCAG AA?
- [ ] Spacing rộng, không chật?

**Kỹ thuật:**
- [ ] File HTML standalone (tự chứa, không cần CDN)?
- [ ] Navigation arrow key hoạt động?
- [ ] Progress bar hiển thị đúng?
- [ ] Không có console error?
- [ ] Title tag có tên presentation?

---

## GIAI ĐOẠN 4 — Xuất file

### 4.1 Tên file

```
Format: [slug-nội-dung]-slides.html
Ví dụ: ai-marketing-strategy-slides.html
        q4-report-slides.html
        product-launch-slides.html
```

### 4.2 Thông báo sau khi tạo xong

```
Luôn thông báo:
1. Tên file + đường dẫn
2. Số lượng slide
3. Cách xem: "Mở file bằng browser, dùng ← → để chuyển slide"
4. Phím tắt có sẵn
5. Hỏi xem có muốn chỉnh sửa không (màu, layout, nội dung)
```

---

## Xử lý tình huống đặc biệt

### Khi nội dung quá nhiều text

```
→ Tóm tắt bullet point (max 5 bullets/slide)
→ Tách thành nhiều slide nếu cần
→ Đưa detail vào speaker notes: <div class="speaker-notes" hidden>
→ Nói với người dùng: "Tôi đã tóm tắt [X], bạn muốn giữ đầy đủ không?"
```

### Khi có số liệu / data

```
→ Ưu tiên "Big Stat" layout: số lớn + đơn vị + context nhỏ
→ Dùng màu accent để highlight số quan trọng
→ Thêm trend indicator nếu có (↑↓→)
→ Không dùng chart SVG phức tạp trừ khi cần thiết
```

### Khi nội dung là code / technical

```
→ Dùng dark background bắt buộc
→ Code block với font mono, syntax color đơn giản
→ Giới hạn 10-15 dòng code/slide
→ Highlight dòng quan trọng bằng background color
```

### Khi không có nội dung, chỉ có topic

```
→ Tạo presentation structure gợi ý
→ Điền placeholder content có ý nghĩa (không điền "Lorem ipsum")
→ Mark placeholder bằng [TODO: ...] để người dùng biết cần thay
```

---

## Template & Tham khảo

- `templates/slide-base.html` — Template HTML đầy đủ có thể dùng ngay
- `templates/slide-components.html` — Thư viện các component slide (card, stat, quote, timeline...)
