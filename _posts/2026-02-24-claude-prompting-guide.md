---
title: Claude Prompting Guide
date: 2026-02-23 23:18:00 +0700
categories: [AI, Claude]
tags: [Claude]
---

## Tổng quát những tips để viết prompting hiệu quả.

### 1. Rõ ràng và cụ thể

- Task hoặc câu hỏi của bạn phải luôn có trạng thái rõ ràng.
- Cung cấp context và chi tiết để giúp Claude hiểu bạn cần gì.
- Chia task phức tạp thành nhiều task nhỏ hơn, để quan lý bước.

Bad prompt:
<prompt>
"Tạo giúp tôi một bài thuyết trình (presentation)"
</prompt>

Good prompt:
<promtp>
"Tôi cần tạo một bài thuyết trình 10-slide để chúng tôi họp về sales của quý. Bài thuyết trình nên cover sales đã thực hiện trong Q2, top sản phẩm được bán nhiều nhất, và mục tiêu sales của Q3. Xin cung cấp một outline với mỗi key point dành cho mỗi slide"
</prompt>

Tại sao nó tốt hơn: Good prompt cung cấp chi tiết về task, bao gồm số lượng slide, mục đích bài thuyết trình, và từ key cho từng chủ đề khi cover.

### 2. Sử dụng ví dụ

- Cung cấp ví dụ cho loại output mà bạn muốn tìm.
- Nếu bạn muốn một kiểu format cụ thể, hiển thị như Claude là một ví dụ.

Bad prompt:
<prompt>
"Viết một email chuyên nghiệp"
</prompt>

Good prompt:
<prompt>
Tôi cần viết một email chuyên nghiệp để gửi cho khách hàng nói về việc deplay dự án. Ở đây có email giống vậy tôi đã gửi trước đó như sau:
'Dear [Khách hàng],
Tôi hi vọng bạn vẫn đang khoẻ. Tôi muốn cập nhật cho bạn tiến độ của [Project Name]. Thật không may, chúng ta phải đối mặt với vấn đề không mong muốn khi phải deplay thời gian hoàn thành thêm 2 tuần nữa. Chúng ta sẽ phải làm việt siêng năng để giải quyết nó.
Xin nói cho tôi biết nếu bạn có bất kỳ câu hỏi mối bận tâm nào.
Trân trọng!
[Your Name]'

Giúp tôi soạn một email mới tương tự với giọng điệu và cấu trúc bên trên, nhưng hiện tại chúng ta sẽ deplay suốt một tháng để đáp ứng được chuỗi những vấn đề phát sinh.
</prompt>

Tại sao nó tốt hơn: Good prompt cung cấp một ví dụ mô tả phong cách và giọng điệu, đẻ Claude có điểm tham chiếu để viết email mới.

