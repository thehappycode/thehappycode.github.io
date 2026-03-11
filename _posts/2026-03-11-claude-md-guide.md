---
title: Tìm Hiểu File CLAUDE.md
date: 2026-03-11 12:44:00 +0700
categories: [AI, Claude]
tags: [Claude]
description: Tài liệu hướng dẫn thực hành viết file CLAUDE.md
---

## 1. CLAUDE.md Là Gì?

Hãy hình dung như thế này:

```
Bạn mới vào công ty  →  HR đưa cho bạn "Sổ tay nhân viên"
Claude Code mới mở project  →  Nó đọc "CLAUDE.md"
```

**CLAUDE.md = Sổ tay nội quy dự án dành riêng cho AI Agent.**

Mỗi khi Claude Code khởi động trong project của bạn, việc đầu tiên nó làm là **tìm và đọc file này** — trước khi làm bất cứ điều gì khác.

---

## 2. Claude Tương Tác Với File Này Như Thế Nào?

```
Bạn gõ lệnh "claude" trong terminal
        ↓
Claude Code tìm CLAUDE.md theo thứ tự ưu tiên:
  1. ~/.claude/CLAUDE.md        (global - áp dụng mọi project)
  2. ~/project/CLAUDE.md        (project root - quan trọng nhất)
  3. ~/project/src/CLAUDE.md    (sub-folder - nếu bạn cd vào đó)
        ↓
Claude nạp toàn bộ nội dung vào System Prompt
        ↓
Mọi hành động của Claude trong session đó
đều bị chi phối bởi Rules trong file này
```

### Cơ Chế Merge Khi Có Nhiều File

```
Global CLAUDE.md          Project CLAUDE.md        Sub-folder CLAUDE.md
(Luật chung cho           (Luật riêng cho          (Luật riêng cho
 mọi project)    +         project này)    +         thư mục con)
                                    ↓
                          = Bộ luật tổng hợp
                            Claude tuân theo
```

---

## 3. CLAUDE.md Tương Tác Với File Nào Khác?

```
CLAUDE.md  (não chính)
    │
    ├── @import docs/conventions.md      ← Dùng @path để nhúng file khác
    ├── @import docs/api-standards.md
    │
    ├── .claude/
    │   ├── settings.json                ← Cấu hình permissions (tool nào được dùng)
    │   └── settings.local.json          ← Override cá nhân (không commit git)
    │
    ├── .env                             ← Claude đọc nếu được cấp quyền
    ├── pom.xml                          ← Claude tự đọc để hiểu dependencies
    └── src/                             ← Claude đọc code khi cần context
```

### File `.claude/settings.json` — Quan Trọng Không Kém

```json
{
  "permissions": {
    "allow": [
      "bash(mvn:*)",
      "bash(git:*)",
      "read(**)",
      "write(src/**)"
    ],
    "deny": [
      "bash(rm -rf:*)",
      "write(.env)"
    ]
  }
}
```

> 💡 File này kiểm soát **Claude được phép làm gì** — như firewall cho Agent.

---

## 4. Cấu Trúc CLAUDE.md Chuẩn Cho Java Spring Boot

```
# [Tên Project]

## 1. Project Overview        ← Claude hiểu project làm gì
## 2. Tech Stack              ← Claude biết dùng tool/lib nào
## 3. Architecture            ← Claude hiểu cấu trúc code
## 4. Rules (Bắt buộc)        ← Luật Claude PHẢI tuân theo
## 5. Code Conventions        ← Style code của team
## 6. Skills                  ← Hướng dẫn làm từng loại task
## 7. Common Commands         ← Lệnh hay dùng
## 8. Environment             ← Thông tin môi trường
```

---

## 5. Ví Dụ Thực Tế — CLAUDE.md Cho Dự Án Task Management API

```markdown
# Task Management API

## 1. Project Overview
REST API quản lý công việc cho team dev.
- Input: Request từ client (mobile/web)
- Output: JSON response theo chuẩn REST
- Database: PostgreSQL

## 2. Tech Stack
- Java 17
- Spring Boot 3.x
- Spring Security + JWT
- Spring Data JPA + Hibernate
- PostgreSQL
- Maven
- JUnit 5 + Mockito + MockMvc
- SpringDoc OpenAPI 3

## 3. Architecture
Theo pattern: Controller → Service → Repository
- Controller: Nhận request, validate input, trả response
- Service: Business logic, transaction
- Repository: Tương tác database
- Mỗi module nằm trong package riêng: auth, user, project, task, comment

## 4. Rules ⚠️ (Claude bắt buộc phải tuân theo)
- KHÔNG BAO GIỜ xóa file mà không hỏi xác nhận
- LUÔN viết unit test cho mọi method trong Service layer
- LUÔN validate input ở Controller bằng @Valid
- LUÔN dùng ResponseEntity cho mọi API response
- KHÔNG commit thông tin nhạy cảm (password, secret key)
- Khi sửa code cũ: KHÔNG xóa, chỉ thêm/sửa

## 5. Code Conventions
- Ngôn ngữ comment: Tiếng Việt
- Naming: camelCase cho variable/method, PascalCase cho Class
- Package: com.app.taskmanagement
- DTO pattern: Tạo DTO riêng, không expose Entity ra ngoài
- Exception: Dùng custom exception + GlobalExceptionHandler
- Response format chuẩn:
  {
    "success": true,
    "data": {},
    "message": "string",
    "timestamp": "ISO8601"
  }

## 6. Skills
### Khi viết API mới:
1. Tạo Entity → Repository → DTO → Service → Controller
2. Viết unit test ngay sau khi viết Service
3. Cập nhật OpenAPI docs

### Khi fix bug:
1. Đọc hiểu bug report
2. Viết failing test trước
3. Sửa code cho test pass

## 7. Common Commands
- Build:             mvn clean install
- Test:              mvn test
- Run:               mvn spring-boot:run
- Test single class: mvn test -Dtest=TaskServiceTest

## 8. Environment
- Dev port: 8080
- DB: localhost:5432/taskmanagement_dev
- Profile: application-dev.yml
```

---

## 6. Tóm Tắt Những Điểm Quan Trọng Nhất

| Điểm | Chi tiết |
|---|---|
| **Đọc khi nào** | Mỗi lần khởi động Claude Code |
| **Thứ tự ưu tiên** | Sub-folder > Project root > Global |
| **Nhiều file** | Merge lại thành một bộ luật tổng hợp |
| **Import file khác** | Dùng cú pháp `@path/to/file.md` |
| **Phân quyền** | Cấu hình riêng ở `.claude/settings.json` |
| **Quan trọng nhất** | Phần **Rules** — Claude bắt buộc phải tuân theo |

---

## 7. Checklist Viết CLAUDE.md Tốt

- [ ] Mô tả rõ project làm gì (1–3 câu ngắn gọn)
- [ ] Khai báo đầy đủ tech stack
- [ ] Viết Rules rõ ràng, dùng từ mạnh: **LUÔN / KHÔNG BAO GIỜ**
- [ ] Có ví dụ response format chuẩn
- [ ] Có danh sách lệnh hay dùng
- [ ] Cấu hình `.claude/settings.json` giới hạn quyền hợp lý
- [ ] Không đưa thông tin nhạy cảm (password, API key) vào file này

---

*Phiên bản 1.0 — Dự án Task Management API*
