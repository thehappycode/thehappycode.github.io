---
title: Design Patterns
date: 2025-03-30 10:29:00 +0700
categories: [Design Patterns]
tags: [Design Patterns]
---

## Design Patterns là gì?

**Design patterns** là những kiểu giải pháp cho những vấn đề chung xuất hiện trong *software design*. Nó giống như làm lại những bản thiết kế (pre-made blueprints) mà bạn có thể customize để giải quyết việc lập lại một vấn đề trong thiết kế, trong code của bạn.

Bạn không thể tìm một pattern và copy nó vào trong program, trừ khi bạn có sẵn (off-the-self) những chức năng (functions) hoặc những thư viện (libraries) này. Patterns chính xác không phải là một phần của code, nhưng nó là một khái niệm tổng quát (general concept) cho giải pháp những vấn đề thực tế. Bạn có thể theo dõi chi tiết pattern và thực thi giải pháp cho các vấn đề thực tế trong program của bạn.

Pattern thường là những algorithms phức tạp - rối rắm (confused), bởi vì nó trình bày cả khái niện, đi từ giải pháp đến các vấn đề đã biết. Trong khi một algorithm luôn định nghĩa một tập hợp rõ ràng các hành động để đạt được mục đích, thì một pattern trình bày mức độ cao hơn (more high-level) của giải pháp. Code của cùng một pattern áp dụng được cho hai hoặc nhiều các ngôn ngữ lập trình khác nhau.

Một sự tương đồng giữa algorithm và một công thức nấu ăn (cooking recipe): Cả hai đều có các bước rõ ràng để đạt được mục đích. Ở một chiều hướng khác, một pattern lại giống một bản thiết kế hơn (blueprint): Bạn có thể thấy kết quả và tính năng của nó, nhưng thứ tự thực hiện các bước là do chính bạn quyết định.

---

## Cách trình bày nội dung một design?

Hầu hết patterns được mọi người trình bày theo cách tái sử dụng (reproduce) chúng trong nhiều kịch bản. Ở đây các mục thường có, khi trình bày trong môt pattern như sau:

- **Intent (ý nghĩa , mục đích):** trình bày ngắn gọn cả vấn đề và giải pháp.
- **Motivation (Sự thúc đẩy, động lực thúc đẩy):** giải thích thêm vấn đề và giải pháp mà pattern đó có thể làm được.
- **Structure (Cấu trúc):** của các classes, thể hiện một phần của pattern và các mối liên hệ của chúng.
- **Code example (Code ví dụ):** của một trong nhiều ngôn ngữ lập trình giúp cho bạn dễ dàng nắm bắt ý tưởng phía sau của pattern.


Liệt kê chi tiết một số danh mục pattern hữu ít khác, chẳng hạn như khả năng áp dụng của mẫu, các bước triển khai và mối quan hệ với các mẫu khác

## Tại sao bạn nên học về patterns?

Sự thật bạn có thể đã làm quản lý các programmer trong nhiều năm mà không hề biết đến một pattern. Nhiều người khác cũng thế. Trong trường hợp này, hiểu là bạn có thể đã thực hiện một số patterns mà không hề biết về chúng. Đó có phải là lý do bạn nên học về chúng?

- Design patterns là một bộ tookit của việc thử và test giải pháp cho các vấn đề chung trong việc phát triển phần mền. Thậm chí bạn chưa bao giờ gặp vấn đề, biết về patterns vẫn sẽ hữu ít, bởi vì nó dạy bạn cách sắp xếp cách giải quyết vấn đề khi sử dụng các nguyên tắc của thiết kế hướng đối tượng.

- Design patterns định nghĩa một ngôn ngữ chung cho bạn và các thành viên trong team có thể sử dụng để giao tiếp một cách hiệu quả. Bạn có thể nói "Oh, nên sử dụng Singleton cho trường hợp kia", và mọi người sẽ hiểu ý tưởng phía sau lời phát biểu của bạn. Không cần giải thích singleton là gì nếu mọi người đã biết về pattern này.

