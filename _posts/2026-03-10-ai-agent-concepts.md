---
title: AI Agent — Các Định Nghĩa & Khái Niệm Cốt Lõi
date: 2026-03-10 23:17:00 +0700
categories: [AI]
tags: [AI]
description: Tài liệu dành cho Backend Developer mới bắt đầu với AI Agent. Mục tiêu: Hiểu rõ từng khái niệm trước khi thực hành
---

## 1. Các Thành Phần Cơ Bản

| Khái niệm                      | Định nghĩa                                                                                                   | Ví dụ thực tế                                                                            |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- |
| **LLM** (Large Language Model) | Mô hình ngôn ngữ lớn — "bộ não" của AI, có khả năng hiểu và sinh text                                        | ChatGPT, Claude, Gemini                                                                  |
| **AI Agent**                   | LLM + khả năng **tự quyết định** + **thực thi hành động** nhiều bước liên tiếp mà không cần hỏi lại mỗi bước | Claude Code tự đọc file → viết code → chạy test → sửa lỗi                                |
| **Sub-Agent**                  | Agent con, được giao một nhiệm vụ chuyên biệt duy nhất, hoạt động độc lập hoặc được điều phối bởi Main Agent | Agent chỉ chuyên review security, Agent chỉ chuyên viết test                             |
| **Orchestrator**               | Agent "tổng chỉ huy" — nhận yêu cầu từ người dùng, phân tích rồi phân công cho các Sub-Agent phù hợp         | Main Agent nhận task từ Jira → giao cho Agent phân tích → Agent viết code → Agent review |
| **Prompt**                     | Đoạn văn bản hướng dẫn/yêu cầu gửi đến LLM                                                                   | "Phân tích ticket này và estimate thời gian"                                             |
| **Context Window**             | Giới hạn lượng thông tin (token) mà Agent có thể "nhớ" trong một lần xử lý                                   | Giống như RAM — Agent chỉ "nhìn thấy" một lượng text nhất định tại một thời điểm         |
| **Token**                      | Đơn vị xử lý của LLM — xấp xỉ ¾ từ tiếng Anh hoặc 1–2 ký tự                                                  | "Hello" ≈ 1 token, "Xin chào" ≈ 3 tokens                                                 |

---

## 2. Tools & MCP

| Khái niệm                        | Định nghĩa                                                                                                                                | Ví dụ thực tế                                                    |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| **Tool**                         | Khả năng bổ sung cho Agent — cho phép Agent thực hiện hành động thay vì chỉ trả lời text                                                  | Đọc file, chạy lệnh bash, gọi API                                |
| **MCP** (Model Context Protocol) | Giao thức chuẩn mở do Anthropic tạo ra — là "cầu nối" cho phép Agent kết nối và sử dụng các công cụ/dịch vụ bên ngoài một cách thống nhất | Agent dùng MCP để đọc Jira, push GitHub, query database          |
| **MCP Server**                   | Phần server cài ở máy bạn hoặc cloud — expose các tool/dịch vụ ra theo chuẩn MCP để Agent có thể gọi                                      | `mcp-server-github`, `mcp-server-postgres`, `mcp-server-jira`    |
| **MCP Client**                   | Phần nằm trong Agent/IDE — gửi request đến MCP Server để dùng tool                                                                        | Claude Code (client) gọi MCP Server GitHub                       |
| **Function Calling**             | Cơ chế cho phép LLM "gọi hàm" với tham số cụ thể thay vì chỉ trả về text — nền tảng của Tool Use                                          | LLM quyết định gọi `create_file(path="api.yaml", content="...")` |
| **Tool Use**                     | Thuật ngữ của Anthropic cho việc Agent sử dụng các công cụ thông qua Function Calling                                                     | Agent dùng tool `bash` để chạy `npm test`                        |

---

## 3. Rules, Skills & Memory

| Khái niệm             | Định nghĩa                                                                                          | Ví dụ thực tế                                                              |
| --------------------- | --------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| **Rules**             | Tập các luật/ràng buộc mà Agent **bắt buộc** phải tuân theo trong mọi tình huống                    | "Không bao giờ xóa file", "Luôn viết unit test", "Comment bằng tiếng Việt" |
| **Skills**            | Tập hướng dẫn chi tiết cách thực hiện một công việc cụ thể — Agent đọc và làm theo                  | Hướng dẫn viết OpenAPI spec chuẩn, hướng dẫn tạo file PPTX                 |
| **CLAUDE.md**         | File cấu hình chính của Claude Code — nơi bạn khai báo Rules, Skills, convention, thông tin project | Giống như "sổ tay nội quy" mà Agent đọc mỗi khi khởi động                  |
| **Memory**            | Khả năng Agent lưu và truy xuất thông tin giữa các session khác nhau                                | Agent nhớ rằng team bạn dùng PostgreSQL, naming convention là camelCase    |
| **System Prompt**     | Prompt nền được đặt sẵn trước khi người dùng nhập — định hình "tính cách" và hành vi của Agent      | "Bạn là Senior Backend Developer, luôn viết code clean và có test"         |
| **Few-shot Examples** | Cung cấp một vài ví dụ mẫu trong prompt để Agent hiểu format/style mong muốn                        | Cho Agent xem 2–3 API endpoint mẫu trước khi bảo nó viết thêm              |

---

## 4. Kiến Trúc & Workflow

| Khái niệm                | Định nghĩa                                                                                                         | Ví dụ thực tế                                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ |
| **Agentic Loop**         | Vòng lặp Agent tự thực hiện: Suy nghĩ → Hành động → Quan sát kết quả → Suy nghĩ tiếp... cho đến khi hoàn thành     | Agent chạy test → thấy lỗi → sửa code → chạy test lại → pass → dừng                                    |
| **ReAct** (Reason + Act) | Pattern phổ biến: Agent xen kẽ giữa **lý luận** (Thought) và **hành động** (Action) để giải quyết vấn đề từng bước | Thought: "File này thiếu validation" → Action: thêm validation → Thought: "Cần test case cho case này" |
| **Chain of Thought**     | Kỹ thuật yêu cầu Agent "suy nghĩ từng bước" trước khi đưa ra kết luận — tăng độ chính xác                          | Agent phân tích: "Bước 1: đọc requirement → Bước 2: xác định entity → Bước 3: thiết kế API"            |
| **Multi-Agent**          | Kiến trúc nhiều Agent phối hợp — mỗi Agent chuyên một việc, cùng hoàn thành một task lớn                           | Agent A đọc spec → Agent B viết code → Agent C viết test → Agent D review                              |
| **Handoff**              | Thời điểm một Agent "chuyển giao" công việc và kết quả của mình cho Agent tiếp theo                                | Agent phân tích xong → handoff kết quả + context sang Agent viết code                                  |
| **Human-in-the-loop**    | Thiết kế có điểm dừng để con người xác nhận trước khi Agent tiếp tục — quan trọng cho tác vụ rủi ro cao            | Agent chuẩn bị xong lệnh deploy → dừng lại hỏi "Bạn có muốn deploy lên PRO không?"                     |

---

## 5. Các Công Cụ Thực Tế

| Công cụ            | Loại                  | Dùng để làm gì                                                  | Phù hợp bước nào          |
| ------------------ | --------------------- | --------------------------------------------------------------- | ------------------------- |
| **Claude Code**    | AI Coding Agent (CLI) | Đọc/viết/sửa code, chạy lệnh, tự động hóa toàn bộ workflow dev  | Bước 1 → 7                |
| **GitHub Copilot** | AI Autocomplete       | Gợi ý code inline trong VS Code                                 | Bước 4                    |
| **Cursor**         | AI-powered IDE        | IDE tích hợp AI sâu hơn VS Code                                 | Bước 4, 5                 |
| **n8n / Make**     | Workflow Automation   | Kết nối các service, tự động hóa quy trình không cần code nhiều | Bước 1, 6, 7              |
| **LangChain**      | AI Framework          | Framework Python/JS để build Agent tùy chỉnh                    | Khi cần build Agent riêng |
| **MCP Servers**    | Integration Layer     | Kết nối Claude Code với Jira, GitHub, DB, Slack...              | Bước 1, 6, 7              |

---

## 6. Các MCP Server Hữu Ích Cho Developer

| MCP Server              | Kết nối với       | Dùng để làm gì                       |
| ----------------------- | ----------------- | ------------------------------------ |
| `mcp-server-github`     | GitHub / GitLab   | Đọc issue, tạo PR, push code, merge  |
| `mcp-server-jira`       | Jira              | Đọc ticket, cập nhật status, comment |
| `mcp-server-postgres`   | PostgreSQL        | Query DB, xem schema, chạy migration |
| `mcp-server-filesystem` | Local file system | Đọc/ghi file, duyệt thư mục          |
| `mcp-server-slack`      | Slack             | Gửi thông báo, đọc message           |
| `mcp-server-docker`     | Docker            | Build image, start/stop container    |

---

## 7. Sơ Đồ Kiến Trúc Tổng Quan

```
┌─────────────────────────────────────────────────────┐
│                    BẠN (Human)                      │
│              "Xử lý ticket JIRA-123"                │
└─────────────────────┬───────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              ORCHESTRATOR AGENT                     │
│         (Claude Code + CLAUDE.md Rules)             │
│   "Đọc ticket → phân tích → phân công sub-agents"   │
└──────┬──────────┬──────────┬──────────┬─────────────┘
       │          │          │          │
       ▼          ▼          ▼          ▼
  ┌─────────┐ ┌────────┐ ┌───────┐ ┌─────────┐
  │ Sub-    │ │ Sub-   │ │ Sub-  │ │ Sub-    │
  │ Agent   │ │ Agent  │ │ Agent │ │ Agent   │
  │ Đọc Docs│ │ Code   │ │ Test  │ │ Review  │
  └────┬────┘ └───┬────┘ └───┬───┘ └────┬────┘
       │          │          │          │
       ▼          ▼          ▼          ▼
  ┌─────────────────────────────────────────┐
  │              MCP LAYER                  │
  │  Jira │ GitHub │ FileSystem │ Database  │
  └─────────────────────────────────────────┘
```

---

## 8. Glossary Nhanh (Tra Cứu)

| Thuật ngữ                      | Viết tắt | Nghĩa                                                      |
| ------------------------------ | -------- | ---------------------------------------------------------- |
| Large Language Model           | LLM      | Mô hình ngôn ngữ lớn                                       |
| Model Context Protocol         | MCP      | Giao thức kết nối model với tool                           |
| Retrieval-Augmented Generation | RAG      | Kỹ thuật cho Agent tra cứu dữ liệu ngoài trước khi trả lời |
| Chain of Thought               | CoT      | Kỹ thuật suy nghĩ từng bước                                |
| Human in the Loop              | HITL     | Có con người xác nhận trong quy trình                      |
| System Integration Testing     | SIT      | Môi trường kiểm thử tích hợp                               |
| User Acceptance Testing        | UAT      | Môi trường kiểm thử người dùng                             |
| Input/Output                   | I/O      | Dữ liệu vào/ra của Agent                                   |

---

_Phiên bản 1.0 — Cập nhật theo lộ trình học thực tế_
