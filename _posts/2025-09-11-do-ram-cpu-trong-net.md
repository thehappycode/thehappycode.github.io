---
title: "Đo RAM và CPU trong .NET"
date: 2025-09-11 08:15:00 +0700
categories: [.NET]
tags: [RAM, CPU]
---

# 📊 Đo RAM & CPU trong .NET

## 1. Đo RAM

### 🔹 Cách 1: Dùng `GC.GetTotalMemory`

``` csharp
long ramBefore = GC.GetTotalMemory(true);
// ... chạy export ...
long ramAfter = GC.GetTotalMemory(true);

Console.WriteLine($"RAM tăng: {(ramAfter - ramBefore) / 1024.0 / 1024.0} MB");
```

-   Đo **managed heap** (RAM do .NET quản lý).\
-   Không tính unmanaged memory (ví dụ: OpenXML SDK có thể dùng).


### 🔹 Cách 2: Dùng `Process.WorkingSet64`

``` csharp
using System.Diagnostics;

var process = Process.GetCurrentProcess();
long ramBefore = process.WorkingSet64;
// ... chạy export ...
process.Refresh();
long ramAfter = process.WorkingSet64;

Console.WriteLine($"RAM tăng: {(ramAfter - ramBefore) / 1024.0 / 1024.0} MB");
```

-   Đo **RAM thực tế toàn bộ process** (managed + unmanaged).\
-   Đây là cách chính xác hơn khi export Excel.

---

## 2. Đo CPU

### 🔹 Dùng `Process.TotalProcessorTime`

``` csharp
using System.Diagnostics;

var process = Process.GetCurrentProcess();
var cpuBefore = process.TotalProcessorTime;
// ... chạy export ...
process.Refresh();
var cpuAfter = process.TotalProcessorTime;

Console.WriteLine($"CPU time dùng thêm: {cpuAfter - cpuBefore}");
```

-   Trả về **CPU time** (thời gian CPU thực sự chạy cho process).\
-   Đơn vị: `TimeSpan`.

### 🔹 Tính % CPU Usage

``` csharp
var process = Process.GetCurrentProcess();
var sw = Stopwatch.StartNew();

var cpuBefore = process.TotalProcessorTime;
// ... chạy export ...
process.Refresh();
var cpuAfter = process.TotalProcessorTime;

sw.Stop();

double cpuUsage = (cpuAfter - cpuBefore).TotalMilliseconds /
                  (sw.Elapsed.TotalMilliseconds * Environment.ProcessorCount) * 100;

Console.WriteLine($"CPU Usage ~ {cpuUsage:F2}%");
```

- Công thức:

  `%CPU = (CPU time) / (Elapsed time * Số core) * 100`

-  Dùng khi muốn biết **CPU chiếm bao nhiêu %** trong suốt quá trình
    export.

---

## Ứng dụng để đo MaxRAM, MaxCPU

```csharp

// Đặt ở đầu class
private Process _currentProcess = Process.GetCurrentProcess();
private long _maxMemory = 0;
private double _maxCpu = 0;
private double _minCpu = double.MaxValue;
private double _sumCpu = 0;
private int _cpuSamples = 0;


```

```csharp

// Đặt trong vòng lặp export (ví dụ sau mỗi 1000 dòng hoặc mỗi lần ghi)
_currentProcess.Refresh();
long mem = _currentProcess.WorkingSet64;
if (mem > _maxMemory) _maxMemory = mem;

double cpu = _currentProcess.TotalProcessorTime.TotalMilliseconds / Environment.ProcessorCount;
if (cpu > _maxCpu) _maxCpu = cpu;
if (cpu < _minCpu) _minCpu = cpu;
  _sumCpu += cpu;
  _cpuSamples++;

```

```csharp

// Sau khi export xong, log ra kết quả
Console.WriteLine($"RAM cao nhất: {_maxMemory / 1024 / 1024} MB");
Console.WriteLine($"CPU thấp nhất: {_minCpu} ms, cao nhất: {_maxCpu} ms, trung bình: {_sumCpu / _cpuSamples} ms");

```

---

## ✅ Kết luận

-   **RAM**:
    -   Dùng `GC.GetTotalMemory` → chỉ đo managed heap.\
    -   Dùng `Process.WorkingSet64` → đo toàn bộ RAM process (chính xác
        hơn).\
-   **CPU**:
    -   Dùng `Process.TotalProcessorTime` để đo CPU time.\
    -   Kết hợp với `Stopwatch` để tính %CPU.

