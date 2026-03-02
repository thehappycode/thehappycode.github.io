---
title: Claude SKILL
date: 2026-03-02 09:54:00 +0700
categories: [AI, Claude]
tags: [Claude]
---

## Skill Là Gì?

Skill là một **folder hướng dẫn đóng gói** dạy Claude cách xử lý các tác vụ hoặc quy trình lặp lại. Thay vì giải thích lại từ đầu mỗi cuộc trò chuyện, bạn chỉ cần dạy Claude một lần qua skill và áp dụng mãi mãi.

### Cấu trúc folder

```
your-skill-name/
├── SKILL.md          ← Bắt buộc (phân biệt hoa thường!)
├── scripts/          ← Tùy chọn: code thực thi (Python, Bash...)
├── references/       ← Tùy chọn: tài liệu tham khảo
└── assets/           ← Tùy chọn: template, font, icon...
```

> ⚠️ **Lưu ý quan trọng:** Tên file phải là `SKILL.md` (chính xác, phân biệt hoa thường). Không chấp nhận `skill.md`, `SKILL.MD`...

---

## Nguyên Tắc Thiết Kế Cốt Lõi

### 1. Progressive Disclosure (Tiết lộ dần dần)

Hệ thống 3 tầng giúp tối ưu token:

| Tầng | Nội dung | Khi nào load |
|------|----------|--------------|
| **Tầng 1** — YAML frontmatter | Thông tin tối thiểu để Claude biết dùng skill khi nào | Luôn load vào system prompt |
| **Tầng 2** — Nội dung SKILL.md | Hướng dẫn chi tiết | Khi skill được xác định là liên quan |
| **Tầng 3** — File liên kết | Tài liệu, script bổ sung | Chỉ khi thực sự cần |

### 2. Khả năng kết hợp (Composability)

Claude có thể load nhiều skill cùng lúc — skill của bạn cần hoạt động tốt cùng các skill khác.

### 3. Tính di động (Portability)

Skill hoạt động giống nhau trên **Claude.ai**, **Claude Code**, và **API**. Tạo một lần, dùng mọi nơi.

---

## Skills + MCP: Sức Mạnh Kết Hợp

| | MCP (Kết nối) | Skills (Kiến thức) |
|--|---------------|-------------------|
| **Mục đích** | Kết nối Claude với dịch vụ bên ngoài | Dạy Claude cách dùng hiệu quả |
| **Chức năng** | Truy cập dữ liệu, gọi tool real-time | Nắm bắt quy trình & best practices |
| **Phạm vi** | Claude **CÓ THỂ** làm gì | Claude **NÊN** làm gì |

> 💡 **Ví von:** MCP là nhà bếp chuyên nghiệp (công cụ + nguyên liệu). Skill là công thức nấu ăn (cách làm ra thứ có giá trị). Kết hợp lại → hoàn thành tác vụ phức tạp một cách đáng tin cậy.

---

## 3 Loại Skill Phổ Biến

### Loại 1: Tạo tài liệu & asset
Dùng cho: tài liệu, slide, thiết kế, code...  
*Ví dụ:* skill `frontend-design` — tạo giao diện production-grade.

### Loại 2: Tự động hóa quy trình
Dùng cho: quy trình nhiều bước, phối hợp nhiều MCP server.  
*Ví dụ:* skill `skill-creator` — dẫn dắt user tạo skill mới.

### Loại 3: Nâng cấp MCP
Dùng cho: biến quyền truy cập tool thành quy trình đáng tin cậy.  
*Ví dụ:* skill `sentry-code-review` — tự động phân tích bug từ GitHub PR dùng dữ liệu Sentry.

---

## YAML Frontmatter — Phần Quan Trọng Nhất

### Format tối thiểu

```yaml
---
name: your-skill-name
description: Skill làm gì. Dùng khi user yêu cầu [các cụm từ cụ thể].
---
```

### Quy tắc bắt buộc

- **`name`:** Chỉ dùng `kebab-case`, không dấu cách, không viết hoa
- **`description`:** PHẢI bao gồm cả **LÀM GÌ** và **KHI NÀO DÙNG** (trigger phrases), tối đa 1024 ký tự
- Không dùng tag XML trong frontmatter
- Không đặt tên skill có tiền tố `claude` hoặc `anthropic`

### Ví dụ description TỐT vs XẤU

```yaml
# ✅ TỐT — cụ thể, có trigger phrases
description: Phân tích file thiết kế Figma và tạo tài liệu handoff cho developer.
  Dùng khi user upload file .fig, yêu cầu "design specs", "component documentation",
  hoặc "design-to-code handoff".

# ❌ XẤU — quá mơ hồ, không có trigger
description: Giúp xử lý dự án.
```

### Tất cả các field tùy chọn

```yaml
---
name: skill-name
description: Mô tả đầy đủ...
license: MIT
allowed-tools: "Bash(python:*) Bash(npm:*) WebFetch"
metadata:
  author: Tên Tác Giả
  version: 1.0.0
  mcp-server: server-name
  category: productivity
  tags: [project-management, automation]
---
```

---

## Viết Hướng Dẫn Hiệu Quả

### Cấu trúc SKILL.md khuyến nghị

```markdown
---
name: your-skill
description: [...]
---

# Tên Skill

## Hướng dẫn

### Bước 1: [Bước chính]
Giải thích rõ ràng những gì sẽ xảy ra.

## Ví dụ
### Ví dụ 1: [tình huống phổ biến]
User nói: "..."
Hành động: ...
Kết quả: ...

## Xử lý lỗi
### Lỗi: [Thông báo lỗi]
Nguyên nhân: ...
Giải pháp: ...
```

### Nguyên tắc viết hướng dẫn

- **Cụ thể và có thể thực hiện** — nêu rõ lệnh, tham số, output mong đợi
- **Bao gồm xử lý lỗi** — chỉ rõ cách khắc phục từng lỗi phổ biến
- **Dùng progressive disclosure** — chuyển tài liệu dài sang `references/`
- **Giữ SKILL.md dưới 5.000 từ**

---

## 5 Mẫu Thiết Kế Workflow

| Mẫu | Dùng khi | Kỹ thuật chính |
|-----|----------|----------------|
| **1. Điều phối tuần tự** | Quy trình nhiều bước theo thứ tự cụ thể | Thứ tự bước rõ ràng, kiểm tra tại mỗi giai đoạn |
| **2. Phối hợp nhiều MCP** | Quy trình trải dài nhiều dịch vụ | Phân chia giai đoạn, truyền dữ liệu giữa MCP |
| **3. Cải tiến lặp lại** | Chất lượng output cải thiện qua mỗi lần lặp | Tiêu chí chất lượng rõ, script kiểm tra |
| **4. Chọn tool theo ngữ cảnh** | Cùng kết quả nhưng tool khác nhau tùy ngữ cảnh | Cây quyết định rõ ràng, có phương án dự phòng |
| **5. Kiến thức chuyên ngành** | Skill cần kiến thức chuyên sâu ngoài truy cập tool | Nhúng logic chuyên ngành, log đầy đủ |

---

## Kiểm Thử Skill

### 3 lĩnh vực cần test

1. **Test kích hoạt** — Skill load đúng lúc không?
2. **Test chức năng** — Skill tạo output đúng không?
3. **So sánh hiệu suất** — Có skill vs không có skill (số tương tác, lỗi API, token tiêu thụ)

### Dùng skill-creator

Nói với Claude: *"Dùng skill-creator giúp tôi tạo skill cho [use case]"*

---

## Xử Lý Lỗi Thường Gặp

| Lỗi | Nguyên nhân | Giải pháp |
|-----|------------|-----------|
| Không upload được | Tên file sai | Đổi chính xác thành `SKILL.md` |
| Invalid frontmatter | Lỗi YAML | Kiểm tra dấu `---` phân cách |
| Skill không tự kích hoạt | Description quá chung chung | Thêm trigger phrases cụ thể |
| Skill kích hoạt quá nhiều | Description quá rộng | Thêm negative trigger, thu hẹp phạm vi |
| Lệnh MCP thất bại | Mất kết nối hoặc sai tên tool | Kiểm tra Settings > Extensions |
| Claude không theo hướng dẫn | Hướng dẫn quá dài/mơ hồ | Dùng `## CRITICAL`, đặt lên đầu |

---

## 📦 Ví Dụ Skill Hoàn Chỉnh

Dưới đây là một skill thực tế từ đầu đến cuối — minh hoạ đủ các thành phần: frontmatter, hướng dẫn từng bước, ví dụ, xử lý lỗi, và bảo mật.

> **Tình huống:** Skill giúp tạo báo cáo tóm tắt tuần từ các task đã hoàn thành trong Linear, sau đó gửi lên kênh Slack của team.

### Cấu trúc folder

```
weekly-report-linear/
├── SKILL.md
├── scripts/
│   └── format_report.py
└── references/
    └── report-template.md
```

### Nội dung `SKILL.md`

````markdown
---
name: weekly-report-linear
description: Tạo báo cáo tóm tắt công việc tuần từ Linear và gửi lên Slack.
  Dùng khi user nói "báo cáo tuần", "weekly report", "tổng kết sprint",
  "tóm tắt task tuần này", hoặc "gửi report lên Slack".
  KHÔNG dùng cho báo cáo tháng/quý hoặc truy vấn Linear không liên quan đến report.
license: MIT
metadata:
  author: Team Dev
  version: 1.2.0
  changelog: "v1.2.0 — Thêm lọc theo assignee; v1.1.0 — Bổ sung xử lý lỗi Slack"
  mcp-server: linear, slack
  category: productivity
---

# Weekly Report — Linear → Slack

## Yêu cầu & Bảo mật

- Skill này truy cập Linear (đọc task) và Slack (gửi tin nhắn)
- Chỉ cấp quyền **read-only** cho Linear workspace cần báo cáo
- Chỉ cấp quyền **post message** cho kênh Slack cụ thể, không cấp quyền đọc lịch sử
- Không lưu dữ liệu task ra file; xử lý trong bộ nhớ rồi gửi đi ngay

---

## CRITICAL: Kiểm tra trước khi bắt đầu

Trước khi thực hiện bất kỳ bước nào, xác nhận với user:
1. Khoảng thời gian báo cáo (mặc định: tuần hiện tại, thứ Hai → hôm nay)
2. Lọc theo team hay toàn bộ workspace?
3. Kênh Slack nào sẽ nhận báo cáo?

Nếu user không cung cấp, hỏi trực tiếp — không tự suy đoán.

---

## Hướng dẫn

### Bước 1: Lấy danh sách task đã hoàn thành từ Linear

Gọi Linear MCP tool: `list_issues`

Tham số:
- `state`: "completed"
- `completedAfter`: ngày đầu tuần (thứ Hai)
- `completedBefore`: ngày hôm nay
- `teamId`: (nếu user chỉ định team cụ thể)

Output mong đợi: Danh sách task với `title`, `assignee`, `completedAt`, `url`

### Bước 2: Format báo cáo

Chạy script format:

```bash
python scripts/format_report.py --input "{task_list_json}" --week "{week_label}"
```

Script sẽ nhóm task theo assignee và xuất markdown.

Tham khảo `references/report-template.md` để biết cấu trúc mong đợi.

### Bước 3: Preview và xác nhận

Hiển thị bản preview báo cáo cho user.
**Dừng lại và hỏi:** "Báo cáo trông ổn chưa? Bạn có muốn chỉnh sửa gì trước khi gửi không?"

Chỉ tiếp tục khi user xác nhận.

### Bước 4: Gửi lên Slack

Gọi Slack MCP tool: `post_message`

Tham số:
- `channel`: kênh user đã chỉ định
- `text`: nội dung báo cáo đã format
- `unfurl_links`: false

Output mong đợi: Message timestamp (ts) xác nhận gửi thành công

---

## Ví dụ

### Ví dụ 1: Báo cáo toàn team

User nói: *"Tạo báo cáo tuần này và gửi lên #dev-updates"*

Hành động:
1. Lấy tất cả task completed từ thứ Hai đến hôm nay trong Linear
2. Format theo nhóm assignee
3. Preview → chờ xác nhận
4. Gửi vào kênh `#dev-updates`

Kết quả: Tin nhắn báo cáo xuất hiện trên Slack kèm link từng task

### Ví dụ 2: Báo cáo theo team cụ thể

User nói: *"Weekly report cho team Backend thôi nhé, gửi vào #backend"*

Hành động: Tương tự nhưng lọc `teamId` = Backend team ID

---

## Xử lý lỗi

### Lỗi: Không có task nào trong tuần

Nguyên nhân: Không có task completed trong khoảng thời gian  
Giải pháp: Thông báo cho user — *"Không tìm thấy task nào hoàn thành trong tuần này. Bạn có muốn mở rộng khoảng thời gian không?"*

### Lỗi: Linear MCP — "Unauthorized"

Nguyên nhân: Token hết hạn hoặc sai workspace  
Giải pháp:
1. Kiểm tra Settings > Extensions > Linear → phải hiện "Connected"
2. Nếu chưa kết nối: hướng dẫn user reconnect và thử lại

### Lỗi: Slack MCP — "channel_not_found"

Nguyên nhân: Tên kênh sai hoặc bot chưa được thêm vào kênh  
Giải pháp: Hỏi lại tên kênh chính xác. Nhắc user thêm bot vào kênh trước khi gửi.
````

### Nội dung `references/report-template.md`

```markdown
# Báo cáo Tuần — {week_label}

## Tổng quan
- Tổng task hoàn thành: {total}
- Thành viên tham gia: {member_count}

## Chi tiết theo thành viên

### {assignee_name}
- [ ] [{task_title}]({task_url}) — hoàn thành {completedAt}

---
*Tự động tạo bởi skill weekly-report-linear*
```

### Nội dung `scripts/format_report.py`

```python
import json
import argparse
import os
from datetime import datetime

def format_report(tasks: list, week_label: str) -> str:
    # Nhóm task theo assignee
    by_assignee = {}
    for task in tasks:
        name = task.get("assignee", {}).get("name", "Chưa phân công")
        by_assignee.setdefault(name, []).append(task)

    lines = [f"# Báo cáo Tuần — {week_label}", ""]
    lines.append(f"**Tổng task hoàn thành:** {len(tasks)}  ")
    lines.append(f"**Thành viên:** {len(by_assignee)}\n")

    for assignee, items in sorted(by_assignee.items()):
        lines.append(f"### {assignee}")
        for t in items:
            date = t.get("completedAt", "")[:10]
            lines.append(f"- [{t['title']}]({t['url']}) — {date}")
        lines.append("")

    lines.append("---\n*Tự động tạo bởi skill weekly-report-linear*")
    return "\n".join(lines)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True)
    parser.add_argument("--week", required=True)
    args = parser.parse_args()

    tasks = json.loads(args.input)
    print(format_report(tasks, args.week))
```

---

### Tại sao ví dụ này đạt chuẩn?

| Tiêu chí | Có trong ví dụ |
|----------|---------------|
| YAML frontmatter đầy đủ (name, description, metadata, changelog) | ✅ |
| Description có trigger phrases rõ ràng và negative trigger | ✅ |
| Mục Yêu cầu & Bảo mật ở đầu file | ✅ |
| CRITICAL block để đảm bảo xác nhận trước khi hành động | ✅ |
| Hướng dẫn từng bước cụ thể, có tham số | ✅ |
| Ví dụ minh hoạ cho các tình huống khác nhau | ✅ |
| Xử lý lỗi với nguyên nhân + giải pháp | ✅ |
| Progressive disclosure — tài liệu dài để trong `references/` | ✅ |
| Script thực thi trong `scripts/` | ✅ |
| Version và changelog trong metadata | ✅ |

---

## Phân Phối Skill

- **Cá nhân:** Upload lên Claude.ai qua *Settings > Capabilities > Skills* hoặc đặt vào thư mục skills của Claude Code
- **Tổ chức:** Admin triển khai cho toàn workspace (từ 18/12/2025)
- **API:** Dùng endpoint `/v1/skills` và tham số `container.skills` trong Messages API
- **Tiêu chuẩn mở:** Anthropic phát hành tại [agentskills.io](https://agentskills.io)

---

## Checklist Nhanh Trước Khi Upload

- [ ] Folder đặt tên `kebab-case`
- [ ] File `SKILL.md` tồn tại (đúng chính tả)
- [ ] YAML frontmatter có dấu `---` phân cách
- [ ] `name` dùng kebab-case
- [ ] `description` bao gồm **LÀM GÌ** và **KHI NÀO**
- [ ] Không có tag XML
- [ ] Hướng dẫn rõ ràng, có xử lý lỗi, có ví dụ
- [ ] Đã test kích hoạt và test chức năng
- [ ] Đã nén thành file `.zip`

---

## 🔍 Ghi Chú Bổ Sung & Đánh Giá Tài Liệu

> *Phần này do Claude bổ sung sau khi phân tích tài liệu.*

### ✅ Điểm mạnh của tài liệu

- Hướng dẫn rất cụ thể, có ví dụ tốt/xấu rõ ràng
- Cấu trúc logic từ khái niệm → thiết kế → kiểm thử → phân phối
- Bảng so sánh MCP vs Skills giúp người mới dễ hiểu
- Checklist thực tế, dễ dùng ngay

### ⚠️ Những Điểm Cần Lưu Ý Hoặc Bổ Sung

---

#### 🔖 1. Quản Lý Phiên Bản (Versioning) — *Quan trọng*

Tài liệu gốc chỉ đề cập field `version` trong metadata mà không hướng dẫn cách quản lý. Dưới đây là quy ước đề xuất theo chuẩn **Semantic Versioning (SemVer)**:

```
MAJOR.MINOR.PATCH
  │      │     └─ Sửa lỗi nhỏ, không thay đổi hành vi
  │      └─ Thêm tính năng, vẫn tương thích ngược
  └─ Thay đổi lớn, có thể breaking change
```

**Ví dụ thực tế:**

| Thay đổi | Version cũ | Version mới |
|----------|------------|-------------|
| Sửa lỗi typo trong hướng dẫn | 1.0.0 | 1.0.1 |
| Thêm bước xử lý lỗi mới | 1.0.1 | 1.1.0 |
| Đổi hoàn toàn cấu trúc quy trình | 1.1.0 | 2.0.0 |

**Ghi version trong frontmatter:**

```yaml
---
name: my-skill
description: ...
metadata:
  version: 1.2.0
  changelog: "v1.2.0 — Thêm xử lý lỗi MCP timeout; v1.1.0 — Bổ sung bước kiểm tra dữ liệu"
---
```

**Lưu ý quan trọng khi cập nhật skill:**
- Luôn tăng version khi thay đổi hướng dẫn, dù nhỏ — giúp debug dễ hơn khi skill hoạt động sai
- Với skill dùng cho team/tổ chức: ghi rõ changelog để thành viên biết skill đã thay đổi gì
- Nếu phân phối qua GitHub: dùng Git tags tương ứng với version trong SKILL.md

---

#### 🔐 2. Bảo Mật Khi Dùng MCP Với Dữ Liệu Nhạy Cảm — *Quan trọng*

Tài liệu gốc hoàn toàn không đề cập vấn đề này. Đây là điểm thiếu sót đáng kể vì skill + MCP thường xử lý dữ liệu thực của doanh nghiệp.

**Nguyên tắc Least Privilege (quyền tối thiểu):**

> Chỉ cấp cho skill đúng những quyền nó cần, không hơn.

```yaml
# ❌ Không nên — cấp quyền quá rộng
allowed-tools: "Bash(*)"

# ✅ Nên — giới hạn đúng tool cần thiết
allowed-tools: "Bash(python:scripts/fetch_report.py) WebFetch"
```

**Danh sách kiểm tra bảo mật trước khi deploy skill:**

- [ ] **API key / Token** không được hardcode trong SKILL.md hay scripts — dùng biến môi trường
- [ ] **Scope MCP** được giới hạn đúng mức: skill chỉ đọc dữ liệu thì chỉ cấp quyền read-only
- [ ] **Dữ liệu khách hàng** (PII) không được ghi vào file tạm hay log nếu không cần thiết
- [ ] **Skill công khai** (chia sẻ lên GitHub, agentskills.io) không chứa thông tin nội bộ, URL nội bộ, hay cấu hình riêng của tổ chức
- [ ] **MCP server** được xác thực đúng cách, OAuth token có thời hạn và được refresh định kỳ

**Xử lý API key an toàn trong scripts:**

```python
# ❌ Sai — hardcode key
API_KEY = "sk-abc123..."

# ✅ Đúng — đọc từ biến môi trường
import os
API_KEY = os.environ.get("MY_SERVICE_API_KEY")
if not API_KEY:
    raise ValueError("API key chưa được cấu hình. Xem hướng dẫn setup.")
```

**Ghi chú bảo mật trong SKILL.md:**  
Nên thêm mục `## Yêu cầu & Bảo mật` ở đầu file để người dùng biết trước khi dùng:

```markdown
## Yêu cầu & Bảo mật
- Skill này truy cập dữ liệu dự án qua Linear MCP — chỉ cấp quyền read cho workspace cần thiết
- Không lưu token hay API key vào file; cấu hình qua Settings > Extensions
- Dữ liệu xử lý không được gửi ra ngoài ngoài MCP server đã kết nối
```

---

#### 3. Phần `allowed-tools` Chưa Được Giải Thích Kỹ

Tài liệu có đề cập field này nhưng thiếu giải thích cú pháp. Nên bổ sung bảng tham chiếu các giá trị hợp lệ như `Bash(python:*)`, `WebFetch`, `Bash(npm:*)`.

#### 4. Giới Hạn Số Skill Bật Cùng Lúc

Tài liệu đề cập ngưỡng 20–50 skill nhưng không giải thích lý do kỹ thuật (liên quan đến độ dài system prompt và context window). Người mới có thể không hiểu tại sao cần giới hạn.

#### 5. Chưa Có Ví Dụ Skill Hoàn Chỉnh Inline

Phụ lục C chỉ dẫn ra GitHub. Nên có ít nhất 1 ví dụ đầy đủ (frontmatter + hướng dẫn) ngay trong tài liệu để người đọc không cần rời đi tra cứu.

#### 6. Field `compatibility` Còn Mờ Nhạt

Field này được đề cập ngắn gọn nhưng thiếu ví dụ: skill yêu cầu Python 3.10+, hay chỉ chạy trên Claude Code — cách ghi nhận cụ thể thế nào vẫn chưa rõ.

---

*Tài liệu tổng hợp bởi Claude | Nguồn: The Complete Guide to Building Skills for Claude — Anthropic, 29/01/2026*
