---
title: "Những khái niệm, và thuật ngữ trong Spring Boot"
date: 2025-07-30 13:12:00 +0700
categories: [Java, Spring Boot]
tags: []
---

Trước khi học một ngôn ngữ mới, tôi thường hay có thói quen tìm hiểu các khái niệm, thuật ngữ trong ngôn ngữ đó. Mục đích để hiểu rõ không bị nhầm lẫn trong quá trình code cũng như giao tiếp với đồng nghiệp trở dễ dàng hơn. Trong bài viết này tôi sẽ ghi chú lại các thuật ngữ, khái niệm cơ bản nhất trong Spring Boot.

## Spring

**Spring** là một hệ sinh thái (ecosystem) mã nguồn mở dùng để xây dựng các ứng dụng Java hiện đại, dễ kiểm thử, dễ mở rộng. Spring không phải là một framework riêng lẽ mà nó tập hợp nhiều project/framework con.

| Thành phần con  | Chức năng tương đương trong .NET        |
| --------------- | --------------------------------------- |
| Spring Core     | DI Container (như built-in DI của .NET) |
| Spring MVC      | ASP.NET MVC / ASP.NET Core              |
| Spring Data JPA | Entity Framework Core                   |
| Spring Security | ASP.NET Identity / Authentication       |
| Spring Boot     | ASP.NET Core Boilerplate / Startup      |

---

## Spring Framework

**Spring Framework** là trái tim (core) của hệ sinh thái Spring. Nó cung cấp những thành phần cốt lõi như:

| Thành phần        | Giải thích                                                                                    |
| ----------------- | --------------------------------------------------------------------------------------------- |
| **IoC Container** | Cung cấp Dependency Injection (DI)                                                            |
| **AOP**           | Lập trình hướng khía cạnh (Aspect-Oriented Programming), như `Middleware` hoặc `ActionFilter` |
| **Spring MVC**    | Web framework theo mô hình MVC                                                                |
| **Transaction**   | Quản lý giao dịch (ACID)                                                                      |
| **Data Access**   | Hỗ trợ JDBC, ORM như Hibernate                                                                |

---

## Spring Boot

**Spring Boot** là một layer mở rộng của Spring Framework được tạo ra để:

- Để đơn giản hóa việc cấu hình Spring Framework.
- Tự động cấu hình (auto-configuration): Không cần phải viết nhiều XML như Spring Framework.
- Khởi tạo nhanh ứng dụng với cấu trúc mặc định.
- Tích hợp sẵn các công cụ như web server (Tomcat), logging, security,...

| Ví dụ         | Spring Framework                          | Spring Boot                                     |
| ------------- | ----------------------------------------- | ----------------------------------------------- |
| Tạo REST API  | Phải cấu hình controller, servlet, DI     | Chỉ cần `@RestController`, `@GetMapping`, done! |
| Chạy ứng dụng | Cần deploy lên web server (Tomcat, JBoss) | Chạy trực tiếp bằng `java -jar app.jar`         |
| Cấu hình      | XML hoặc Java Config                      | Auto-config bằng annotation, `application.yml`  |
| Mục tiêu      | Linh hoạt, kiểm soát cao                  | Dễ dùng, tập trung business logic               |

---

## Cấu trúc ứng dụng & khởi tạo

| Thuật ngữ                | Ý nghĩa                                                                                           |
| ------------------------ | ------------------------------------------------------------------------------------------------- |
| `Spring Boot`            | Framework để phát triển ứng dụng Java dễ dàng hơn với cấu hình tối thiểu.                         |
| `Spring Initializr`      | Web tool để tạo project Spring Boot ban đầu ([https://start.spring.io](https://start.spring.io)). |
| `@SpringBootApplication` | Annotation chính khởi động toàn bộ Spring Boot Application.                                       |
| `main()` method          | Điểm bắt đầu của ứng dụng Java, gọi `SpringApplication.run(...)`.                                 |

---

## Dependency Injection (DI) & IoC

| Thuật ngữ     | Ý nghĩa tương đương trong .NET                       |
| ------------- | ---------------------------------------------------- |
| `@Component`  | Đánh dấu class là một bean do Spring quản lý.        |
| `@Service`    | Bean đại diện cho tầng xử lý nghiệp vụ.              |
| `@Repository` | Bean đại diện cho tầng truy cập dữ liệu.             |
| `@Autowired`  | Tiêm phụ thuộc (Dependency Injection).               |
| `@Bean`       | Định nghĩa thủ công một bean trong `@Configuration`. |
| `@Qualifier`  | Chỉ định bean cụ thể khi có nhiều lựa chọn tiêm.     |

---

## REST API & controller

| Thuật ngữ         | Giải thích                                                 |
| ----------------- | ---------------------------------------------------------- |
| `@RestController` | Tương tự `[ApiController]` – trả về JSON mặc định.         |
| `@GetMapping`     | Tương đương `[HttpGet]` – ánh xạ HTTP GET request.         |
| `@PostMapping`    | Tương đương `[HttpPost]`.                                  |
| `@RequestMapping` | Mapping endpoint chung, có thể dùng cho class hoặc method. |
| `@RequestBody`    | Nhận body request (JSON → object).                         |
| `@PathVariable`   | Lấy giá trị từ URL path (giống `{id}` trong route).        |
| `@RequestParam`   | Lấy query string (?name=value)                             |

---

## Data & JPA (ORM)

| Thuật ngữ                  | Giải thích hoặc tương đương với .NET  |
| -------------------------- | ------------------------------------- |
| `Spring Data JPA`          | Framework ORM giống Entity Framework. |
| `@Entity`                  | Đánh dấu class là bảng dữ liệu.       |
| `@Id`                      | Primary key.                          |
| `@GeneratedValue`          | Giá trị tự động tăng.                 |
| `@OneToMany`, `@ManyToOne` | Quan hệ giữa các bảng.                |
| `JpaRepository<T, ID>`     | Interface để thao tác CRUD với DB.    |
| `@Query`                   | Viết JPQL query tùy chỉnh.            |

---

## Exception Handling & Validation

| Thuật ngữ                       | Ý nghĩa                                              |
| ------------------------------- | ---------------------------------------------------- |
| `@ControllerAdvice`             | Global Exception Handler (giống Middleware bắt lỗi). |
| `@ExceptionHandler`             | Xử lý loại Exception cụ thể.                         |
| `@Valid`                        | Kích hoạt validation khi nhận request.               |
| `@NotNull`, `@Size`, `@Pattern` | Các annotation validate dữ liệu đầu vào.             |
| `BindingResult`                 | Lưu kết quả validation để xử lý thủ công.            |

---

## Security

| Thuật ngữ            | Giải thích                                        |
| -------------------- | ------------------------------------------------- |
| `Spring Security`    | Framework bảo mật – authentication, authorization |
| `@EnableWebSecurity` | Bật tính năng bảo mật Web trong Spring            |
| `UserDetailsService` | Interface dùng để load thông tin người dùng       |
| `PasswordEncoder`    | Mã hóa mật khẩu (bCrypt, v.v.)                    |
| JWT                  | JSON Web Token – cơ chế xác thực phổ biến         |

---

## Testing

| Thuật ngữ         | Giải thích hoặc tương đương trong .NET        |
| ----------------- | --------------------------------------------- |
| JUnit             | Testing framework tương đương xUnit/MSTest    |
| Mockito           | Mocking framework giống Moq                   |
| `@SpringBootTest` | Annotation để test toàn bộ ứng dụng           |
| `MockMvc`         | Dùng để test controller mà không cần chạy web |

---

## Cấu hình ứng dụng

| Thuật ngữ                    | Giải thích                                                 |
| ---------------------------- | ---------------------------------------------------------- |
| `application.properties/yml` | Tương đương `appsettings.json` trong .NET                  |
| `@Value`                     | Inject giá trị cấu hình vào biến Java                      |
| `@ConfigurationProperties`   | Mapping cả object cấu hình vào class                       |
| `@Profile("dev")`            | Dùng để định nghĩa bean chỉ hoạt động trong môi trường dev |

---

## Deploy & Build

| Thuật ngữ      | Giải thích                                 |
| -------------- | ------------------------------------------ |
| Maven / Gradle | Công cụ quản lý phụ thuộc và build project |
| `.jar`         | File ứng dụng Spring Boot runnable         |
| `java -jar`    | Chạy ứng dụng Spring Boot                  |
| Docker         | Đóng gói ứng dụng Spring Boot để deploy    |

