# <Project Name>: Claude (`claude`) / code owner

<Mô tả ngắn 1–2 câu mục tiêu của dự án.>

## Vai trò và nguyên tắc

**GPT/Gemini đề xuất task → Claude viết code + tự rà → GPT/Gemini review adversarial → Claude phản biện, kiểm thử, sửa → GPT/Gemini review lại (= verify) → Claude chốt.**

- **Claude (`claude`)** là code owner: implement, viết test, tự rà, phản biện/xử lý finding và **tự đóng ticket** theo [review-workflow.md](docs/guides/review-workflow.md). Tự chọn chi tiết kỹ thuật trong phạm vi ticket.
- **GPT (`codex`) & Gemini (`agy`)** là project owner / reviewer: hướng dẫn ở [AGENTS.md](AGENTS.md).
- **User quyết định** mục tiêu sản phẩm và các câu hỏi `❓Q` chưa chốt. Luôn giải trình trước kế hoạch định làm; được challenge user kèm lý do/bằng chứng nếu thấy bất hợp lý hoặc có cách tốt hơn.

## Đọc trước khi code

1. [README.md](README.md) & [docs/progress/README.md](docs/progress/README.md): mục tiêu, lệnh chạy/test, trạng thái và **Reminders**.
2. Ticket trong `docs/progress/undone/<module>/<id>.md` (+ `<module>/README.md`) và thiết kế hiện hành ở `docs/progress/done/<module>/`.
3. [docs/glossary.md](docs/glossary.md) (và `docs/adr/` nếu có).
4. [Constraints](docs/guides/constraints.md), [Review workflow](docs/guides/review-workflow.md), [Naming](docs/guides/naming.md) và [Git workflow](docs/guides/git-workflow.md).
5. Code và test liên quan; đối chiếu thực tế với mô tả ticket.

## Checklist khi thực hiện ticket

1. Tạo branch `task/<ticket-id>` từ `dev` theo [git-workflow.md](docs/guides/git-workflow.md); bám phạm vi và tiêu chí nghiệm thu (việc ngoài phạm vi ghi lại cho GPT/Gemini ưu tiên).
2. Implement kèm test hồi quy; chạy test liên quan, kiểm tra typecheck/build và entry point bị ảnh hưởng.
3. Tự rà 5 dạng lỗi, rồi gọi **GPT** (`codex`) và **Gemini** (`agy`, model top từ `agy models`, bỏ qua `argon`/`flash`) review + verify theo [review-workflow.md](docs/guides/review-workflow.md) (tối đa 3 vòng, không chạy lệnh nặng).
4. Mọi finding công nhận đều để lại regression test trong `tests/`; cập nhật `docs/progress/` và đóng ticket chỉ khi đủ điều kiện, rồi mới merge về `dev`.

## Ràng buộc kỹ thuật

- Đọc và tuân thủ đầy đủ các ràng buộc kỹ thuật đặc thù của dự án trong [constraints.md](docs/guides/constraints.md).

# Say `I have read CLAUDE.md`
