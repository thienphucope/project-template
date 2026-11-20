# Git workflow

## Nhánh

- `main`: ổn định — docs + code đã chốt. Không code thẳng.
- `dev`: nhánh làm việc chính.
- `task/<ticket-id>`: mỗi ticket một branch rẽ từ `dev`. Commit implementation và các commit sửa review (`<area>: fix review <ticket> …`) trên đó; reviewer đọc diff bằng `git diff dev...task/<id>`. Đóng ticket xong thì `git merge --no-ff task/<id>` vào `dev` rồi xoá branch. Quy trình review ở [CLAUDE.md](../../CLAUDE.md).
- Thử nghiệm lớn có khả năng vứt: `exp/<tên>`; merge về `dev` hoặc xoá.

## Commit message

```text
<area>: <tóm tắt imperative, chữ thường, ≤72 ký tự>

- chi tiết nếu cần, bullet
- quyết định + lý do nếu không hiển nhiên
```

`<area>` — ví dụ: `<module>`, `docs`, `tests`, `chore`.

Rule:
- Imperative (`add` không phải `added`), không chấm cuối, không emoji.
- Một commit một chủ đề — refactor tách khỏi feature.
- Commit phải chạy được: import và test liên quan pass.

## Trước khi commit

1. `git status` — soát file lạ, không commit secrets / cache / build / `.claude/skills`.
2. Chạy verify tối thiểu theo [README.md](../../README.md).
3. Cập nhật `docs/progress/` (`done/<module>/`, `undone/<module>/`, `README.md`) trong cùng commit khi đổi trạng thái task.
