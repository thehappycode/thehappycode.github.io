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


## References

-  [factorin.guru](https://refactoring.guru/design-patterns/abstract-factory)

