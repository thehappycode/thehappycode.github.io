---
title: "Coding Conventions trong Java"
date: 2025-07-31 21:43:00 +0700
categories: [Java, Spring Boot]
tags: [Coding Conventions]
---

**Coding conventions** (quy tắc viết mã) trong Java là tập hợp các hướng dẫn giúp lập trình viên viết mã nguồn rõ ràng, nhất quán và dễ bảo trì. Việc tuân thủ các quy tắc này không chỉ giúp cải thiện chất lượng code mà còn giúp các thành viên trong nhóm có thể đọc hiểu, sửa lỗi và mở rộng chương trình một cách hiệu quả.

Trong Java, coding conventions bao gồm cách đặt tên cho class, method, biến, hằng số; cách sử dụng dấu ngoặc {}, thụt lề (indentation); cách tổ chức gói (package), v.v. Mỗi phần đều có vai trò cụ thể trong việc đảm bảo code clean, logic rõ ràng và chuẩn hóa giữa các dự án.

Việc áp dụng đúng convention còn hỗ trợ rất tốt cho các công cụ như IDE, formatter, code review tool, giúp tự động kiểm tra và định dạng mã nguồn.

Bảng dưới đây tóm tắt các quy ước phổ biến mà lập trình viên Java nên tuân theo:

| **Tên gọi (Thuật ngữ)** | **Ý nghĩa / Mô tả**                                           | **Loại từ**     | **Ví dụ**                                   |
| ----------------------- | ------------------------------------------------------------- | --------------- | ------------------------------------------- |
| `Class`                 | Tên class viết PascalCase, đại diện cho danh từ               | Danh từ         | `CustomerService`, `Invoice`                |
| `Interface`             | Tên interface viết PascalCase, thường là tính từ hoặc danh từ | Danh từ/Tính từ | `Serializable`, `UserRepository`            |
| `Method`                | Tên method viết camelCase, thể hiện hành động cụ thể          | Động từ         | `calculateTotal()`, `printReport()`         |
| `Variable`              | Tên biến viết camelCase, mô tả dữ liệu chứa trong biến        | Danh từ         | `totalAmount`, `userName`                   |
| `Constant`              | Viết in hoa toàn bộ, ngăn cách bởi dấu gạch dưới              | Danh từ         | `MAX_SIZE`, `DEFAULT_TIMEOUT`               |
| `Package`               | Viết thường, dạng miền đảo ngược                              | Danh từ         | `com.example.invoice`                       |
| `Enum`                  | Enum dùng PascalCase, các giá trị viết UPPER\_CASE            | Danh từ         | `Status.PENDING`, `Role.ADMIN`              |
| `Annotation`            | Viết PascalCase, bắt đầu bằng `@`, mô tả metadata             | Tính từ         | `@Override`, `@Autowired`                   |
| `Getter/Setter`         | Method dùng để truy cập hoặc thay đổi biến private            | Động từ         | `getName()`, `setAge(int age)`              |
| `Boolean method`        | Dùng các tiền tố như `is`, `has`, `can`, ...                  | Động từ         | `isEmpty()`, `hasPermission()`              |
| `Generic`               | Dùng T, E, K, V cho các kiểu tham số chung                    | Danh từ         | `List<T>`, `Map<K, V>`                      |
| `Lambda`                | Viết ngắn gọn cho method hoặc function                        | Động từ         | `list.forEach(item -> println(item));`      |
| `try-catch-finally`     | Cấu trúc xử lý ngoại lệ                                       | Cấu trúc        | `try { ... } catch { ... } finally { ... }` |
| `Indentation`           | Thụt lề dùng 4 dấu cách (không dùng tab)                      | Quy ước         | `    int count = 0;`                        |
| `Braces {}`             | Dấu ngoặc luôn mở – đóng rõ ràng, kể cả trong `if`, `for`,... | Quy ước         | `if (x > 0) { ... }`                        |

