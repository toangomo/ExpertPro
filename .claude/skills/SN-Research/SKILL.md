---
name: SN-Research
description: >
  Dùng skill này khi người dùng muốn NGHIÊN CỨU, TÌM HIỂU, PHÂN TÍCH một chủ đề, tài liệu,
  câu hỏi, hoặc vấn đề nào đó — và mong đợi kết quả có chiều sâu, có dẫn chứng, có kết luận rõ ràng.

  Trigger keywords: "nghiên cứu", "tìm hiểu", "phân tích", "research", "deep dive",
  "tìm kiếm thông tin", "cho tôi biết về", "giải thích", "so sánh", "đánh giá",
  "tổng hợp", "báo cáo về", "tìm hiểu giúp tôi", "tôi muốn hiểu", "thắc mắc về".

  KHÔNG dùng cho: câu hỏi nhanh 1 câu trả lời đơn giản, yêu cầu viết code, tạo nội dung sáng tạo.
  Ranh giới: nếu người dùng hỏi một thực tế đơn giản → trả lời trực tiếp.
  Nếu họ muốn hiểu sâu một vấn đề / đưa ra quyết định dựa trên research → dùng skill này.
---

# Skill: SN-Research — Nghiên Cứu & Phân Tích Có Chiều Sâu

## Nguyên tắc nền tảng

Research tốt không phải tìm được nhiều thông tin nhất — mà là **giảm uncertainty một cách có hệ thống**: biết rõ mình biết gì, không biết gì, và tin chắc điều gì với mức độ nào.

Ba lỗi cần tránh tuyệt đối:
1. **Confirmation bias** — tìm evidence để xác nhận kết luận đã có sẵn
2. **Nhầm data với insight** — trình bày số liệu mà không phân tích ý nghĩa
3. **Dừng sớm** — dừng ở câu trả lời đầu tiên thay vì câu trả lời tốt nhất

---

## GIAI ĐOẠN 0 — Làm rõ yêu cầu (trước khi bắt đầu search)

### 0.1 Chuyển topic thành câu hỏi cụ thể

Người dùng thường mô tả topic, không phải câu hỏi. Phải chuyển thành câu hỏi có thể trả lời được:

```
Topic:        "Nghiên cứu về AI trong marketing"
Câu hỏi tốt: "AI đang thay đổi quy trình marketing như thế nào trong 2024–2025,
               và doanh nghiệp Việt Nam nên ưu tiên ứng dụng công cụ nào trước?"
```

### 0.2 Bốn câu hỏi bắt buộc — trả lời TRƯỚC khi search

**Q1: Câu hỏi nghiên cứu thực sự là gì?**
Một câu duy nhất, cụ thể, có thể trả lời được.

**Q2: Kết quả dùng để làm gì?**

| Mục đích | Yêu cầu |
|---|---|
| Ra quyết định kinh doanh | Số liệu cụ thể, actionable, nguồn uy tín |
| Viết content | Fact thú vị, góc nhìn mới, ví dụ |
| Học lĩnh vực mới | Mental model, framework, không cần exhaustive |
| Báo cáo stakeholder | Executive summary, số liệu key, recommendation |
| Nghiên cứu học thuật | Peer-reviewed, methodology rõ ràng |

**Q3: Đã biết / Giả định / Chưa biết / Không cần gì?**
```
Đã biết:   [...]
Giả định:  [...] (cần verify)
Chưa biết: [...] (cần research)
Không cần: [...] (out of scope)
```

**Q4: Câu trả lời nào sẽ thay đổi quyết định?**
Nếu dù kết quả ra sao cũng không thay đổi gì → research đó không cần thiết.

### 0.3 Xác định scope

```
Chủ đề chính:    [Một câu rõ ràng]
Phạm vi thời gian: [Giai đoạn cụ thể nếu cần]
Phạm vi địa lý:  [Toàn cầu / Việt Nam / ...]
Độ sâu:          [Overview nhanh / Medium / Deep dive]
Output mong đợi: [Sẽ deliver gì: báo cáo ngắn / phân tích / bảng so sánh / ...]
OUT OF SCOPE:    [Không research những gì]
```

### 0.4 Đặt 2–3 hypothesis trước khi search

Thay vì search "mở", đặt hypothesis để định hướng:
```
H1: [Giả thuyết 1 — có thể đúng]
H2: [Giả thuyết 2 — hướng khác]
H3: [Giả thuyết 3 — đối lập]

Với mỗi hypothesis: "Evidence nào sẽ confirm/refute nó?"
```

**→ Tóm tắt GIAI ĐOẠN 0 ra cho người dùng xem trước khi tiếp tục.**
Nếu yêu cầu quá ngắn gọn → hỏi thêm Q2 (mục đích). Nếu đã đủ rõ → tự suy luận và ghi rõ assumption.

---

## GIAI ĐOẠN 1 — Thu thập thông tin

### 1.1 Đánh giá tier nguồn

Trước khi dùng bất kỳ thông tin nào, xác định tier:

| Tier | Loại nguồn | Cách dùng |
|------|-----------|-----------|
| **T1** | Nghiên cứu gốc, peer-reviewed, data chính phủ, báo cáo trực tiếp từ công ty | Dùng trực tiếp, cite rõ |
| **T2** | McKinsey, Gartner, CB Insights, WSJ, FT, Bloomberg, sách practitioners | Dùng, ghi rõ là secondary |
| **T3** | Blog practitioners có kinh nghiệm, aggregated reports | Tham khảo, cần cross-check |
| **T4** | Social media, forum, sponsored content, nguồn ẩn danh | Chỉ dùng để tìm hướng, không cite |

**Quy tắc cross-verification:**
- Claim quan trọng → cần ≥ 2 nguồn T1–T2 độc lập xác nhận
- Số liệu cụ thể → trace về nguồn gốc (không dùng số liệu "cite lại cite lại")
- Nguồn mâu thuẫn → phân tích nguyên nhân, không bỏ qua

### 1.2 Search strategy

**Dùng WebSearch** với queries cụ thể và nhiều góc:

```
Angle 1 — Evidence ủng hộ:
  "[topic] research study findings [năm]"
  "[topic] data statistics [region]"

Angle 2 — Evidence phản bác (bắt buộc):
  "[quan điểm] criticism problems"
  "[quan điểm] debunked alternative explanation"
  "why [quan điểm] is wrong"

Angle 3 — Nguồn gốc số liệu:
  "[số liệu viral] source original study"
  "[claim] methodology sample size"

Angle 4 — Expert disagreement:
  "[topic] expert debate controversy"
  "[topic] conflicting research"
```

**Số lần search tối thiểu theo độ sâu:**
- Overview nhanh: 3–5 searches
- Medium: 6–10 searches
- Deep dive: 10+ searches, đa nguồn, đa ngôn ngữ nếu cần

### 1.3 Ghi chú có cấu trúc (dùng trong quá trình search)

Với mỗi nguồn quan trọng, ghi chú theo cấu trúc:
```
Nguồn: [Tên / URL / Tác giả / Năm]  |  Tier: [1/2/3/4]
Claim chính: [Mô tả ngắn]
Evidence/Data: [Số liệu, ví dụ cụ thể]
Methodology: [Sample size? Thu thập data như thế nào?]
Mâu thuẫn: [Điểm nào khác với nguồn khác?]
Relevance: [Trả lời phần nào của câu hỏi chính?]
```

---

## GIAI ĐOẠN 2 — Phân tích

### 2.1 Tách biệt Data → Interpretation → Conclusion

```
DATA (fact quan sát được):
"70% startup Việt Nam đóng cửa trong 3 năm đầu" [nguồn X]

INTERPRETATION (ý nghĩa — đây là quan điểm của tôi):
"Môi trường startup Việt Nam có tỷ lệ thất bại cao so với..."

CONCLUSION (hành động / bài học):
"Startup Việt Nam cần ưu tiên X trước khi raise vốn"
[Cần evidence kết nối X với tỷ lệ sống sót]
```

Luôn label rõ: đây là data / interpretation / conclusion.

### 2.2 Kiểm tra logical fallacies bắt buộc

Tự hỏi với mỗi kết luận:

- **Correlation ≠ Causation?** — Có yếu tố thứ ba không? Chiều quan hệ có thể đảo?
- **Survivorship bias?** — Tôi chỉ nhìn vào người/công ty thành công, bỏ qua những người thất bại?
- **Confirmation bias?** — Tôi có chủ động tìm evidence phản bác không, hay chỉ tìm evidence ủng hộ?
- **False dichotomy?** — Có thực sự chỉ hai lựa chọn không?
- **Anecdote ≠ Evidence?** — 2–3 case studies có đủ để kết luận không?
- **Appeal to authority?** — Chuyên gia nói vậy có nghĩa là đúng không?

### 2.3 Xử lý dữ liệu mâu thuẫn

Khi nguồn cho kết quả khác nhau — đây là cơ hội, không phải vấn đề:

```
Bước 1: Xác nhận mâu thuẫn là thực (không phải do khác định nghĩa / giai đoạn / sample)
Bước 2: Tìm nguồn gốc — methodology khác? Sample khác? Conflict of interest?
Bước 3: Đánh giá độ tin cậy — sample nào lớn hơn? Rigorous hơn? Peer-reviewed?
Bước 4: Trình bày thành thật — "Nguồn A cho thấy X, nguồn B cho thấy Y.
         Sự khác biệt có thể do [...]. Chúng tôi tin nguồn A hơn vì [...]"
```

**KHÔNG bao giờ:** chọn số liệu thuận tiện nhất và im lặng bỏ qua số còn lại.

### 2.4 Framework phân tích theo mục đích

**Tìm nguyên nhân → Five Whys:**
Hỏi "Tại sao?" 5 lần để đến root cause, không dừng ở symptom.

**So sánh options → Structured Comparison:**
```
| Tiêu chí | Option A | Option B | Trọng số |
|---|---|---|---|
| [Tiêu chí 1] | [1-5] | [1-5] | [%] |
| [Tiêu chí 2] | [1-5] | [1-5] | [%] |
| TỔNG (weighted) | | | |
Lưu ý: bảng hỗ trợ quyết định, không thay thế judgment.
```

**Phân tích trend → Time-series:**
1. Trend kéo dài bao lâu? (momentum)
2. Tốc độ thay đổi tăng hay giảm? (acceleration)
3. Có inflection point nào? Tại sao?
4. Leading indicators (predict trước) là gì?
5. Điều kiện nào đảo ngược trend?

**Đánh giá rủi ro → Pre-mortem:**
Giả sử 1 năm nữa quyết định này thất bại — lý do nào? Likelihood / Impact / Mitigation.

---

## GIAI ĐOẠN 3 — Rút kết luận

### 3.1 Template kết luận có cơ sở

Mỗi kết luận chính phải đi kèm:
```
CLAIM: [Một câu, rõ ràng]
EVIDENCE:
  1. [Evidence cụ thể] — nguồn: [Tier X, tên nguồn]
  2. [Evidence cụ thể] — nguồn: [...]
REASONING: [Tại sao evidence này support claim]
LIMITATIONS: [Điều gì evidence này không chứng minh được / điều kiện có thể sai]
CONFIDENCE: [ ] Cao / [ ] Trung bình / [ ] Thấp
```

### 3.2 Phân biệt độ mạnh kết luận

```
MẠNH — nói với confidence cao:
  "Data từ 5 nghiên cứu độc lập với 10,000+ participants cho thấy X"

TRUNG BÌNH — có cơ sở nhưng cần thêm evidence:
  "Evidence hiện tại gợi ý X, nhưng cần thêm nghiên cứu, đặc biệt trong context Y"

YẾU — hypothesis, không phải kết luận:
  "Dựa trên pattern quan sát, có thể X — đây là hypothesis cần test thêm"

SAI — TUYỆT ĐỐI TRÁNH:
  ❌ "Rõ ràng là X" (khi chỉ có 1-2 anecdotes)
  ❌ "Chắc chắn X" (khi evidence còn mâu thuẫn)
  ❌ "X là nguyên nhân của Y" (khi chỉ có correlation)
```

### 3.3 Rút bài học — tiêu chí 3S

Bài học tốt phải đạt cả ba:

**Specific** — cụ thể, không chung chung:
```
❌ "Cần hiểu khách hàng tốt hơn"
✅ "Validate PMF bằng cách đạt NPS > 40 và retention > 60% sau 6 tháng trước khi raise Series A"
```

**Actionable** — biết làm gì tiếp:
```
Ai làm? / Bắt đầu từ đâu? / Làm thế nào biết đúng? / Đo bằng gì?
```

**Transferable** — áp dụng được ngoài context gốc:
```
Kiểm tra: "Bài học này đúng với ngành/giai đoạn/quy mô khác không?
           Điều kiện gì để nó đúng / không đúng?"
```

---

## GIAI ĐOẠN 4 — Trình bày kết quả

### 4.1 Pyramid Principle — luôn đặt kết luận trước

```
Level 1 — ANSWER (đầu tiên, luôn luôn):
"[Kết luận chính — 1-2 câu]"

Level 2 — KEY POINTS (3-5 điểm hỗ trợ answer):
• [Point 1 + evidence ngắn]
• [Point 2 + evidence ngắn]
• [Point 3 + evidence ngắn]

Level 3 — SUPPORTING DATA (cho người muốn đào sâu):
[Chi tiết số liệu, methodology, nguồn đầy đủ]
```

### 4.2 Chọn format output theo mục đích

**Short (< 500 từ):** Câu hỏi nhanh, cần answer rõ
```
Bottom line (1-2 câu) → Key findings (3-5 bullets) → Recommendation → Caveats
```

**Medium (500–2000 từ):** Phân tích cho nội bộ / content
```
Executive summary → Background & câu hỏi → Key findings (có evidence) →
Analysis → Conclusions & recommendations → Limitations
```

**Long (> 2000 từ):** Báo cáo stakeholder / nghiên cứu sâu
```
Executive summary → Introduction → Methodology → Findings (sections riêng) →
Discussion → Conclusions → Recommendations → Limitations → References
```

### 4.3 Quy tắc trình bày số liệu

```
❌ Không context: "Conversion rate là 3.2%"
✅ Có context:    "Conversion rate là 3.2%, so với benchmark ngành 2.5%
                   và mức của chúng ta năm ngoái là 2.8%"

❌ False precision: "AI sẽ tạo 12.3 triệu việc làm"
✅ Honest range:    "Ước tính 8–15 triệu, tùy tốc độ adoption và policy"
```

### 4.4 Thành thật về giới hạn

Luôn nêu rõ ít nhất 2–3 trong số:
- Sample size đủ chưa? Representative chưa?
- Có selection bias không?
- Data có còn mới không?
- Findings từ nước khác có apply Việt Nam không?
- Có conflict of interest ở nguồn nào không?
- Còn alternative explanation nào chưa được explore?

---

## Checklist tự kiểm tra trước khi deliver

### Trước khi search
- [ ] Đã có câu hỏi nghiên cứu cụ thể (không chỉ topic)?
- [ ] Đã biết kết quả dùng để làm gì?
- [ ] Đã xác định scope + out of scope?
- [ ] Đã có 2–3 hypothesis để test?

### Trong khi search
- [ ] Đang tìm evidence phản bác, không chỉ evidence ủng hộ?
- [ ] Đang trace số liệu về nguồn gốc (không dùng "cite lại")?
- [ ] Đang đánh giá tier của từng nguồn?
- [ ] Đang dừng đúng lúc (không research vô tận)?

### Khi phân tích
- [ ] Đã tách data / interpretation / conclusion?
- [ ] Đã kiểm tra các logical fallacies?
- [ ] Đã xử lý data mâu thuẫn thành thật?
- [ ] Confidence level của mỗi kết luận có được label rõ?

### Khi trình bày
- [ ] Kết luận được đặt đầu tiên (pyramid)?
- [ ] Số liệu có context so sánh?
- [ ] Limitations được nêu thành thật?
- [ ] Format phù hợp với mục đích?
- [ ] Recommendation rõ ràng, actionable (nếu cần)?

---

## Xử lý các tình huống đặc biệt

### Khi không tìm được đủ thông tin
Không đưa ra kết luận mà bịa evidence. Thay vào đó:
```
"Không tìm được đủ evidence để kết luận X. Những gì hiện có:
 [tóm tắt những gì đã tìm]
Để có câu trả lời đáng tin hơn, cần:
 [nguồn / loại evidence còn thiếu]"
```

### Khi câu hỏi quá rộng
Đề xuất thu hẹp thay vì research vô tận:
```
"Câu hỏi này quá rộng để research sâu trong một lần.
Tôi đề nghị focus vào [phần cụ thể] vì [lý do].
Bạn có muốn điều chỉnh scope không?"
```

### Khi evidence mâu thuẫn hoàn toàn
```
"Evidence về chủ đề này mâu thuẫn đáng kể:
 Trường phái A: [X] — dựa trên [evidence, methodology]
 Trường phái B: [Y] — dựa trên [evidence, methodology]
 Sự khác biệt có thể do [lý do]. Chưa có đủ consensus để kết luận dứt khoát."
```

### Khi người dùng gửi tài liệu để phân tích
1. Đọc toàn bộ tài liệu trước khi nhận xét
2. Áp dụng framework phân tích (data / interpretation / conclusion)
3. Kiểm tra logical fallacies trong lập luận của tài liệu
4. So sánh với những gì đã biết / nguồn khác nếu có thể
5. Đưa ra đánh giá có cấu trúc: điểm mạnh / điểm yếu / gaps / khuyến nghị

---

## Tham khảo
- `templates/source-note.md` — template ghi chú nguồn
- `templates/conclusion.md` — template kết luận có cơ sở
- `templates/lesson.md` — template bài học 3S
- `templates/report-short.md` — template báo cáo ngắn
- `templates/report-medium.md` — template báo cáo trung bình
