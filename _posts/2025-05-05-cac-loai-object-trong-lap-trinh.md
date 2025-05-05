---
title: Các loại object trong lập trình
date: 2025-05-05 13:20:00 +0700
categories: [.NET]
tags: [POCO, Entity, DTO, ETO, Model, Domain Model]
---

Tài liệu này cung cấp cái nhìn tổng quan và phân biệt rõ ràng giữa các loại object phổ biến trong lập trình .NET, bao gồm: `POCO`, `Entity`, `DTO`, `ETO`, `Model (ViewModel)` và `Domain Model`.  
Nội dung trình bày dưới dạng bảng so sánh chi tiết về đặc điểm, mục đích sử dụng và tình huống nên áp dụng của từng loại object, kèm theo các **ví dụ cụ thể bằng mã C#** để minh họa.

Tài liệu phù hợp cho:
- Lập trình viên .NET ở mọi cấp độ muốn chuẩn hóa kiến thức mô hình hóa đối tượng.
- Người học Domain-Driven Design (DDD), Clean Architecture hoặc phát triển ứng dụng nhiều tầng.
- Các nhóm phát triển muốn xây dựng kiến trúc rõ ràng, dễ bảo trì và test.

---

## POCO (Plain Old CLR Object)

- Class đơn giản không phụ thuộc vào framework.
- Không kế thừa base class đặc biệt hoặc dùng attribute của framework.

**Ví dụ:**
```csharp
public class Customer
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```

---

## Entity

- Có `Id` duy nhất (Identity).
- Thường chứa logic nghiệp vụ.
- Đại diện cho thực thể trong domain hoặc bảng dữ liệu.

**Ví dụ:**
```csharp
public class Order
{
    public Guid Id { get; private set; }
    public List<OrderItem> Items { get; private set; } = new();

    public void AddItem(OrderItem item)
    {
        Items.Add(item);
    }
}
```

---

## DTO (Data Transfer Object)

- Chỉ dùng để truyền dữ liệu giữa các lớp, API...
- Không chứa logic nghiệp vụ.

**Ví dụ:**
```csharp
public class OrderDto
{
    public Guid Id { get; set; }
    public decimal TotalAmount { get; set; }
}
```

---

## ETO (Event Transfer Object)

- Giống DTO, nhưng dành riêng cho các sự kiện (event/message).

**Ví dụ:**
```csharp
public class OrderCreatedEto
{
    public Guid OrderId { get; set; }
    public DateTime CreatedAt { get; set; }
}
```

---

## Model (ViewModel/InputModel)

- Đại diện dữ liệu phục vụ UI.
- Thường dùng trong MVC/Razor Page.

**Ví dụ:**
```csharp
public class LoginViewModel
{
    public string Username { get; set; }
    public string Password { get; set; }
}
```

---

## Domain Model

- Đại diện cho logic nghiệp vụ cốt lõi của hệ thống.
- Có thể là Entity hoặc Value Object.

**Ví dụ:**
```csharp
public class BankAccount
{
    public Guid Id { get; private set; }
    public decimal Balance { get; private set; }

    public void Deposit(decimal amount)
    {
        if (amount <= 0) throw new ArgumentException("Invalid amount");
        Balance += amount;
    }
}
```

---

## Bảng so sánh nhanh

| Loại object       | Có logic? | Có Id? | Mục đích sử dụng                                             | Khi nào sử dụng?                                          |
|-------------------|-----------|--------|--------------------------------------------------------------|-----------------------------------------------------------|
| POCO              | Tuỳ       | Tuỳ    | Class đơn giản dùng làm nền cho Entity, DTO, v.v.            | Khi cần class độc lập, dễ test, không ràng buộc framework |
| Entity            | ✅        | ✅     | Đại diện cho thực thể trong hệ thống, có logic và Identity   | Khi mô hình hóa domain thực thể có định danh (Id)         |
| DTO               | ❌        | Tuỳ    | Truyền dữ liệu giữa các lớp hoặc qua API                     | Khi truyền/nhận dữ liệu qua API hoặc giữa các tầng        |
| ETO               | ❌        | Tuỳ    | Truyền dữ liệu giữa các service thông qua event (event bus)  | Khi publish/subcribe sự kiện giữa các microservice        |
| Model (ViewModel) | ❌        | Tuỳ    | Đại diện dữ liệu hiển thị hoặc nhận input từ UI              | Khi giao tiếp giữa controller và view                     |
| Domain Model      | ✅        | ✅/❌  | Chứa logic nghiệp vụ cốt lõi của hệ thống, tách biệt hạ tầng | Khi áp dụng DDD và tách riêng logic nghiệp vụ             |
