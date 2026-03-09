---
title: "Claude Session"
date: 2026-03-09 08:34:00 +0700
categories: [AI, Claude]
tags: [Claude]
description: "Tổng hợp mọi thứ bạn cần biết về session trong Claude Code — từ cách mở/đóng, lưu lịch sử, resume, rename, cho đến các tính năng nâng cao như fork, worktree, hooks và memory."
---

Bài viết này tổng hợp toàn bộ kiến thức về **session trong Claude Code** — công cụ CLI mạnh mẽ của Anthropic giúp developer làm việc với AI trực tiếp trong terminal.

---

## Tại sao nên dùng Claude Code thay vì VS Code Extension?

Nếu bạn là developer chuyên nghiệp và cần thực hiện nhiều tác vụ như viết/chỉnh sửa code, debug lỗi, giải thích code, và tự động hóa task — thì **Claude Code trên terminal** là lựa chọn tốt hơn extension.

Claude Code hiểu toàn bộ codebase, có thể chạy lệnh trực tiếp, và tự động hóa mọi thứ trong một luồng làm việc liên tục. Extension chỉ thấy những gì bạn paste vào, còn Claude Code thấy cả project.

Cài đặt nhanh:

```bash
npm install -g @anthropic-ai/claude-code
cd your-project
claude
```

---

## Session là gì?

Một **session** trong Claude Code là toàn bộ lịch sử hội thoại được tích lũy trong khi bạn làm việc — bao gồm prompt, tool calls, kết quả, và responses. Mọi session đều được **tự động lưu xuống đĩa** tại `~/.claude/history.jsonl`.

---

## Session mở và đóng khi nào?

**Session MỞ** mỗi khi bạn gõ `claude` trong terminal tại một thư mục. Mỗi session được gắn với thư mục đó và nhận một session ID duy nhất.

**Session ĐÓNG** khi:
- Bạn gõ `/exit` hoặc nhấn `Ctrl+C`
- Bạn đóng terminal

Tóm tắt vòng đời:

```
gõ "claude"          → Session MỞ  (session ID mới được tạo)
làm việc...          → Mọi thứ tự động lưu liên tục
đóng terminal / exit → Session ĐÓNG (đã được lưu sẵn)
gõ "claude -c"       → Resume session cũ (không tạo mới)
gõ "claude" (thường) → Session MỚI hoàn toàn
```

---

## Lịch sử và Resume

Mọi session đều được lưu đầy đủ. Có 3 cách resume:

```bash
claude -c              # tiếp tục session gần nhất
claude --resume        # mở picker để chọn session
claude --resume abc123 # resume đúng session theo ID
```

> **Tip thực tế:** Hãy dùng `claude -c` thay vì `claude` mỗi khi mở terminal — bạn sẽ không bao giờ mất context nữa.

---

## Đổi tên Session

Có 2 cách đổi tên:

**Cách 1:** Gõ trong session đang mở:
```bash
/rename tên-session-của-bạn
```

**Cách 2:** Trong màn hình `/resume`, điều hướng đến session muốn đổi tên rồi nhấn phím **R**.

> **Tip:** Đặt tên session sớm ngay khi bắt đầu làm việc. Tìm lại `payment-integration` dễ hơn nhiều so với `explain this function`.

---

## `/clear` vs `/compact` — Quản lý Context Window

Context window của Claude Code có giới hạn 200k token. Khi đầy, performance sẽ giảm rõ rệt. Có 2 cách xử lý:

### `/clear` — Xóa hoàn toàn

Xóa toàn bộ lịch sử hội thoại, bắt đầu từ đầu. Context window về 0.

- ✅ Dùng khi: chuyển sang task hoàn toàn mới
- ⚠️ Lưu ý: **không thể hoàn tác** — mọi context đã tích lũy đều mất

### `/compact` — Nén và tóm tắt

Thay thế lịch sử bằng một bản tóm tắt thông minh. Một cuộc hội thoại 70.000 token có thể nén xuống còn ~4.000 token, trong khi vẫn giữ lại hướng làm việc và các quyết định quan trọng.

- ✅ Dùng khi: đang giữa task dài, cần giải phóng token mà không mất context
- ⚠️ Lưu ý: chi tiết nhỏ có thể bị mất trong quá trình tóm tắt

**Quy tắc đơn giản:** Dùng `/clear` khi đổi task, dùng `/compact` khi đang làm task dài.

---

## Fork Session — Thử approach mới mà không mất session gốc

Khi muốn thử một hướng khác mà không ảnh hưởng đến session đang làm:

```bash
claude --fork-session
```

Lệnh này tạo một session mới với toàn bộ lịch sử từ session gốc, nhưng từ đó phát triển độc lập. Session gốc giữ nguyên, bạn có thể quay lại bất cứ lúc nào.

Ngoài ra, dùng `/rewind` từ bên trong session để tạo fork tại một điểm cụ thể trong lịch sử. Các forked session được nhóm lại với session gốc trong picker.

---

## Chạy nhiều Session song song — Git Worktrees

Đây là tính năng mạnh nhất khi bạn muốn làm nhiều task cùng lúc mà không xung đột file.

Claude Code hỗ trợ native flag `--worktree`:

```bash
# Terminal 1 — làm feature auth
claude --worktree feature-auth

# Terminal 2 — fix bug song song
claude --worktree bugfix-123
```

Mỗi worktree là một working directory riêng với branch riêng, nhưng chia sẻ cùng git history. Không cần `git stash`, không lo merge conflict trong lúc làm việc.

**Khi nào nên dùng worktree?** Mỗi khi bạn bình thường sẽ tạo một branch riêng để tránh xung đột — đó là lúc dùng worktree thay thế.

---

## CLAUDE.md — Bộ nhớ dài hạn của Project

`CLAUDE.md` là file markdown đặc biệt được Claude tự động đọc vào context ở đầu **mỗi session**. Đây là nơi lưu những thứ bạn muốn Claude luôn biết.

Nên lưu gì trong `CLAUDE.md`:
- Build commands (`npm run dev`, `npm test`, ...)
- Code style và conventions
- Architecture decisions
- Những gotcha đặc thù của project

Có 3 cấp độ:

| File | Phạm vi |
|------|---------|
| `./CLAUDE.md` | Project hiện tại (nên commit vào git) |
| `~/.claude/CLAUDE.md` | Global, áp dụng cho mọi project |
| `./src/CLAUDE.md` | Thư mục con cụ thể |

> Tạo nhanh với lệnh `/init` — Claude sẽ scan codebase và tự generate file cho bạn.

---

## Auto Memory — Claude tự ghi nhớ

Ngoài `CLAUDE.md` do bạn viết thủ công, Claude Code còn có **Auto Memory** — tự động học và ghi nhớ project patterns, preferences của bạn vào file `MEMORY.md`. 200 dòng đầu của file này được load vào mỗi đầu session.

Điều này có nghĩa là Claude dần dần "quen" với cách bạn làm việc mà không cần bạn phải giải thích lại mỗi lần.

---

## `/context` — Kiểm tra Context Window

Dùng `/context` để xem bạn đang dùng bao nhiêu trong 200k token. Hãy coi nó như disk space điền dần trong quá trình làm việc.

> Nên chạy `/context` ít nhất một lần giữa session dài để quyết định có cần `/compact` không.

---

## Session Hooks — Tự động hóa setup/cleanup

Hooks cho phép chạy script tự động tại các thời điểm quan trọng:

| Hook | Khi nào chạy |
|------|-------------|
| `SessionStart` | Khi session bắt đầu hoặc resume |
| `SessionEnd` | Khi session kết thúc |
| `PreCompact` | Trước khi compact |

Ví dụ: mỗi session tự động biết git status hiện tại:

```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "git branch --show-current && git status --short | head -10"
      }]
    }]
  }
}
```

Lưu cấu hình này vào `~/.claude/settings.json` (global) hoặc `.claude/settings.json` (per-project).

---

## `/stats` — Xem thống kê Usage

Lệnh `/stats` tạo ra visualization về Claude Code usage của bạn — số session, usage streaks, và model hay dùng nhất. Hữu ích để theo dõi năng suất làm việc.

---

## Headless Mode — Chạy trong CI/CD

```bash
claude -p "your prompt here"
```

Headless mode (`-p`) chạy Claude Code không tương tác — lý tưởng cho CI/CD pipelines, pre-commit hooks, và build scripts. Không persist giữa các lần chạy.

---

## Tổng kết

| Tính năng | Lệnh | Dùng khi nào |
|-----------|------|-------------|
| Resume session gần nhất | `claude -c` | Mỗi khi mở terminal |
| Chọn session để resume | `claude --resume` | Cần quay lại session cũ |
| Đổi tên session | `/rename tên` | Ngay khi bắt đầu task mới |
| Xóa context | `/clear` | Chuyển sang task hoàn toàn mới |
| Nén context | `/compact` | Giữa chừng task dài |
| Tạo nhánh session | `--fork-session` | Muốn thử approach khác |
| Chạy song song | `--worktree tên` | Làm nhiều feature cùng lúc |
| Kiểm tra token | `/context` | Giữa session dài |
| Thống kê usage | `/stats` | Theo dõi năng suất |
| Tự động hóa setup | Session Hooks | Mọi project |
| CI/CD automation | `claude -p` | Pipelines, scripts |

---

*Bài viết được tổng hợp từ tài liệu chính thức của Anthropic tại [code.claude.com/docs](https://code.claude.com/docs) và kinh nghiệm thực tế của cộng đồng developer.*
