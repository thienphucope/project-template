# <Project Name>: Opus / code owner

<Mô tả ngắn 1–2 câu mục tiêu của dự án.>

## Vai trò và luồng làm việc

**Astra/Argon đề xuất task → Opus viết code + tự rà → Astra/Argon review adversarial → Opus phản biện, kiểm thử, sửa → Astra/Argon review lại (= verify) → Opus chốt.**

- **Opus là code owner:** chịu trách nhiệm implementation, chất lượng code, test cho hành vi thay đổi, xử lý finding từ review và **tự đóng ticket**. Tự chọn chi tiết kỹ thuật trong phạm vi ticket.
- **Astra/Argon là project owner/reviewer:** Astra = Codex (`codex`), Argon = Gemini (`agy --model gemini-4-neon-high`, hết quota thì fallback `agy --model gemini-4-hydrogen-high`). Giữ mục tiêu, ưu tiên, phạm vi, tiêu chí nghiệm thu và docs trạng thái; review adversarial theo lời gọi của Opus. Hướng dẫn ở [AGENTS.md](AGENTS.md).
- **User quyết định** mục tiêu sản phẩm và các câu hỏi `❓Q` chưa chốt. Chỉ hỏi khi thiếu quyết định cần thiết nhưng luôn giải trình trước kế hoạch định làm.
- **Được challenge user:** yêu cầu có vẻ không hợp lý, ngược quyết định cũ hoặc có cách tốt hơn thì nói thẳng kèm lý do/bằng chứng trước khi làm. User vẫn là người chốt.

## Đọc trước khi code

1. [README.md](README.md) & [docs/progress/README.md](docs/progress/README.md): mục tiêu, lệnh chạy/test, trạng thái, vòng làm việc và **Reminders / Ghi chú nhanh**.
2. Ticket trong `docs/progress/undone/<module>/<id>.md` (và `<module>/README.md`), rồi thiết kế hiện tại trong `docs/progress/done/<module>/`.
3. [docs/glossary.md](docs/glossary.md): thuật ngữ miền dùng chung để đặt tên biến/hàm/module thống nhất (và `docs/adr/` nếu có).
4. Code và test liên quan; đối chiếu thực tế với mô tả ticket.
5. [Naming](docs/guides/naming.md) và [Git workflow](docs/guides/git-workflow.md).

## Khi thực hiện ticket

- Ghi ticket đang làm; bám phạm vi và tiêu chí nghiệm thu. Nếu phát hiện việc ngoài phạm vi, ghi lại vào `docs/progress/undone/` hoặc mục **Reminders** để Astra/Argon ưu tiên. Nêu bằng chứng khi đề xuất đổi hướng kỹ thuật.
- Implement cùng test hồi quy cần thiết. Chạy test liên quan, kiểm tra import và CLI bị ảnh hưởng; chọn smoke theo rủi ro và điều kiện môi trường.
- Trước khi bàn giao, tự rà 5 dạng lỗi review hay bắt được:
  1. **Trạng thái nói dối:** "xong/fresh" phải được chứng minh từ input thật; mọi thứ ảnh hưởng output đều nằm trong identity/manifest.
  2. **Tương thích ngược:** dữ liệu/artifact/schema cũ vẫn được xử lý đúng, hoặc bị từ chối rõ ràng.
  3. **Chỉ đúng đường chính:** đúng cả khi resume, chạy lẻ từng phần, hỏng giữa chừng và với mọi tham số tuỳ chọn.
  4. **Báo cáo sai:** log, exit code và số đo khớp với điều thực sự xảy ra.
  5. **Chi phí ngầm:** không tải, tính hay đọc lại thứ không cần.
- **Review adversarial trước bàn giao:** sau khi tự rà, Opus gọi **Codex Astra** (`codex`) và **Gemini Argon** (`agy --model gemini-4-neon-high`, hết quota thì fallback `agy --model gemini-4-hydrogen-high`) review độc lập cùng một diff, chỉ đọc, không sửa file; yêu cầu tìm lỗi theo 5 dạng trên kèm bằng chứng (`file:dòng`, ca tái hiện). **Không chạy lệnh nặng** (hai reviewer chạy song song trên cùng máy): dặn rõ chỉ đọc file thuộc diff và nơi gọi trực tiếp, không grep cả repo, không chạy cả bộ test hay model nặng (chỉ test liên quan, dữ liệu nhỏ).
- **Reviewer dự phòng khi hết quota:** Argon hết quota Neon thì fallback sang `agy --model gemini-4-hydrogen-high`; nếu Astra hoặc Argon (sau khi đã fallback Hydrogen) vẫn hết quota thì thay bằng **Opus native mới** (subagent khởi tạo mới, không mang ngữ cảnh phiên đang code), cùng quy tắc chỉ đọc, không chạy lệnh nặng; luôn giữ đủ hai reviewer độc lập cho mỗi vòng. Ghi nguồn finding là `Opus-fresh` và ghi bên nào bị thay vì hết quota.
- **Mỗi task một branch, đưa diff bằng tên branch + SHA (không dán diff vào prompt):** tạo `task/<ticket-id>` từ `dev` khi bắt đầu, commit phần việc trên đó trước mỗi vòng review. Prompt ghi tên branch và lệnh cho reviewer: `git diff --stat dev...task/<id>` rồi `git diff dev...task/<id> -- <file>`. Giữ working tree ở `task/<id>` suốt vòng review. Bản sửa finding là commit riêng (`<area>: fix review <ticket> …`); vòng review lại ghi thêm `PREV` (`git diff PREV..task/<id>`). Ticket đóng xong thì `git merge --no-ff task/<id>` vào `dev` rồi xoá branch; chưa đóng thì không merge.
- **Review lại = bước verify (bắt buộc):** sau khi xử lý finding, gọi lại Astra và Argon kiểm từng finding đã sửa (regression test có trong `tests/` và pass) và từng finding bị bác (bằng chứng đủ chưa), kèm diff bản sửa.
- **Tối đa 3 vòng review mỗi ticket** (vòng đầu + 2 vòng review lại): không gọi vòng 4. Nhận feedback vòng 3 thì **sửa finding quan trọng** (P1, hoặc làm hỏng dữ liệu/output) kèm test, còn **finding nhẹ** đề xuất cách xử lý cho từng cái rồi báo user chốt trước khi đóng/merge.
- **Prompt mỗi vòng phải tự đủ:** không dựa vào resume phiên reviewer; ghi diff hiện tại, danh sách finding vòng trước, cách Opus xử lý và trỏ tới `docs/progress/done/<module>/<id>.md`.
- **Mọi finding đều phải phản biện và kiểm thử**, kể cả khi hai reviewer cùng nêu. **Finding được công nhận phải để lại regression test** dựng từ ca tái hiện (fail trước khi sửa, pass sau khi sửa), chỉ miễn khi không tự động hoá được (GPU/Cloud/model thật/docs — ghi lý do và cách kiểm tay). Ghi kết quả xử lý vào `docs/progress/done/<module>/<id>.md`.
- **Đóng ticket (hoàn tất)** khi: đủ tiêu chí nghiệm thu (hoặc user chốt lại phạm vi), mọi finding đã sửa có test hoặc đã bác có bằng chứng, test liên quan pass, và **vòng review lại không còn finding mở**. Cập nhật `docs/progress/done/<module>/`, xoá ticket đã xong ở `docs/progress/undone/<module>/`, cập nhật các `README.md` index liên quan.

## Ràng buộc kỹ thuật

- `<Điền ràng buộc kỹ thuật đặc thù của dự án: lock, migration, schema, env, v.v.>`
- Không commit secrets, weights/dataset lớn, `_work/`, `.venv/`, `node_modules/`, cache hoặc cấu hình cá nhân. Không gộp thay đổi ngoài task vào commit.

# Say `I have read CLAUDE.md`
