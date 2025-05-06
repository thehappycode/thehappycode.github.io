---
title: SemaphoreSlim trong .NET
date: 2025-05-06 13:18:00 +0700
categories: [.NET]
tags: [SemaphoreSlim]
---

## SemaphoreSlim?

SemaphoreSlim là một cơ chế đồng bộ hóa trong .NET dùng để giới hạn số lượng luồng được phép truy cập đồng thời vào một tài nguyên hoặc vùng mã cụ thể.

---

## Khởi tạo

```csharp
var semaphore = new SemaphoreSlim(initialCount);
```

- `initialCount`: Số luồng tối đa được phép truy cập đồng thời.

---

## Phương thức chính

| Phương thức    | Mô tả                                                           |
|----------------|-----------------------------------------------------------------|
| `Wait()`       | Chặn luồng cho đến khi có quyền truy cập, giảm `count` xuống 1  |
| `WaitAsync()`  | Chặn luồng bất đồng bộ chờ quyền truy cập, giảm `count` xuống 1 |
| `Release()`    | Trả lại quyền truy cập, tăng `count` lên 1.                     

---

## Mô hình hoạt động

```text
        ┌─────────────┐
        │Tài nguyên A │
        └────┬─┬──────┘
             │ │
       ┌─────▼─▼─────┐
       │ SemaphoreSlim│  ← Capacity: 2
       │  (count = 2) │
       └─────┬─┬─────┘
             │ │
      ┌──────┘ └──────┐
  Thread 1        Thread 2                Thread 3        Thread 4
     │                │                       │               │
     ▼                ▼                       ▼               ▼
"WaitAsync()"   "WaitAsync()"           "WaitAsync()"   "WaitAsync()"
count -= 1      count -= 1
     │                │                       |               │
     ▼                ▼                       ▼               ▼
Được phép         Được phép            Chờ semaphore    Chờ semaphore
     |                |                       |               | 
     ▼│               ▼                       ▼               ▼
Xử lý tài nguyên Xử lý tài nguyên      (Blocked state)  (Blocked state)

(sau khi xong việc)
     │                │
     ▼                ▼
"Release()"      "Release()"
     │                │
     ▼                ▼
count += 1      count += 1
     ▼                ▼
Thread 3 được chạy → Thread 4 được chạy tiếp theo

```
---

## Cách thức hoạt động của biến `count`

| Hành động                | count trước | count sau |
|-------------------------|--------------|-----------|
| `new SemaphoreSlim(2)`  | —            | 2         |
| Thread1: `WaitAsync()`  | 2            | 1         |
| Thread2: `WaitAsync()`  | 1            | 0         |
| Thread3: `WaitAsync()`  | 0            | 0 (chờ)   |
| Thread1: `Release()`    | 0            | 1         |
| Thread2: `Release()`    | 1            | 2         |

- `Wait()`, `WaitAsync()` giống như **xin quyền vào** → giảm `count`
- `Release()` giống như **nhường quyền lại** → tăng `count`
---

## Ví dụ

```csharp

SemaphoreSlim semaphore = new SemaphoreSlim(2);

async Task DoWorkAsync(int id)
{
    Console.WriteLine($"Task {id} đang chờ...");
    await semaphore.WaitAsync(); // xin quyền

    try
    {
        Console.WriteLine($"Task {id} bắt đầu...");
        await Task.Delay(1000); // mô phỏng xử lý công việc
    }
    finally
    {
        Console.WriteLine($"Task {id} hoàn tất.");
        semaphore.Release(); // trả quyền
    }
}

async Task Main()
{
    var tasks = Enumerable.Range(1, 5).Select(i => DoWorkAsync(i));
    await Task.WhenAll(tasks);
}

```

---

## Lưu ý

- Nên dùng `SemaphoreSlim` thay vì `Semaphore` nếu không cần sử dụng giữa nhiều tiến trình.
- Luôn gọi `Release()` trong `finally` để tránh deadlock.
- Hữu ích khi giới hạn số lượng truy cập tài nguyên hoặc gọi API song song.
