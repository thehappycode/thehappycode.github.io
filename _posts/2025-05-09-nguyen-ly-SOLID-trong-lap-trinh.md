---
title: Nguyên lý SOLID trong lập trình
date: 2025-05-09 21:37:00 +0700
categories: [.NET]
tags: [SOLID]
---

## SOLID là gì?

`SOLID` là 5 nguyên lý thiết kế phần mền giúp code:

- Dễ mở rộng.
- Dễ bảo trì.
- Dễ kiểm thử.
- Giảm sự phụ thuộc.

`SOLID` là 5 ký tự đầu của những nguyên lý sau:

---

## S - Single Responsibility Princeple - Nguyên lý đơn trách nhiệm

*"A class should have one, and only one reason to change"* - Một class nên có một, và chỉ một lý do để thay đổi.

- Nếu một class có nhiều lý do để thay đổi, thì nó sẽ khó bảo trì khi nghiệp vụ thay đổi.
- Nên tách class theo **mục địch nghiệp vụ**.

### Vi phạm

```csharp

public class InvoiceManager
{
    public void CreateInvoice()
    {
        // Tạo hóa đơn
    }

    public void SaveToDatabase()
    {
        // Lưu vào DB
    }

    public void PrintInvoice()
    {
        // In hóa đơn
    }
}

```

**Vi phạm:** Class này vừa xử lý cả tạo hoá đơn, lưu trữ hoá đơn và in hoá đơn - *Nhiều hơn một trách nhiệm*.

### Tuân thủ

```csharp

public class InvoiceCreator
{
    public void CreateInvoice() { /* logic tạo hóa đơn */ }
}

public class InvoiceRepository
{
    public void SaveToDatabase() { /* logic lưu DB */ }
}

public class InvoicePrinter
{
    public void PrintInvoice() { /* logic in hóa đơn */ }
}

```

**Tuân thủ:** Mỗi class giờ chỉ có một nhiệm vụ cụ thể.

---

## O - Open/Closed Principle - Nguyên lý mở/đóng

*"Software entities should be open for extension, but closed for modification"* - Đối tượng phần mền nên mở khi cần mở rộng, nhưng đóng khi muốn chỉnh sửa.

- Áp dụng qua các pattern như: `Strategy`, `Template Method`, `Decorator`, ...
- Tránh viết code có nhiều điều kiện `if` , mà nên dùng kế thừa hoặc DI.

### Vi phạm

```csharp

public class PaymentProcessor
{
    public void ProcessPayment(string type)
    {
        if (type == "CreditCard") { /* xử lý thẻ */ }
        else if (type == "PayPal") { /* xử lý PayPal */ }
    }
}


```

**Vi phạm:** Mỗi lần thêm loại thanh toán mới phải sửa class này.

### Tuân thủ

```csharp

public interface IPaymentMethod
{
    void Process();
}

public class CreditCard : IPaymentMethod
{
    public void Process() { /* xử lý thẻ */ }
}

public class PayPal : IPaymentMethod
{
    public void Process() { /* xử lý PayPal */ }
}

public class PaymentProcessor
{
    public void ProcessPayment(IPaymentMethod method)
    {
        method.Process();
    }
}

```

**Tuân thủ:** Có thể thêm loại thanh toán mới mà không sửa **PaymentProcessor**.

---

## L - Liskov Substitution Principle  - Nguyên lý thay thế Liskov

*"Objects of a superclass should be replaceable with objects of it's subclass without breaking the application"* - Những đối tượng của lớp cha nên được thay thế bởi những đối tượng của lớp con, mà không phá vở ứng dụng (hay thay đổi hành vi của chương trình).

- Class con không được throw `NotImplementedException`.
- Class con không làm sai lệch logic của lớp cha.

### Vi phạm

```csharp

public class Bird
{
    public virtual void Fly() { }
}

public class Ostrich : Bird
{
    public override void Fly()
    {
        throw new NotImplementedException(); // đà điểu không bay được
    }
}

```

**Vi pham:** Sử dụng `Ostrich` (Đà điểu) như `Bird` (chim) sẽ gây ra lỗi chương trình khi runtime.

### Tuân thủ

```csharp

public interface IBird { void Eat(); }
public interface IFlyingBird : IBird { void Fly(); }

public class Sparrow : IFlyingBird
{
    public void Eat() { }
    public void Fly() { }
}

public class Ostrich : IBird
{
    public void Eat() { }
}

```

**Tuân thủ:** Không áp đặt hành vi bay cho tất cả các loài chim.

---

## I - Interface Segregation Principle - Nguyên lý phân tách Interface

*"Client should not be forced to depend on methods they do not use"* - Client không nên tập trung vào những phương thức không được sử dụng.

- Interface to dễ gây rối, đặc biệt với những client chỉ sử dụng 1 phần.
- Dễ vi phạm khi sử dụng interface "God object" (God object là class có quá nhiều trách nhiệm, ôm đồm tất cả chức năng).

### Vi phạm

```csharp

public interface IMachine
{
    void Print();
    void Scan();
    void Fax();
}

public class OldPrinter : IMachine
{
    public void Print() { }
    public void Scan() => throw new NotImplementedException();
    public void Fax() => throw new NotImplementedException();
}

```

**Vi phạm:** Class có những implement không được dùng tới.

### Tuân thủ

```csharp

public interface IPrinter { void Print(); }
public interface IScanner { void Scan(); }

public class SimplePrinter : IPrinter
{
    public void Print() { }
}

```

**Tuân thủ:** Interface được chia nhỏ, đúng mục đích sử dụng.

---

## D - Dependency Inversion Principle - Nguyên lý đảo ngược sự phụ thuộc

*"High-level modules should not depend on low-level modules. Both should depend on abstractions"* - Modules cấp cao không nên phụ thuộc vào modules cấp thấp. Cả hai nên phụ thuộc vào abstraction (interface/abstract class).

- Tránh new trực tiếp object cụ thể.
- Dễ test, dễ thay đổi implementation bằng DI (Dependency Injection).

### Vi phạm

 ```csharp

public class EmailSender
{
    public void Send(string message) => Console.WriteLine(message);
}

public class Notification
{
    private EmailSender sender = new EmailSender(); // phụ thuộc class cụ thể
    public void Alert() => sender.Send("Hello");
}

```

**Vi phạm:** Notification phụ thuộc vào EmailSerder, nên không dễ để test hay thay đổi loại Notification.

### Tuân thủ

```csharp

public interface IMessageSender
{
    void Send(string message);
}

public class EmailSender : IMessageSender
{
    public void Send(string message) => Console.WriteLine("Email: " + message);
}

public class Notification
{
    private readonly IMessageSender sender;

    public Notification(IMessageSender sender)
    {
        this.sender = sender;
    }

    public void Alert() => sender.Send("Hello");
}

```

**Tuân thủ:** Có thể inject (tiêm) các loại sender khác nhau: SMS, Email, ...

---

## Bảng ghi nhớ nhanh

| Ký hiệu | Nguyên lý             | Ghi chú gợi nhớ               | Tuân thủ giúp tránh                             |
| ------- | --------------------- | ----------------------------- | ----------------------------------------------- |
| **S**   | Single Responsibility | Mỗi class 1 nhiệm vụ          | Tránh code rối, khó bảo trì                     |
| **O**   | Open/Closed           | Mở để mở rộng, đóng không sửa | Tránh phải sửa code cũ khi mở rộng              |
| **L**   | Liskov Substitution   | Class con thay thế class cha  | Tránh class con phá vỡ logic class cha          |
| **I**   | Interface Segregation | Interface nhỏ gọn             | Tránh class phải implemnt thứ không cần sử dụng |
| **D**   | Dependency Inversion  | Phụ thuộc vào abstract        | Tránh Code gắn chặt với chi tiết cụ thể         |

---

## Checklist

### S – Single Responsibility Principle (SRP)
- [ ] Class này chỉ có **một lý do để thay đổi**?
- [ ] Các method trong class đều phục vụ một mục tiêu chung?

### O – Open/Closed Principle (OCP)
- [ ] Có thể mở rộng chức năng mà **không sửa code cũ**?
- [ ] Có sử dụng abstract class / interface để hỗ trợ mở rộng?
- [ ] Có sửa đổi code cũ mỗi khi có yêu cầu mới không?

### L – Liskov Substitution Principle (LSP)
- [ ] Class con có thể **thay thế** class cha mà **không gây lỗi**?
- [ ] Class con có override method nào khiến hành vi calss cha khác đi không?

### I – Interface Segregation Principle (ISP)
- [ ] Interface có nhỏ gọn, **chỉ chứa những thứ thật cần thiết**?
- [ ] Có ép class phải implement những method không dùng?

### D – Dependency Inversion Principle (DIP)
- [ ] Class phụ thuộc vào **interface, abstraction**, không phụ thuộc implementation cụ thể?
- [ ] Có đang dùng Dependency Injection?
