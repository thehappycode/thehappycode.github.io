---
title: "Chapter 1: Reliable, Scalable and Maintainable Application"
date: 2025-04-22 22:38:00 +0700
categories: [Handbook, Designing Data-Intensive Application]
tags: [Reliable, Scalable, Maintainable]
---

## Reliability

- Ứng dụng thực hiện đúng chức năng mà người dùng mong muốn
- Nó có thể chịu được lỗi người dùng hoặc sử dụng phần mền theo cách không mong muốn.
- Nó phải có hiệu năng đủ tốt cho các trường hợp người dùng yêu cầu, dưới mong muốn load và chứa dữ liệu.
- Hệ thống phải chặn bất kỳ unauthorization truy cập hoặc lạm dụng.

**Faults**: Bất cứ thứ gì có thể dẫn đến sai sót thì được gọi là faults.

### Hardware Faults

Hardware faults là khi hệ thống dừng (stop) cung cấp yêu cầu phục vụ từ người dùng.

### Software Errors

### Human Errors

- Thiết kế hệ thống sao cho cơ hội xuất hiện lỗi là tối thiểu.
- Giảm sự liên kết ở nơi mọi người thường xuyên bị lỗi, thành nơi họ có thể làm lỗi. Ví dụ như cung cấp một môi trường Sandbox để mọi người có thể trải nghiệm với dữ liệu thật, mà không ảnh hưởng đén người dùng thật.
- Test hết tất cả các cấp độ từ **unit test** đến **Integration test** và **manual test**
- Cho phép người dùng nhanh chóng và dễ dàng recovery lỗi (rollback), hạn chế hành động trong các trường hợp lỗi

### How important is Reliability?

- Setup chi tiết và monitoring rõ ràng, như tính toán hiệu suất (perfornamce) và tỉ lệ lỗi
- Thực hiện tốt công việc quản lý practices và traning.

---

## Scalability

Scalability là một thuật ngữ khi chúng ta trình bài việc tăng khả năng chịu tải của một hệ thống.

### Describing load

Lựa chọn tốt parameters phụ thuộc vào kiến trúc hệ thống của bạn, nó có thể:

- Số lượng request trên giây gọi đến web server
- Tỉ lệ của việc reads, writes vào trong database
- Mức độ hit trên cache
- v/v ...

### Describing performance

- Điều làm những request chậm làm tăng nhiều chi phí hơn, bởi vì chúng xử lý nhiều dữ liệu hơn
- Nếu bạn gọi song song, end user request vẫn cần phải đợi cái chậm nhất hoàn thành. Một cái chậm sẽ làm cho toàn bộ end user request bị chậm.

### Approaches for Coping with load

Hệ thống Elastic, hiểu là chúng có thể tự động thêm computing resources khi chúng xác định cần tăng thêm load.

---

## Maintainability

Maintainability là những hoạt động để duy trì ứng dụng như:

- Fix bug
- Vận hành hệ thống
- Điều tra / tìm kiếm lỗi
- Điều chỉnh với new platforms
- Chỉnh sửa với new user case
- Trả nợ kỹ thuật
- Thêm tính năng mới

Nhiều người không thích maintainer những hệ thống lỗi thời, phải đi fix lỗi của người khác, làm việc với những platforms đã outdated hoặc hệ thống chỉ tập trung làm việc gì đó mà họ không bao giờ thấy được mục đích. Làm việc trên các hệ thống lỗi thời luôn khó khăn, và nhìn chung nó khác xa so với những ý tưởng dành cho chúng.

Tuy nhiên nếu chúng ta có thể thiết kế hệ thống, với huy vọng tối thiểu làm tổn thương những người maintainer, và tránh tạo một hệ thống lỗi thời cho chúng ta. Ở đây chúng ta có ba nguyên tắc để thiết kế hệ thống phần mền sau:

- **Operability:** Làm cho team vận hành một cách dễ dàng, giữ hệ thống chạy một cách mượt mà
- **Simplicity:** 
    - Làm cho các developer mới dễ dàng hiểu về hệ thống, xoá những thứ phức tạp ra khỏi hệ thống
    - Một công cụ tốt để chúng ta remove sự phức tạp là `abstraction`. Một abstraction tốt nên ẩn một ý tưởng lớn dành cho việc triển khai chi tiết bên dưới một cách rõ ràng, đơn giản
    - Một abstraction tốt có thể sử dụng cho các ứng dụng khác nhau. Nó không chỉ tái sử dụng một cách hiệu quả những triển khai trước đó nhiều lần, mà còn là bước đầu của một higher-quantity software, nâng cấp chất lượng trong các thành phần abstraction tiện lợi cho những ứng dụng sử dụng nó
- **Evolvability:** Làm cho các developer dễ dàng thay đổi hệ thống trong tương lai như điều chỉnh hệ thống theo yêu cầu mới, hệ thống luôn có khả năng mở rông, điều chỉnh, và thích nghi


