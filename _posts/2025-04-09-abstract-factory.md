---
title: Abstract Factory
date: 2025-04-09 12:45:00 +0700
categories: [Design Patterns]
tags: [Design Patterns, Abstract Factory]
---

## Intent

**Abstract Factory** là một creational design pattern cho phép bạn tạo một họ sản phẩm có mối quan hệ với nhau mà không cần một classes concrete cụ thể.

![abstract-factory](../assets/img/posts/2025-04-09-abstract-factory/abstract-factory.png)


---

## Problem

Hãy tưởng tượng bạn đang tạo ra một mô phỏng của hàng nội thất. Code của bạn bao gồm các classes:

1. Một họ các sản phẩm có mối quan hệ như sau: `Chair` + `Sofa` + `CoffeeTable`.

2. Có nhiều biến thể trong họ này. Ví dụ, sản phẩm `Chair` + `Sofa` + `CoffeeTable` là khả dụng cho các biến thể: `Modern`, `Victory`, `ArtDeco`


![problem](../assets/img/posts/2025-04-09-abstract-factory/problem.png)


Bạn cần một cách để tạo một đối tượng nội thất theo yêu cầu cá nhân, nó có thể không match với các đối tượng đang có trong họ. Khách hàng sẽ khá điên tiết nếu họ không tìm được thứ họ muốn 😡.

![problem](../assets/img/posts/2025-04-09-abstract-factory/problem2.png)

Tất nhiên, bạn không muốn thay đổi code đã tồn tại trước đó khi thêm mới một sản phẩm hoặc một họ sản phẩm vào trong chương trình. Việc update catalog nội thất rất thường xuyên, và bạn không muốn thay đổi core code cho mỗi lần như thế.

---

## Solution

Trước tiên, **Abstract Factory** pattern khuyên bạn nên thực hiện khai báo những interfaces cho từng nhóm sản phẩm trong họ sản phẩm. Khi đó tất cả các biến thể sẽ kế thừa từ những interface đó. Ví dụ tất cả biến thể của chair sẽ kế thừa từ interface `Chair`, tất cả các biến thể của coffee table sẽ kế thừa từ interface **CoffeeTable**.


![solution1](../assets/img/posts/2025-04-09-abstract-factory/solution1.png)


Bước tiếp theo, là khai báo một interface **Abstract Factory** bao gồm danh sách các phương thức creation dành cho nhóm tất cả các sản phẩm trong họ sản phẩm. Ví dụ `createChair`, `createSofa`, `createCoffeeTable`. Những phương thức này sẽ return về một **abstract** product type được trình bày bởi những intefaces chúng ta đã khai báo bên trên: `Chair`, `Sofa`, `CoffeeTable`


![solution2](../assets/img/posts/2025-04-09-abstract-factory/solution2.png)


Bây giờ, chúng ta sẽ nói về các biến thể? Mỗi biến thể của họ sản phẩm, chúng ta sẽ chia vào những factory class base trong inteface `AbstractFactory`. Một factory là một class sẽ trả về những sản phẩm cụ thể. Ví dụ, `ModernFurnitureFactory` có thể tạo ra những đối tượng `ModenrChari`, `ModernSofa`, `ModernCoffeeTable` 

Client cod có thể làm việc với cả factories và products thông qua abstract interfaces. Khi bạn thay đổi kiểu dữ liệu của factory và truyền nó vào client code, client code sẽ nhận được những biến thể của sản phẩm, mà không làm vở cấu trúc client code hiện tại.


![solution3](../assets/img/posts/2025-04-09-abstract-factory/solution3.png)


Client muốn một factory để tạo một product chair. Client không cần p hải nhận thức về class factory đó, cũng không quan trọng là loại chair nào. Cho dù là Model hay Victorian, client cũng đều cư xử giống nhau, bằng việc sử dụng abstract interface `Chair`. Với phương pháp này, client chỉ cần biết một thứ là chair sẽ thực thi `sitOn` bên trên phương thức nào. Ngoài ra bất kỳ một biến thể nào chair được trả ra, nó cũng đều match với kiểu sofa hoặc coffee table theo đúng cách này.

---

## Structure


![structure](../assets/img/posts/2025-04-09-abstract-factory/structure.png)


1. **Abstract Products** khai báo interface cho một tập hợp những sản phẩm có liên quan để làm một họ sản phẩm.

2. **Concrete Products** là những biến thể sẽ thực thi abstract products, một nhóm theo các biến thể. Mỗi abstract product (chair/sofa) bắt buộc phải thực thi trong tất cả biến thể (Victorian/Modern).

3. **Abstract Factory** khai báo interface của một tập các phương thức để tạo cho mỗi abstract products.

4. **Concrete Factories** thực thi phương thức tạo từ abstract factory. Mỗi concrete factory có trách nhiệm cho các biến thể của product và chỉ tạo sản phẩm cho những biến thể đó.

5. Mặc dù concrete factories là khởi tạo cho concrete products, đánh dấu (signatures) phương thức tạo bắt buộc có trách nhiệm phải trả về abstract products. Đây là cách mà client code sử dụng factory mà không ràng buộc với một biến thể cụ thể của product, nó nhận từ factory. Client có thể làm việc với bất kỳ biến thể nào của concrete factory/product, phụ thuộc vào sự giao tiếp giữa đối tượng thông qua abstract intefaces.

---

## Pseudocode

---

## Applicability


### Sử dụng Abstract Factory khi code bạn cần làm việc với một họ biến thể của sản phẩm thực tế, bạn không muốn phụ thuộc vào những concrete classes của sản phẩm mà chúng ta không biết trước những hành động hoặc đơn giản là muốn khả năng mở rộng trong tương lại.


Abstract Factory cung cấp cho bạn một interface để tạo đối tượng từ class của họ sản phẩm. Code bạn sẽ tạo đối tượng thông qua interface, bạn không cần phải sợ khi tạo sai biến thể của sản phẩm, mà không match với những sản phẩm đã sẵn sàng được tạo trước đó từ ứng dụng của bạn.

### Hãy cân nhắc thực thi Abstract Factory khi bạn có một tập hợp các [Factory Methods](./2025-04-03-factory-method.md) mà trách nhiệm chính của chúng trở nên mờ nhạt.

Trong thiết kế tốt cho chương trình, mỗi class chỉ có một trách nhiệm duy nhất về một việc gì đó. Khi class xử lý nhiều loại sản phẩm khác nhau, bạn nên tách các phương thức tạo đối tượng sản phẩm ra bằng việc sử dụng Factory Method hoặc triển khai theo Abstract Factory.


---

## Cách triển khai

1. Map một matrix của duy nhất một sản phẩm với các biến thể của nó.

2. Khai báo tất cả inteface sản phẩm trừ tượng cho tất cả loại sản phẩm. Để cho tất cả concrete sản phẩm triển khai interface đó.

3. Khai báo một inteface factory trừ tượng với tập hợp phương thức concrete dành cho tất cả sản phẩm trừ tượng.

4. Triển khai một tập hợp class của concrete factory, cho tất cả các biến thể.

5. Khởi tạo factory trong ứng dụng của bạn. Nó nên là một instantiate của class concrete factory, phụ thuộc vào cấu hình ứng dụng hoặc môi trường hiện tại. Pass đối tượng factory đến tất cả classes vào construct sản phẩm.

6. Scan hết code và gọi trực tiếp constructor sản phẩm. Thay thế chúng khi gọi creation method trong đối tượng factory.

--

## Pros and Cons

|Pros|Cons|
|-|-|
|Bạn có chắc chắn rằng các sản phẩm mà bạn nhận được từ factory là tương thích.| Code sẽ trở nên phức tạp hơn nhiều, với nhiều interfaces và classses được thêm vào pattern.| 
|Bạn có thể tránh được việc gắn chặt gữa concrete products và client code.||
|*Single Responsibility Principle*. Bạn có thể mở rộng code tạo sản phẩm vào một nơi, làm cho code dễ dàng khi hỗ trợ. ||
|*Open/Close Principle*. Bạn có thể cho vào nhiều biến thể mới của sản phẩm mà không phá vởi client code đã tồn tại trước đó. ||

---

## Relations with Other Patterns

- Nhiều designs bắt đầu với **Factory Method** (ít phức tạp và nhiều custom thông qua subclass) và sau đó tiến hóa lên **Abstract Factory**, **Prototy** hoặc **Builder** (nhiều linh hoạt hơn, nhưng phức tạp hơn).

- **Builder** tập trung xây dựng ứng dụng phức tạp với từng bước. Abstract Factory chuyên dùng trong việc tạo một họ các đối tượng có liên quan. Abstract Factory trả về những sản phẩm ngay lập tức, trong khi Builder bạn tạo sản phẩm bằng cách thêm từng bước các thành phần trong constructor.

- Lớp Abstract Factory thường based trên một tập hợp **Factory Method**, nhưng bạn cũng có thể sử dụng **Prototy** để tạo những phương thức trên lớp. 

- Abstract Factory có thể phục vụ để thay thế cho **Facade** khi bạn chỉ muốn ẩn đi các đối tượng subclass tạo với client code.

- Bạn có thể sử dụng Abstract Factory bên cạnh **Bridge**. Kết hợp khi sử dụng một số abstract được định nghĩa bởi **Bridge** có thể chỉ làm việc với một số triển khai cụ thể. Trong trường hợp này, Abstract Factory nên được đóng gói những quan hệ và ẩn sự phức tạp cho client code.

- Abstract Factories, Builders, và Prototyes có thể triển khai như một **Singletons**.

---

## References

-  [factorin.guru](https://refactoring.guru/design-patterns/abstract-factory)
