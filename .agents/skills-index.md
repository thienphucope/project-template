# Matt Pocock Skills — Backlog Index

Nguồn gốc: [mattpocock/skills](https://github.com/mattpocock/skills).

## Đã cài sẵn trong `.agents/skills/` (13 cross-project skills)

- `code-review` — Review diff theo 2 trục (Standards & Spec) bằng subagent song song *(đã chỉnh tìm ticket trong `docs/progress/undone/`)*
- `codebase-design` — Nguyên tắc thiết kế deep module & seams
- `diagnosing-bugs` — Loop debug có kỷ luật (repro → thu gọn → giả thuyết → fix → test)
- `domain-modeling` — Chuẩn hóa thuật ngữ miền vào `docs/glossary.md` và `docs/adr/` *(đã chỉnh đường dẫn mặc định `docs/glossary.md`)*
- `grill-me` — Phỏng vấn từng nhánh của cây quyết định đến khi chốt xong
- `grill-with-docs` — Phỏng vấn thiết kế kèm cập nhật `docs/glossary.md` & `docs/adr/`
- `grilling` — Primitive phỏng vấn dùng chung cho `grill-me` và `grill-with-docs`
- `handoff` — Đóng gói ngữ cảnh phiên thành tài liệu handoff
- `improve-codebase-architecture` — Quét codebase tìm cơ hội gom thành deep module
- `tdd` — Vòng red-green-refactor theo từng vertical slice
- `teach` — Dạy kỹ năng/khái niệm qua nhiều phiên
- `wait-what` — Diễn đạt lại thông điệp khó hiểu bằng ngôn ngữ đơn giản + `docs/glossary.md`
- `writing-for-agents` — Chuẩn viết `SKILL.md`, `AGENTS.md`, `CLAUDE.md`

---

## Các skill còn lại để cân nhắc theo từng dự án (26 skills)

> Khi muốn lấy thêm skill nào, copy thư mục tương ứng từ repo `mattpocock/skills` về thẳng `.agents/skills/<ten-skill>/`.

### 1. Engineering (13)

| Skill | Nguồn | Mô tả ngắn |
|---|---|---|
| `ask-matt` | [`skills/engineering/ask-matt`](https://github.com/mattpocock/skills/tree/main/skills/engineering/ask-matt) | Router gợi ý skill/flow phù hợp |
| `setup-matt-pocock-skills` | [`skills/engineering/setup-matt-pocock-skills`](https://github.com/mattpocock/skills/tree/main/skills/engineering/setup-matt-pocock-skills) | Cấu hình GitHub/GitLab issue tracker (không cần nếu dùng `docs/progress/`) |
| `to-spec` | [`skills/engineering/to-spec`](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-spec) | Tổng hợp hội thoại thành spec |
| `to-tickets` | [`skills/engineering/to-tickets`](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-tickets) | Chia plan/spec thành tracer-bullet tickets có dependency |
| `implement` | [`skills/engineering/implement`](https://github.com/mattpocock/skills/tree/main/skills/engineering/implement) | Code theo spec/ticket, gọi `/tdd` + `/code-review` |
| `implement-spec` | [`skills/engineering/implement-spec`](https://github.com/mattpocock/skills/tree/main/skills/engineering/implement-spec) | Triển khai spec theo task graph bằng subagent song song |
| `wayfinder` | [`skills/engineering/wayfinder`](https://github.com/mattpocock/skills/tree/main/skills/engineering/wayfinder) | Lập bản đồ decision tickets cho đầu việc rất lớn |
| `triage` | [`skills/engineering/triage`](https://github.com/mattpocock/skills/tree/main/skills/engineering/triage) | Phân loại issue qua state machine triage |
| `retro` | [`skills/engineering/retro`](https://github.com/mattpocock/skills/tree/main/skills/engineering/retro) | Đề xuất cải thiện môi trường/checks của agent sau phiên |
| `research` | [`skills/engineering/research`](https://github.com/mattpocock/skills/tree/main/skills/engineering/research) | Nghiên cứu nguồn gốc tin cậy và lưu Markdown có trích dẫn |
| `prototype` | [`skills/engineering/prototype`](https://github.com/mattpocock/skills/tree/main/skills/engineering/prototype) | Dựng prototype nhanh kiểm chứng thiết kế (HTML/UI) |
| `pr` | [`skills/engineering/pr`](https://github.com/mattpocock/skills/tree/main/skills/engineering/pr) | Mẫu viết PR body (visual + before/after + merge danger) |
| `wizard` | [`skills/engineering/wizard`](https://github.com/mattpocock/skills/tree/main/skills/engineering/wizard) | Sinh bash wizard cho bước thủ công của người dùng |

### 2. Productivity (1)

| Skill | Nguồn | Mô tả ngắn |
|---|---|---|
| `to-questionnaire` | [`skills/productivity/to-questionnaire`](https://github.com/mattpocock/skills/tree/main/skills/productivity/to-questionnaire) | Tạo bảng câu hỏi Markdown gửi người khác chốt |

### 3. Misc (4) & In-progress (8)

- **Misc:** `git-guardrails-claude-code`, `migrate-to-shoehorn`, `scaffold-exercises`, `setup-pre-commit`
- **In-progress:** `chief-of-staff`, `claude-handoff`, `loop-me`, `setup-ts-deep-modules`, `software-factory`, `writing-beats`, `writing-fragments`, `writing-shape`
