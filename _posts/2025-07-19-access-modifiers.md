---
title: "Các Access Modifiers chính trong .NET"
date: 2025-07-19 22:05:00 +0700
categories: [.NET]
tags: [Access Modifiers]
---

Trong .NET, access modifiers (bộ định danh truy cập) xác định mức độ truy cập của các thành phần như class, method, property, field, ..

Sau đây là bảng tổng hợp các access modifiers chính trong .NET

| Modifier             | Mô tả                                                                           | Truy cập được từ đâu?                |
| -------------------- | ------------------------------------------------------------------------------- | ------------------------------------ |
| `private`            | Chỉ truy cập được bên trong chính class chứa nó                                 | ❌ Không truy cập từ bên ngoài       |
| `private protected`  | Truy cập trong chính class chứa nó hoặc từ class con cùng assembly              | 🔒 Rất hạn chế                       |
| `protected`          | Truy cập trong chính class chứa nó và class kế thừa (trong hoặc ngoài assembly) | ✅ Class con                         |
| `internal`           | Truy cập từ bất kỳ đâu trong cùng một assembly                                  | ❌ Không truy cập từ assembly khác   |
| `protected internal` | Truy cập từ cùng assembly hoặc từ class con trong assembly khác                 | ✅ Class con hoặc trong cùng project |
| `public`             | Truy cập từ bất kỳ đâu                                                          | ✅ Bên ngoài assembly và lớp         |

Tóm tắt ngắn gọn mức độ truy cập

`private < private protected < protected < internal < protected internal < public`

Ví dụ:

```csharp

public class Car
{
    private int speed;                // Chỉ dùng trong class Car
    protected string brand;          // Dùng trong Car và lớp con
    internal string engineType;      // Dùng trong cùng assembly
    public string Color { get; set; } // Dùng ở mọi nơi
}

```

Assembly là đơn vị triển khai (deployment unit) cơ bản nhất chứa mã code thực thi, metadata, và tài nguyên.  Nó thường là một file `*.dll` hoặc `*.exe`. Hiểu đơn giản một project `.csproj` là một Assembly.
