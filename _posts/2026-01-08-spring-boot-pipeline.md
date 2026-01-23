---
title: Spring Boot - Pineline
date: 2026-01-08 15:53:00 +0700
categories: [Java, Spring Boot]
tags: [Pipeline]
---

# Pipline xử lý request trong Spring

Khi một request đến ứng dụng Spring, nó sẽ trải qua một chuỗi các bước xử lý trước khi nhận được phản hồi.
Dưới đây là mô tả về các bước trong pipeline xử lý request của Spring:

![spring-boot-pipeline](../assets/img/posts/2026-01-08-spring-boot-pipeline/spring-boot-pipeline.png)

## Filters (Servlet Filter)

- Chặn sớm nhất trong tầng servlet. Thao tác trên `ServletReqeust/Response` trước khi vào Spring.
- Thường được sử dụng cho logging, tracing, XSS Wrapper, chỉnh Headers, CORS.

---

## Security Filter (Spring Security)

- Một `DelegatingFilterProxy` đứng trong filterChain, bên trong chứa nhiều security filter như:
    - Authentication
    - Authorization
    - Exception Translation
- Sử dụng để bảo vệ tài nguyên, xác thực người dùng, phân quyền truy cập, tránh tốn kém tài nguyên phía sau.

---

## DispatcherServlet

- Đúng trước Controller của Spring MVC. Định tuyến request tới handler(controller) phù hợp.
- Quản lý binding, conversion, message converters

---

## Handler Interceptors (Spring MVC)

- Hook ở mức MVC: trước và sau khi controller xử lý request.
- preHandle: Trước khi controller xử lý request.
- postHandle: Sau khi controller xử lý nhưng trước khi view được render.
- afterCompletion: Sau khi view được render.
- Thường dùng để logging, đo thời gian thực thi, thêm dữ liệu chung vào model.

---

## Controllers (Spring MVC)

- Xử lý logic nghiệp vụ chính cho request.

---

## ExceptionAdvice (Spring MVC)

- Xử lý ngoại lệ phát sinh trong quá trình xử lý request, tránh lộ stacktrace ra client.
- Cung cấp phản hồi lỗi chuẩn hóa, thân thiện với người dùng.

---

## Sequence Diagram

```mermaid
sequenceDiagram
    participant Client
    participant LoggingTraceFilter
    participant XssFilter
    participant SpringSecurity
    participant DispatcherServlet
    participant AppInterceptor
    participant Controller
    participant Service
    participant Repository
    participant ExceptionHandler
    
    Client->>LoggingTraceFilter: HTTP Request
    activate LoggingTraceFilter
    Note over LoggingTraceFilter: 1. Set traceId vào MDC<br/>2. Log request info<br/>3. Start timer
    
    LoggingTraceFilter->>XssFilter: chain.doFilter()
    activate XssFilter
    Note over XssFilter: Wrap request với<br/>XssWrapper (TODO)
    
    XssFilter->>SpringSecurity: chain.doFilter()
    activate SpringSecurity
    Note over SpringSecurity: 1. Extract JWT token<br/>2. Validate với Keycloak<br/>3. Check authorization<br/>4. Set SecurityContext
    
    alt Public Path (/swagger-ui, /login, /actuator)
        SpringSecurity-->>Client: Permit All (skip auth)
    else Protected Path
        alt JWT Invalid
            SpringSecurity-->>Client: 401 Unauthorized
        else No Permission
            SpringSecurity-->>Client: 403 Forbidden
        else JWT Valid + Authorized
            SpringSecurity->>DispatcherServlet: Continue
        end
    end
    
    activate DispatcherServlet
    Note over DispatcherServlet: Route to handler
    
    DispatcherServlet->>AppInterceptor: preHandle()
    activate AppInterceptor
    Note over AppInterceptor: 1. Parse JWT claims<br/>2. Get user info<br/>3. Load branch permissions (Redis/DB)<br/>4. Load invoice template permissions<br/>5. Set TenantContext<br/>6. Set UserContextHelper
    
    AppInterceptor->>Controller: Request Handler Method
    activate Controller
    Note over Controller: Validate @RequestBody<br/>@Valid, @Validated
    
    Controller->>Service: Business Logic
    activate Service
    
    Service->>Repository: Query Database
    activate Repository
    Repository-->>Service: Data
    deactivate Repository
    
    alt Business Exception
        Service-->>ExceptionHandler: Throw Exception
        activate ExceptionHandler
        Note over ExceptionHandler: Map exception to<br/>Response<Object>
        ExceptionHandler-->>Controller: ResponseEntity
        deactivate ExceptionHandler
    else Success
        Service-->>Controller: Result
    end
    
    deactivate Service
    Controller-->>AppInterceptor: Response
    deactivate Controller
    
    AppInterceptor->>AppInterceptor: postHandle()
    Note over AppInterceptor: Clear UserContextHelper
    
    AppInterceptor-->>DispatcherServlet: Response
    deactivate AppInterceptor
    deactivate DispatcherServlet
    
    SpringSecurity-->>XssFilter: Response
    deactivate SpringSecurity
    
    XssFilter-->>LoggingTraceFilter: Response
    deactivate XssFilter
    
    LoggingTraceFilter->>LoggingTraceFilter: finally block
    Note over LoggingTraceFilter: 1. Log response status<br/>2. Log processing time<br/>3. MDC.clear()
    
    LoggingTraceFilter-->>Client: HTTP Response
    deactivate LoggingTraceFilter

```