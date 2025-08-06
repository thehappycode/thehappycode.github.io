---
title: Design Principle - Nguyên tắc thiết kế trong lập trình
date: 2025-08-01 06:22:00 +0700
categories: [Design Patterns]
tags: [Design Patterns, Design Principle]
---

## Design Principle

**Design Principle** là tập hợp các nguyên tắc thiết kế trong lập trình nhầm mục đích tạo ra những chương trình có tính linh hoạt, khả năng tái sử dụng code hiệu quả. Thông thường các nguyên tắc này được áp dụng trên các hệ thống thiết kế theo OOP, nhầm cải thiện một số nhược điểm cố hữu của OOP. Trong bài viết này tôi đã liệt kê một số các nguyên tắc thường được sử dụng trong lập trình như:

### Identify the aspects of you application that vary and separate them from what stays the same.

**Định nghĩa những khía cạnh hay thay đổi của ứng dụng và tách riêng chúng ra những nơi giống nhau**. Việc làm này giúp chúng ta đóng gói những phần hay thay đổi cùng nhau, về sau bạn có thể chỉnh sửa, hoặc mở rộng từng phần thay đổi mà không làm ảnh hưởng đến phần còn lại của chương trình.

### Program to an interface, not an implementation.

**Chương trình là một interface, không nên là một implementation**. Mục đích của nguyên tắc thiết kế này là các đối tượng trong chương trình khi giao tiếp với nhau đều thông qua interface, chúng không cần phải quan tâm đến chi tiết triển khai của đối tượng đang giao tiếp, khi áp dụng nguyên tắc này vào việc lập trình sẽ giúp:

- Tăng mức độ trừ tượng hoá sẽ làm giảm đi sự phức tạp khi bạn viết code, vì bạn không phải cần quan tâm đến chi tiết triển khai của đối tượng giao tiếp.
- Tăng tính linh hoạt cho chương trình, vì bạn có thể thêm mới một chi tiết triển khai mới cho interface một cách dễ dàng.
- Tái sử dụng code.

### Favor composition over inheritance.

**Ưu tiên sử dụng thành phần hơn là kế thừa**. Thành phần ở đây được hiểu là class, interface. Do đó ta có thể hiểu một class nên ưu tiên phụ thuộc vào một class/interface hơn là phụ thuộc vào kế thừa vì nó mang lại sự linh hoạt và dễ bào trì hơn. Nguyên nhân do kế thừa có thể dẫn đến các vấn đề như kết nối chặc chẽ giữa các class dẫn đến khó thay đổi thiết kết, trong khi thành phần cho phép xây dựng các đối tượng phức tạp bằng cách kết hợp các đối tượng đơn giản, dễ dàng mở rộng và sửa đổi

### Strive for loosely coupled designs between objects that interact.

**Cố gắng thiết kế các đối tượng khi tương tác với nhau không được liên kết một cách chặc chẽ. Với cách thiết kế này cho phép chúng ta xây dựng hệ thống có tính linh hoạt cao khi cần xử lý những thay đổi bởi vì giữa các đối tượng ít có sự phụ thuộc lẫn nhau.
