---
title: Inversion of Control Principle - Nguyên lý thiết kế đảo ngược sự kiểm soát
date: 2025-08-10 22:25:00 +0700
categories: [Principle]
tags: [Principle, IoC]
---

Khi mới làm quen và tìm hiểu về thiết kế hệ thống, tôi bắt gặp cụm từ **Inversion of Control Principle – Nguyên lý đảo ngược sự kiểm soát**.  
Lúc đó, tôi chỉ biết thốt lên: _“Mình đang đọc cái quái gì thế này?”_.

Mãi đến gần đây tôi mới thật sự hiểu được nguyên lý này.  
Trong bài viết này, tôi sẽ giải thích bằng một ví dụ thực tế để bạn dễ tiếp cận và hiểu tại sao nó lại có cái tên vừa lạ vừa “ngầu” đến vậy 😁.

---

Tôi vốn rất thích cà phê, nên sáng nào cũng cố thu xếp thời gian để pha cho mình một ly.  
Giờ thì mời anh em cùng theo chân tôi pha một ly cà phê nhé.

## Để pha cà phê, bạn cần chuẩn bị:

- Cà phê rang xay
- Phin pha cà phê
- Ly
- Nước sôi

Sau khi chuẩn bị đủ, ta cho khoảng **3 muỗng cà phê** vào ly, thêm nước sôi,  
rồi chờ hơn **5 phút** để thưởng thức cái thứ nước màu cánh gián, đắng ngắt nhưng thơm phức này.

---

## Nhưng nếu sáng nay tôi muốn uống trà thì sao?

Tôi sẽ phải làm công việc tương tự:

- Trà
- Bình pha trà
- Cốc
- Nước sôi

Pha trà cầu kỳ hơn pha cà phê, nhưng tôi chọn cách nhanh gọn:  
Cho trà vào bình, thêm nước sôi, chờ ngấm và mời cả nhà thưởng thức.

---

> **"Ôi giời ơi! Đọc mãi toàn trà với cà phê, IoC đâu mất rồi?"**  
> – Một độc giả sốt ruột :))

---

## Vấn đề: Sự phụ thuộc

Qua ví dụ trên, bạn sẽ thấy:  
Để có một ly đồ uống buổi sáng, tôi **phụ thuộc** vào:

- Dụng cụ
- Nguyên liệu
- Cách pha chế

Nếu muốn thưởng thức loại đồ uống khác, tôi lại phải chuẩn bị toàn bộ từ đầu.

---

## Giải pháp: Đảo ngược sự kiểm soát

Thay vì tự pha, tôi ra quán cà phê.  
Ở đó luôn sẵn mọi loại đồ uống tôi cần, tôi **không còn phụ thuộc** vào việc chuẩn bị nguyên liệu hay dụng cụ.

---

## “Đảo ngược sự kiểm soát” nghĩa là gì?

- **Tự pha ở nhà**: Khi muốn uống cà phê hay trà, tôi **tự bắt đầu** quá trình pha chế → **Tự khởi tạo đối tượng**.
- **Ra quán**: Thức uống đã được chuẩn bị từ trước (**Đối tượng khởi tạo sẵn**). Khi khách gọi món, nhân viên chỉ việc mang ra.

➡ Điều này nghĩa là **quyền kiểm soát việc khởi tạo** đã được **đảo ngược** — từ tay người dùng sang tay một “bên thứ ba” quản lý (ở đây là quán cà phê).

---

## Trong lập trình

**Nguyên lý đảo ngược sự kiểm soát (IoC)** thường được áp dụng cùng với **Dependency Injection (DI)** — một pattern phổ biến để triển khai nguyên lý này.

---

## Ví dụ về IoC

Ví dụ này minh họa cách áp dụng **Dependency Injection (DI)** trong Java thông qua một mô hình đơn giản liên quan đến quán cà phê.

### Các thành phần:

- **`Drink`**: Interface định nghĩa hành vi chung của đồ uống.
- **`Coffee`** và **`Tea`**: Hai lớp triển khai từ `Drink`, thể hiện hai loại đồ uống khác nhau.
- **`CafeShop`**: Lớp đại diện cho quán cà phê, có thể phục vụ hai loại đồ uống là coffee, và tea.

### Ý nghĩa:

Ví dụ này giúp bạn hiểu rõ cách **Dependency Injection**:

- Tách biệt sự phụ thuộc giữa các lớp.
- Tăng tính linh hoạt và khả năng mở rộng của ứng dụng.

```java
// Drink.java
public interface Drink {
    String getName();
    double getPrice();
}

```

```java
// Coffee.java
public class Coffee implements Drink {
    @Override
    public String getName() {
        return "Coffee";
    }

    @Override
    public double getPrice() {
        return 2.5;
    }
}

```

```java
// Tea.java
public class Tea implements Drink {
    @Override
    public String getName() {
        return "Tea";
    }

    @Override
    public double getPrice() {
        return 1.8;
    }
}

```

```java
// CafeShop.java
public class CafeShop {
    private final Drink coffee;
    private final Drink tea;

    // Constructor Injection
    public CafeShop(Drink coffee, Drink tea){
        this.coffee = coffee;
        this.tea = tea;
    }

    public void serveDrink(Drink drink) {
        System.out.println("Serving: " + drink.getName() + " - Price: $" + drink.getPrice());
    }
}

```

```java
// Main.java
public class Main {
    public static void main(String[] args) {

        // Initial object coffee and object tea
        Drink coffee = new Coffee();
        Drink tea = new Tea();

        // Serve drinks via CafeShop
        CafeShop cafeShop = new CafeShop(coffee, tea);
        cafeShop.serveDrink(coffee);
        cafeShop.serveDrink(tea);
    }
}

```
