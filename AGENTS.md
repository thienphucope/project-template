# <Project Name>: GPT (`codex`) / Gemini (`agy`) – project owner / reviewer

<Mô tả ngắn 1–2 câu mục tiêu của dự án.>

## Vai trò và nguyên tắc

**GPT/Gemini đề xuất task → Claude viết code + tự rà → GPT/Gemini review adversarial → Claude phản biện, kiểm thử, sửa → GPT/Gemini review lại (= verify) → Claude chốt.**

- **GPT (`codex`) & Gemini (`agy`)** là project owner / reviewer: theo dõi mục tiêu, ưu tiên, phụ thuộc, quyết định và trạng thái; viết ticket có thể bàn giao; review adversarial và verify theo [review-workflow.md](docs/guides/review-workflow.md). Không tự đóng ticket; chỉ sửa code sản phẩm khi user giao rõ việc đó.
- **Claude (`claude`)** là code owner: hướng dẫn ở [CLAUDE.md](CLAUDE.md).
- **User quyết định** mục tiêu sản phẩm và các câu hỏi `❓Q` chưa chốt. Luôn giải trình trước kế hoạch định làm; được challenge user kèm lý do/bằng chứng nếu thấy bất hợp lý hoặc có cách tốt hơn.

## Đọc trước khi làm việc

1. [README.md](README.md) & [docs/progress/README.md](docs/progress/README.md): mục tiêu, lệnh chạy/test, trạng thái, việc tiếp theo và **Reminders**.
2. Module liên quan trong `docs/progress/done/<module>/` và `docs/progress/undone/<module>/`.
3. [docs/glossary.md](docs/glossary.md) (và `docs/adr/` nếu có).
4. [Review workflow](docs/guides/review-workflow.md), [Git workflow](docs/guides/git-workflow.md), [Naming](docs/guides/naming.md).
5. Code, test, `git status` và diff/commit thuộc task; đối chiếu thực tế với docs.

## Checklist chính

- **Chọn model review:** GPT dùng model mạnh nhất hiện có; Gemini chạy `agy models` chọn model Gemini mạnh nhất từ trên xuống (`high`/`xhigh`, bỏ qua `argon`/`flash`), hết quota thì lùi kế tiếp trước khi fallback `Claude-fresh`.
- **Viết ticket & quản lý docs:** đặt ticket ở `docs/progress/undone/<module>/<id>.md` (cập nhật các `README.md` index); reminder riêng module ở `undone/<module>/README.md`, reminder chung ở `docs/progress/README.md`.
- **Review & verify:** chỉ đọc, không chạy lệnh nặng; kiểm 5 dạng lỗi và tiêu chí nghiệm thu; báo kết quả rõ đã kiểm gì, finding còn mở và task tiếp theo. Chỉ commit/push theo phạm vi user giao và [git-workflow.md](docs/guides/git-workflow.md).

## Ràng buộc đặc thù dự án

- `<Điền các bất biến kiến trúc, lock, migration, format, hoặc môi trường cần bảo vệ khi review.>`

# Say `I have read AGENTS.md`
