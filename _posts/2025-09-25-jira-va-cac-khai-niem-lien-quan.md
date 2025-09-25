---
title: Jira và các khái niệm liên quan
date: 2025-09-25 21:40:00 +0700
categories: [Jira]
tags: [Jira]
---

## Jira là gì?

Jira là một công cụ quản lý công việc (issue tracking) và quản lý dự án (project management) do Atlassian phát triển. Nó được sử dụng rộng rãi trong việc **phát triển phần mền** (Agile, Scrum). Jira giúp chúng ta theo dõi, phân công, quản lý tiến độ và trạng thái của công việc.

---

## Các khái niệm cơ bản trong Jira

### Project

Là dự án phần mền cần phát triển. Ví dụ phát triển website, ứng dụng mobile, ...

### Issue

Là đơn vị công việc trong Jira. Issue có thể là: `Epic`, `User Story`, `Task`, `Bug`.

### Workflow

Mỗi công việc (issue) trong Jira đều đi qua **một quy trình trạng thái (workflow)**. Tuỳ thuộc vào từng dự án mà chúng ta có thể thiết kế workflow riêng sao cho phù hợp.

Ví dụ quy trình cho Dev team: `To Do → In Progress → In Review → Testing → Done`.

Workflow giúp chúng ta dễ dàng theo dõi:
 - Công việc đang ở đâu.
 - Ai đang phụ trách.
 - Và tình trạng thế nào.

### Sprint

**Sprint** là **chu kỳ làm việc ngắn** (thường 1--4 tuần).

Trong mỗi Sprint:
  
  1. Team chọn một tập hợp **User Story / Task / Bug** từ backlog để làm.
  2. Sprint bắt đầu → Dev & Tester triển khai.
  3. Sprint kết thúc → Review kết quả + Retrospective (rút kinh nghiệm).

Sprint giúp team làm việc theo **Agile Scrum** và dễ đo lường tiến độ (Burndown Chart).

### Scrum

**Scrum** là một **framework Agile** giúp quản lý phát triển phần mềm. Scrum gồm các thành phần chính sau:
  - **Product Owner (PO):** quản lý backlog, xác định ưu tiên.
  - **Scrum Master (SM):** hỗ trợ team tuân theo Scrum, gỡ vướng mắc.
  - **Development Team:** Dev + QA + Designer thực hiện công việc.

### Epic

**Epic** là  một tính năng lớn một mục tiêu lớn. Epic được chia thành nhiều **User Story** nhỏ nhứ ví dụ sau:

- Epic: "Quản lý giỏ hàng"
  - User Story 1: Người dùng thêm sản phẩm vào giỏ.
  - User Story 2: Người dùng xóa sản phẩm khỏi giỏ.
  - User Story 3: Người dùng thanh toán giỏ hàng.

### User Story

Là mô tả ngắn gọn về **yêu cầu người dùng**. Thường viết theo mẫu:

  - Là một [vai trò],
  - Tôi muốn [chức năng],
  - Để tôi có thể [lợi ích].

Ví dụ: "Là một khách hàng, tôi muốn lưu địa chỉ giao hàng mặc định, để tôi không cần nhập lại mỗi lần mua hàng."

### Task / Sub-task

**Task**: Một công việc cần làm (có thể là từ User Story hoặc độc lập).

**Sub-task**: Công việc nhỏ hơn, tách ra từ một Task/User Story.

Ví dụ:
  - User Story: "Người dùng đăng nhập bằng email."
  - Task 1: Thiết kế UI form login.
  - Task 2: Code API login.
    - Sub-task: Trong Task 2 có thể có Sub-task "Xử lý validate email".
  - Task 3: Viết test case.

### Bug / Hotfix

**Bug:** Vấn đề/lỗi trong hệ thống (QA/Dev phát hiện).

**Hotfix:** Bản sửa lỗi khẩn cấp (thường trên môi trường production).

### Label

**Label** = Tag (nhãn) gắn vào issue để dễ tìm kiếm/nhóm.
Ví dụ: Label: `frontend`, `backend`, `UI`, `urgent`, `payment`.

### Comment

- Người trong team có thể **thảo luận trực tiếp trong issue** qua comment.
- Ví dụ: BA giải thích thêm yêu cầu, QA hỏi Dev, PO phản hồi.
- Comment có thể **mention** người khác bằng `@username`.

---

## Tóm tắt mối quan hệ các khái niệm

| **Khái niệm**    | **Giải thích**                | **Ví dụ**                          |
|------------------|-------------------------------|------------------------------------|
| **Project**      | Dự án phần mềm cần phát triển | Phát triển web, ứng dụng mobile... |
| **Issue**        | Đơn vị công việc trong Jira   | Epic, User Story, task, ...        |
| **Workflow**     | Quy trình công việc           | `To Do → In Progress → Done`       |
| **Sprint**       | Chu kỳ làm việc ngắn          | Sprint: Thiết kế giao diện         |
| **Scrum**        | Framework **Agile**           |                                    |
| **Epic**         | Một mục tiêu/tính năng lớn    | Quản lý giỏ hàng                   |
| **User Story**   | Mô tả yêu cầu người dùng      | "Lưu địa chỉ giao hàng mặc định"   |
| **Task**         | Công việc cần làm             | Code API login                     |
| **Sub-task**     | Công việc nhỏ trong Task      | Validate email trong API login     |
| **Bug**          | Lỗi phát sinh trong hệ thống  | Lỗi không đăng nhập được           |
| **Hotfix**       | Sửa lỗi khẩn cấp              | Fix bug production                 |
| **Label**        | Nhãn giúp phân loại issue     | `frontend`, `urgent`               |
| **Comment**      | Thảo luận trong issue         | Dev hỏi QA chi tiết bug            |
