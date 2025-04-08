---
title: Secret Manager
date: 2025-04-08 22:41:00 +0700
categories: [.NET, Security and Identity]
tags: [.NET, Security, Secret Manager, user-secrets]
---

Trong bài viết này chúng ta sẽ tìm hiểu về cách quản lý dữ liệu nhạy cảm trongứng dụng .NET trên môi trường Development. Đừng bao giờ lưu trữ thông tin nhạy cảm như password trên souce code hoặc file cấu hình (`appsettings.json`) vì hiện đã có nhiều công cụ crawler để tìm kiếm password trong source, đặt biệt các repository được publish trên [github](https://github.com/).

Để khắc phục vấn đề trên, .NET đã đưa ra giải pháp sử dụng Secret Manager để quản lý và lưu trữ thông tin nhạy cảm trong suốt quá trình phát triển ứng dụng.
 
---

## Secret Manager?

Secret Manager là một công cụ lưu trữ dữ liệu nhạy cảm trong suốt quá trình phát triển ứng dụng. Trong tình huống này, phần dữ liệu nhạy cảm được gọi là **app secret**. App secret được tách rời khỏi khỏi ứng dụng và được lưu trữ tại máy local của các developers. App secret được truy cập với một project cụ thể hoặc được share cho nhiều projects.

---

## Làm việc với công cụ Secret Manager như thế nào?

Secret Manager lưu trữ dữ liệu trong file JSON tại máy người dùng theo đường dẫn sau:

- Windowns
  - `%APPDATA%\Microsoft\UserSecrets\<user_secrets_id>\secrets.json`

- Linux / MacOS
  - `~/.microsoft/usersecrets/<user_secrets_id>/secrets.json`

Công cụ Secret Manager hoạt động trên một project cụ thể, khi bạn cấu hình lưu trữ trên profile người dùng.

### Sử dụng CLI

#### Lệnh init

Secret Manager gồm một lệnh `init` sử dụng `user-secrets` chạy lệnh này trực tiếp trong project.

```sh
$ dotnet user-secrets init
```

Sau khi chạy lệnh thành công, thì một phần tử `UserSecretId` sẽ được thêm vào trong `PropertyGroup` của file project. Mặc định, nội dung của `UserSecretId` có dạng dữ liệu là **GUID**, có thể tuỳ ý chỉnh sửa nội dung này, nhưng bắt buộc là duy nhất trong project.
 
#### Set một secret

Định nghĩa một app secret bạo gồm một key và một value. Được truy cập bí mật  bằng giá trị của `UserSecretId`.

```sh
$ dotnet user-secrets set <key> <value> [--project <path>]
$ dotnet user-secrets set "Movies:ServiceApiKey" "12345"
$ dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "C:\apps\WebApp1\src\WebApp1"
```

#### Danh sách user-secrets

Để kiêm tra danh sách secrets ta dùng lệnh:

```sh
$ dotnet user-secrets list 
```

#### Xoá một secret

Để xoá một secret key ta dùng lệnh:

```sh
$ dotnet user-secrets remove <key>
```

#### Xoá tất cả secrets

Để xoá tất cả secrets key ta dùng lệnh sau:

```sh
$ dotnet user-secrets clear
```

---

## Tổng kết

Chúc mừng bạn đã học được một điều mới trong ngày hôm nay!

Và thế là chúng ta cũng đã tìm hiểu xong về cách lưu trữ và sử dụng công cụ để quan lý dữ liệu nhay cảm trong môi trường Develop. Sau đây đây tôi xin tóm tắt lại các lệnh được sử dụng

|Lệnh|Mô tả|
|---|---|
|%APPDATA%\Microsoft\UserSecrets\<user_secrets_id>\secrets.json<br> ~/.microsoft/usersecrets/<user_secrets_id>/secrets.json|- Đường dẫn lưu trữ trong Windowns<br> - Đường dẫn lưu trữ trong Linux / MacOS|
|$ dotnet user-secrets init|Khởi tạo|
|$ dotnet user-secrets set key value [--project path]|Set một secret|
|$ dotnet user-secrets list|Xem danh sách secrets|
|$ dotnet user-secrets remove key|Xoá một secret key|
|$ dotnet user-secrets clear|Xoá tất cả keys|

---

## References
 
- [secret manager](https://learn.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-9.0&tabs=windows#secret-manager)
