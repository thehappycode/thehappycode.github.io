---
title: "Phân biệt Tag và Category trong Blog"
date: 2025-03-17 15:10:00 +0700
categories: [Jekyll]
tags: [Jekyll, Category, Tag]
---

Trong hầu hết các bài post chúng ta thường bắt gặp hai khái niệm là **Tag** và **Category**. Cả hai đều dùng để phân loại bài viết, nhưng chúng có sự khác biệt như thế nào? Chúng ta cùng tìm hiểu trong bài viết này nhá.

**Let's go** 🏃🏻‍➡️

---

## **1. Tag (Thẻ) – Dùng để nhóm bài viết theo chủ đề linh hoạt**
- **Dùng khi**: Bài viết có nhiều chủ đề liên quan.
- **Linh hoạt**: Một bài viết có thể có nhiều tag khác nhau.
- **Không có cấu trúc cố định**: Các tag không có sự phân cấp.

**Ví dụ:**
Bạn có một bài viết về lập trình Python. Bạn có thể gắn tag:
Một bài về C#:
```
tags: [C#, .NET, Design Pattern]
```
→ Dễ dàng tìm kiếm bài viết có liên quan dựa trên tag.

---

## **2. Category (Danh mục) – Dùng để tổ chức bài viết theo nhóm lớn**
- **Dùng khi**: Bạn muốn tổ chức bài viết theo nhóm có cấu trúc rõ ràng.
- **Có tính phân cấp**: Một bài viết chỉ nên thuộc về **một hoặc vài danh mục nhất định**.

**Ví dụ:**
Bài viết về Jekyll có thể nằm trong danh mục:
Bài viết về .NET có thể nằm trong danh mục:
```
categories: [Backend]
```
→ Dùng để hiển thị trong thanh menu hoặc sidebar.

---

## **3. Khi nào dùng Category? Khi nào dùng Tag?**

| Tiêu chí  | Category  | Tag    |
|-----------|-----------|--------|
| **Mục đích** | Phân loại bài viết theo nhóm lớn, có tính hệ thống. | Đánh dấu chủ đề, giúp tìm kiếm dễ hơn. |
| **Số lượng** | Nên có ít (dưới 10) và cố định. | Không giới hạn, có thể linh hoạt. |
| **Cấu trúc** | Có thể có cấp bậc (ví dụ: `Programming > .NET`). | Không có cấp bậc. |

---

## **4. Kết luận**
- **Tag**: Dùng để **bổ sung thông tin** về chủ đề chi tiết của bài viết.
- **Category**: Dùng để nhóm bài viết **chính** theo chủ đề lớn, có thể dùng cho menu.

**Gợi ý**: Một bài viết thường có **1-2 Category**, nhưng có thể có **nhiều Tag**.
