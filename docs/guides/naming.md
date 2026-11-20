# Naming convention

## File

| Loại | Rule | Ví dụ |
|---|---|---|
| Docs (`.md`), config, asset | **kebab-case**: chữ thường, từ nối bằng `-` | `git-workflow.md`, `glossary.md` |
| Mã nguồn / package | `<Chốt theo ngôn ngữ dự án: vd Python một từ hoặc snake_case; TS kebab-case>` | `<vd>` |
| Ngoại lệ | Tên có chuẩn riêng giữ nguyên | `README.md`, `AGENTS.md`, `CLAUDE.md`, `SKILL.md` |

## Quy ước thư mục `docs/`

- `docs/glossary.md`: 1 file phẳng cho toàn dự án.
- `docs/adr/NNNN-<slug>.md`: quyết định kiến trúc khó đảo ngược.
- `docs/progress/done/<module>/<id>.md` & `docs/progress/undone/<module>/<id>.md`: mỗi module là 1 thư mục, có `README.md` làm index nhỏ của module đó.
- Prefix `_` (vd `_work/`, `_template-module/`): dữ liệu dẫn xuất / mẫu dùng tạm hoặc xoá được.
