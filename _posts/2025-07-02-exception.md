---
title: "Exception"
date: 2025-07-02 22:48:00 +0700
categories: [.NET]
tags: [.NET, Exception]
---

`Exception` (Ngoại lệ) giống như một chuông báo động, cho các lập trình viên biết có điều gì đó không đúng khi chương trình chạy, nó giúp các lập trình viên đưa ra phương án xử lý phù hợp theo từng loại cảnh báo. Trong bài viết này chúng ta sẽ tìm hiểu sâu hơn về ý nghĩa, cơ chế hoạt động, danh sách Exception, cách Custom Exception, cũng như vấn đề về bảo mật liên quan đến Excetion.

---

## Exception là gì?

Trong .NET, `Exception` (ngoại lệ) là một cơ chế dùng để phát hiện, xử lý các lỗi phát sinh trong khi chạy chương trình.

---

## Tại sao Exception lại quan trọng?

Có một bệnh nhận cảm thấy trong người không khoẻ và đi đến bệnh viện để khám.

- Bác sỹ: "Anh bị đau chổ nào"?
- Bệnh nhân: "Tôi không biết, cơ thể tôi không có dấu hiệu gì cả, tôi chỉ cảm thấy mình không khoẻ". 

Trong trường hợp này thì vị bác sỹ sẽ phải kiểm tra từ đầu đến chân, từ trong ra ngoài điều này sẽ tốn rất nhiều thời gian và công sức để tìm ra được đúng nơi gây bệnh.

Rất may mắn cho vị bác sỹ, là câu chuyện trên sẽ không bao giờ xãy ra, vì cơ thể người bệnh luôn phát ra những báo động (Exception) khi có vấn đề. Đó là lý do vì sao chúng ta thấy Exception lại quan trọng đến vậy.

Quay lại với lập trình thì trong .NET cung cấp cơ chế Exception dùng để:

- Phát hiện lỗi.
- Kiểm soát cách xử lý lỗi.
- Cho phép ứng dụng có thể tiếp tục chạy hoặc thoát một cách có trật tự, thay vì sập một cách đột ngột khi có lỗi.

---

## Kiến trúc và nguyên lý hoạt động

### Stack-based Exception Handling

.NET sử dụng mô hình **stack unwinding**, có nghĩa là khi một exception xảy ra, CLR sẽ lần lượt **duyệt ngược** (unwind) qua các call stack từ phương thức hiện tại về phía caller để tìm khối `catch` phù hợp.

```csharp

public void ControllerAction()
{
    ServiceLayerMethod(); // nếu throw -> sẽ được propagate về đây
}

public void ServiceLayerMethod()
{
    throw new ArgumentNullException("id"); // exception được throw tại đây
}

```

### try-catch-finally

CLR hoạt động theo logic sau:

- Nếu khối `try` thực thị và xảy ra Exception.
- CLR sẽ tìm `catch` phù hợp (theo thứ tự stack unwinding). Và xử lý exception ở đó.
- Khối `finally` luôn được gọi. Điều này đảm bảo rằng resource cleanup (giải phóng tài nguyên) luôn được thực hiên.

---

## Thành phần của Exception Object

Khi bạn `throw new Exception(...)`. Thì .NET, CLR sẽ tạo ra một đối tượng Exception (instance của `System.Exception` hoặc lớp kế thừa). Exception Object chứa nhiều thông tin quan trọng để developer xử lý lỗi chính xác từ việc **debug** hoặc thông qua **file log**.

| **Thuộc tính / Method** | **Kiểu dữ liệu** | **Ý nghĩa**                                                                                        |
| ----------------------- | ---------------- | -------------------------------------------------------------------------------------------------- |
| `Message`               | `string`         | Mô tả lỗi (được truyền qua constructor). Thường dùng để hiển thị cho developer hoặc log.           |
| `StackTrace`            | `string`         | Chuỗi mô tả ngăn xếp lệnh tại thời điểm xảy ra lỗi. Dùng để xác định vị trí lỗi trong mã.          |
| `InnerException`        | `Exception`      | Nếu exception hiện tại được bao (wrap) từ một exception khác, nó sẽ nằm ở đây. Hỗ trợ "chain" lỗi. |
| `Source`                | `string`         | Tên assembly hoặc module sinh ra exception.                                                        |
| `TargetSite`            | `MethodBase`     | Thông tin về phương thức (method) gây ra exception.                                                |
| `HResult`               | `int`            | Mã lỗi (error code) ở cấp độ hệ điều hành hoặc COM. Thường dùng trong interop.                     |
| `HelpLink`              | `string`         | Link tài liệu mô tả lỗi (ít dùng nhưng có thể set khi cần).                                        |
| `Data`                  | `IDictionary`    | Cho phép đính kèm thông tin tùy chỉnh vào exception. Ví dụ: `ex.Data["OrderId"] = 12345`           |


---

## Cây phân cấp Exception trong .NET

```text

System.Object
  └── System.Exception - Gốc của toàn bộ ngoại lệ
        ├── System.SystemException - Các lỗi hệ thống, runtime/CLR hoặc  .NET framework sinh ra
        │     ├── ArgumentException
        │     │     ├── ArgumentNullException
        │     │     └── ArgumentOutOfRangeException
        │     ├── ArithmeticException
        │     │     └── DivideByZeroException
        │     ├── ArrayTypeMismatchException
        │     ├── IndexOutOfRangeException
        │     ├── InvalidCastException
        │     ├── InvalidOperationException
        │     ├── FormatException
        │     ├── NullReferenceException
        │     ├── OutOfMemoryException
        │     ├── OverflowException
        │     ├── StackOverflowException
        │     ├── TypeInitializationException
        │     ├── RankException
        │     ├── NotSupportedException
        │     ├── PlatformNotSupportedException
        │     └── ...
        ├── System.IO.IOException - Liên quan đến đọc, ghi file, đường dẫn, ổ đĩa,..
        │     ├── FileNotFoundException
        │     ├── DirectoryNotFoundException
        │     ├── EndOfStreamException
        │     ├── PathTooLongException
        │     └── DriveNotFoundException
        ├── System.Net.WebException
        ├── System.UnauthorizedAccessException - Các Exception về phân quyền
        ├── System.TimeoutException
        ├── System.Security.SecurityException - Liên quan đến bảo mật
        ├── System.Data.DataException - Dành cho việc xử lý dữ liệu
        │     ├── ConstraintException
        │     ├── DeletedRowInaccessibleException
        │     ├── InRowChangingEventException
        │     └── NoNullAllowedException
        ├── System.Threading.ThreadAbortException - Liên quan đến lỗi xử lý song song 
        ├── System.Threading.Tasks.TaskCanceledException - Liên quan đến lỗi async/await
        ├── System.AggregateException
        ├── System.ApplicationException
        │     └── (nơi bạn có thể kế thừa cho Custom Exception)
        └── (các Exception nghiệp vụ do lập trình viên tự định nghĩa)
```

Với cây phân cấp Exception sẽ giúp bạn phân loại lỗi chính xác và dễ debug.

---

## Hướng dẫn viết một Custom Exception

Custom Exception là những Exception nghiệp vụ do lập trình viên tự định nghĩa. Custom Exception nên được kế thừa từ `System.ApplicationException` hoặc `Exception`. Custom Exception giúp mã dễ đọc, dễ bắt lỗi và debug hơn.

Giả sử bạn muốn định nghĩa một Custom Exception có tên là `OrderNotFoundException`, bạn có thể làm như sau:

### Định nghĩa class `OrderNotFoundException`

```csharp

public class OrderNotFoundException : Exception
{
    public string OrderCode { get; set; }
    
    public OrderNotFoundException()
    {
    }

    public OrderNotFoundException(string message)
        : base(message)
    {
    }

    public OrderNotFoundException(string message, Exception inner)
        : base(message, inner)
    {
    }
    
    public OrderNotFoundException(string message, string orderCode)
        : base(message)
    {
        OrderCode = orderCode;
    }
}

```

### Sử dụng class `OrderNotFoundException`

```csharp

public void ProcessOrder(string orderCode)
{
    var order = GetOrderByCode(orderCode);
    if (order == null)
    {
        throw new OrderNotFoundException($"Không tìm thấy đơn hàng {orderCode}", orderCode);
    }

    // tiếp tục xử lý
}

```

---

## Exception Handling - Exception chung cho toàn bộ ứng dụng

### Ý tưởng

- Mọi Exception khi xảy ra lỗi trong ứng dụng đều đi qua một **middleware** hoặc **Exception filter** (nếu là ASP.NET Core).
- Middleware sẽ `catch` tất cả exception.
- Wrap exception lại bằng một Custom Exception.
- Response về chuẩn cho client.

### Triển khai

#### Bước 1: Tạo Custom Exception

```csharp

public class ApiException : Exception
{
    public int StatusCode { get; set; }
    public string ErrorCode { get; set; }

    public ApiException(string message, int statusCode = 500, string errorCode = null)
        : base(message)
    {
        StatusCode = statusCode;
        ErrorCode = errorCode ?? "InternalServerError";
    }
}

```

Custom Exception có bổ sung thêm `StatusCode`, `ErrorCode`.

#### Bước 2: Tạo Middleware để handle Exception tập trung

```csharp

public class ExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionMiddleware> _logger;

    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task Invoke(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unhandled exception");
            await HandleExceptionAsync(context, ex);
        }
    }

    private static Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        ApiException apiException;

        // nếu đã là ApiException do code throw ra thì giữ nguyên
        if (exception is ApiException custom)
        {
            apiException = custom;
        }
        else
        {
            // nếu là bất kỳ Exception khác, wrap lại thành ApiException
            apiException = new ApiException(exception.Message, 500);
        }

        var result = JsonSerializer.Serialize(new
        {
            error = apiException.ErrorCode,
            message = apiException.Message,
            status = apiException.StatusCode
        });

        context.Response.ContentType = "application/json";
        context.Response.StatusCode = apiException.StatusCode;

        return context.Response.WriteAsync(result);
    }
}

```

#### Bước 3: Đăng ký Middleware

```csharp

app.UseRouting();

// nên đặt ngay sau routing
app.UseMiddleware<ExceptionMiddleware>();

app.UseAuthentication();
app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});

```

---

## Vấn đề bảo mật liên quan đến Exception

Khi một exception chưa **message chi tiết** hoặc **stack trace** trả thẳng ra cho client, bạn đã vô tình tiết lộ:

- Tên class, tên phương thức -> giúp hacker đoán được kiến trúc hệ thống.
- Đường dẫn file -> tiết lộ thự mục source code.
- Connection string hoặc thông tin nhạy cảm.

### Một số ví dụ về lỗi bảo mật liên quan đến Exception

#### SQL Injection reconnaissance

```json

{
  "message": "Syntax error in SQL near 'SELECT * FROM Users WHERE Name = 'John"
}

```

Tiết lộ câu query -> tiếp tục thử và tấn công bằng sql injection.

#### NullReferenceException

```json

{
  "message": "Object reference not set to an instance of an object.",
  "stack": "at MyApp.Services.UserService.GetUserById(int id)\n at MyApp.Controllers.UserController.Get()"
}

```

Tiết lộ thông tin:

- Tên namespace `MyApp.Services`
- Tên class `UserService`
- Tên phương thức `GetUserById(int id)`

-> Có thể dò lỗ hổng **API Endpoint**.

#### Path Disclosure

```

Could not find file C:\inetpub\wwwroot\myapp\files\xyz.txt

```

Tiết lộ đường dẫn server -> có thể lên kế hoạch tấn công directory traversal.

---

## Best Practices khi sử dụng Exception

Dưới đây là một số Best Practices khi sử dụng Exception.

### Luôn bắt cụ thể, đừng catch chung chung

Tránh `catch (Exception ex)` ở mọi nơi, đặc biết ở tầng nghiệp vụ.
Chỉ nên `catch (Exception ex)` tổng quát ở tầng ngoài cùng (controller, middleware)

❌ Tránh:

```csharp

catch (Exception ex)
{
    // bắt tất cả mọi loại lỗi
}

```

✅ Nên:

```csharp

catch (ArgumentNullException ex) { ... }
catch (InvalidOperationException ex) { ... }

```

### Không "nuốt" exception

Việc bắt lỗi mà không log hay xử lý gì là một **code smell** nghiêm trọng.

❌ Tránh:

```csharp

try { ... }
catch { } // code smell

```

✅ Nên:

```csharp

catch (Exception ex)
{
    _logger.LogError(ex, "Unexpected error occurred");
    throw;
}

```

### Custom Exception khi cần mô tả lỗi nghiệp vụ

Tạo các Custom Exception kế thừa từ `Exception` hoặc `ApplicationException` để diễn tả lỗi nghiệp vụ. Giúp tách biệt lỗi hệ thống và lỗi nghiệp vụ.

✅ Nên:

```csharp

public class DomainException : Exception
{
    public string ErrorCode { get; }

    public DomainException(string message, string errorCode = null) : base(message)
    {
        ErrorCode = errorCode ?? "DOMAIN_ERROR";
    }
}

```

### Sử dụng `InnerException` khi wrap lỗi

Khi nén lỗi mới từ lỗi cũ, luôn nhớ truyền lỗi gốc vào `innerException`.

✅ Nên:

```csharp

catch (SqlException ex)
{
    throw new DomainException("Không thể truy xuất dữ liệu", ex);
}

```

### Nên dùng Middleware hoặc Filter để xử lý lỗi tập trung

Không nên `try-cach` ở mọi controller, thay vào đó hãy xử lý tập trung bằng `ExceptionMiddleware`. Đảm bảo các response trả về luôn nhất quán và không được lộ thông tin nhạy cảm.

✅ Nên:

```csharp

// Program.cs
app.UseMiddleware<ExceptionMiddleware>();

```

### Không trả thông tin chi tiết exception cho client

❌ Tránh:

```json

{
  "message": "Object reference not set to an instance of an object",
  "stack": "at ServiceLayer.UserService.GetUser()..."
}

```

✅ Nên:

```json

{
  "error": "InternalServerError",
  "message": "Đã xảy có lỗi xay ra trong quá trình thực hiện"
}

```

### Ghi log đầy đủ và có cấu trúc.

✅ Nên:

Log nên có:

- `Exception.Message`
- `Exception.StackTrace`
- `Exception.InnerException`
- `TraceId`, `UserId`, `Method`, ...

Giúp chúng ta dễ trace lỗi trong môi trường PRO

### Không throw trong finalizer hoặc trong constructor property

Việc throw trong finalizẻ hoặc trong constructor property gây khó hiểu và lỗi khó debug.

✅ Nên:
 
```csharp

public string Name
{
    get => throw new InvalidOperationException();
}

```

### Đừng lạm dụng `throw ex` thay vì `throw`

- `throw` giữ nguyên trạng thái StackTrace gốc.
- `throw ex` reset StackTrace -> Mất thông tin quý giá.

✅ Nên:

```csharp

catch (Exception ex)
{
    _logger.LogError(ex, "Error");
    throw; // giữ StackTrace
}

```

### Checklist Best Practices

| Mục tiêu         | Việc nên làm                                         |
| ---------------- | ---------------------------------------------------- |
| Tối ưu hiệu suất | Tránh dùng Exception để điều khiển logic             |
| Dễ bảo trì       | Custom Exception rõ ràng cho nghiệp vụ               |
| Logging rõ ràng  | Ghi log đầy đủ, bao gồm StackTrace và InnerException |
| Bảo mật          | Sanitize response gửi client                         |
| Kiến trúc sạch   | Dùng middleware để xử lý lỗi tập trung               |
| Debug dễ dàng    | Duy trì `throw;` để giữ StackTrace gốc               |

