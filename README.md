# Project Template

Mẫu cấu trúc dự án kết hợp quy trình multi-agent (**Astra/Codex + Gemini/agy + Opus/Claude**) và bộ **Agent Skills** chuẩn hóa (tham khảo `mattpocock/skills`).

## Khởi tạo dự án mới từ template

1. Copy toàn bộ `E:\project-template\` sang thư mục dự án mới (hoặc `git init` trong thư mục mới).
2. Trên Windows, chạy 1 lần để nối `.claude/skills` vào `.agents/skills` (đã có sẵn trong template gốc, nhưng Git không lưu junction sang máy mới):
   ```powershell
   .\scripts\setup-agent-links.ps1
   ```
   *(Trên Linux/macOS: `ln -s ../.agents/skills .claude/skills`)*
3. Cập nhật thông tin riêng của dự án ở:
   - [AGENTS.md](AGENTS.md) & [CLAUDE.md](CLAUDE.md): mô tả dự án, ràng buộc kỹ thuật, môi trường chạy.
   - [docs/progress/README.md](docs/progress/README.md): trạng thái ban đầu và Reminders.
   - [docs/glossary.md](docs/glossary.md): thêm thuật ngữ domain khi phát sinh.
   - Mục **Lệnh chạy & Test** ngay bên dưới.
4. Xoá thư mục mẫu `_template-module/` trong `docs/progress/done/` và `docs/progress/undone/` khi đã tạo module thật đầu tiên.

## Lệnh chạy & Test

```powershell
# Cài môi trường & chạy thử
# <vd: uv sync --frozen>
# <vd: uv run pytest tests/ -q>
```

## Cấu trúc thư mục

```text
.
├── AGENTS.md                     # Hướng dẫn cho Codex (Astra) & Gemini/Antigravity (agy)
├── CLAUDE.md                     # Hướng dẫn cho Claude Code (Opus)
├── .agents/
│   ├── skills/                   # Nguồn duy nhất của 13 cross-project skills (commit lên Git)
│   └── skills-index.md           # Backlog các skill còn lại để cân nhắc lấy thêm khi cần
├── .claude/
│   └── skills                    # Junction -> ..\.agents\skills (local, đã ignore ở .gitignore)
├── scripts/
│   └── setup-agent-links.ps1     # Tạo lại junction .claude/skills khi clone sang máy mới
└── docs/
    ├── glossary.md               # Thuật ngữ domain dùng chung (1 file phẳng)
    ├── adr/                      # Architecture Decision Records (0001-slug.md)
    ├── guides/                   # Quy ước Git, đặt tên, hướng dẫn cố định
    └── progress/
        ├── README.md             # Bảng điều phối tiến độ + Reminders / Ghi chú nhanh
        ├── done/<module>/        # Task đã xong + thiết kế hiện hành theo từng module
        └── undone/<module>/      # Ticket đang mở + ghi chú riêng theo từng module
```
