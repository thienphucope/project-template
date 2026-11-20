# Review & Ticket Workflow

Quy trình phối hợp giữa **GPT (`codex`)**, **Gemini (`agy`)** (project owner / reviewer) và **Claude (`claude`)** (code owner).

## 1. Chọn model & Reviewer dự phòng

- **GPT (`codex`):** dùng model mạnh nhất hiện có.
- **Gemini (`agy`):** chạy `agy models`, chọn model Gemini mạnh nhất từ trên xuống ở mức `high`/`xhigh`, **bỏ qua dòng `argon` cũ và `flash`**. Hết quota thì lùi xuống model Gemini mạnh kế tiếp.
- **Dự phòng khi hết quota:** nếu GPT hoặc Gemini (sau khi đã lùi trong `agy models`) vẫn hết quota thì thay bằng **Claude native mới** (`Claude-fresh` — subagent khởi tạo mới, không mang ngữ cảnh phiên đang code), giữ nguyên quy tắc chỉ đọc, không chạy lệnh nặng. Luôn đảm bảo hai reviewer độc lập mỗi vòng (vd GPT + `Claude-fresh`, hoặc hai `Claude-fresh` độc lập nếu cả hai hết quota).

## 2. Đề xuất và bàn giao ticket

- Đặt ticket trong `docs/progress/undone/<module>/<id>.md` và cập nhật index ở `docs/progress/undone/<module>/README.md` (+ `docs/progress/undone/README.md` nếu là module mới). Giữ ID ticket ổn định để theo dõi qua các lần review.
- Mỗi ticket ghi đủ: vấn đề và ngữ cảnh (`file:dòng`); mục tiêu và phạm vi; ưu tiên/phụ thuộc; cách làm đề xuất; tiêu chí nghiệm thu; cách test; file docs cần cập nhật; quyết định đã chốt và câu hỏi mở (`❓Q`).
- Ghi chú nhỏ / reminder riêng của module đặt ở `docs/progress/undone/<module>/README.md`; reminder chung toàn dự án đặt ở mục **Reminders** trong [docs/progress/README.md](../progress/README.md).
- Phân biệt đề xuất với quyết định đã được user duyệt. Dùng trạng thái **đề xuất / đang làm / hoàn tất**; bị chặn thì ghi nguyên nhân và thông tin thiếu. Không coi việc viết ticket là đã giao cho phiên Claude đang chạy; bàn giao qua file để user dùng với Claude.

## 3. Tự rà 5 dạng lỗi trước khi gọi review

1. **Trạng thái nói dối:** "xong/fresh" phải chứng minh từ input thật; mọi yếu tố ảnh hưởng output đều nằm trong identity/manifest.
2. **Tương thích ngược:** dữ liệu/artifact/schema cũ vẫn được xử lý đúng, hoặc bị từ chối rõ ràng.
3. **Chỉ đúng đường chính:** đúng cả khi resume, chạy lẻ từng phần, hỏng giữa chừng và với mọi tham số tuỳ chọn.
4. **Báo cáo sai:** log, exit code và số đo khớp với điều thực sự xảy ra.
5. **Chi phí ngầm:** không tải, tính hay đọc lại thứ không cần.

## 4. Review adversarial (tối đa 3 vòng)

- **Cách đưa diff:** Claude tạo branch `task/<ticket-id>` theo [git-workflow.md](git-workflow.md), commit trên đó trước mỗi vòng review và giữ working tree ở `task/<id>` suốt vòng review. Prompt ghi tên branch + SHA và lệnh xem diff: `git diff --stat dev...task/<id>`, `git diff dev...task/<id> -- <file>`, và ở vòng review lại thêm `PREV` (`git diff PREV..task/<id>`). Không dán diff vào prompt.
- **Kỷ luật reviewer:** chỉ đọc, không sửa file, không commit; mục tiêu là **tìm lỗi**, không xác nhận cho qua. Đọc code xung quanh và consumer trực tiếp; tìm lỗi theo 5 dạng trên và đối chiếu tiêu chí nghiệm thu.
- **Không chạy lệnh nặng** (hai reviewer chạy song song trên cùng máy): chỉ đọc file thuộc diff và nơi gọi trực tiếp; không grep cả repo; không chạy cả bộ test hay tác vụ nặng; chỉ chạy test liên quan với dữ liệu nhỏ theo [README.md](../../README.md). Ghi rõ lệnh đã chạy và giới hạn.
- **Format finding:** mức độ, `file:dòng`, tình huống gây lỗi, tác động, yêu cầu sửa và **ca tái hiện** (lệnh hoặc đoạn test nhỏ) để dựng regression test. Chưa có ca tái hiện thì ghi rõ là nghi vấn.
- **Prompt mỗi vòng phải tự đủ:** mỗi lần gọi là phiên mới (không dựa vào resume); prompt ghi diff hiện tại, danh sách finding vòng trước, cách Claude xử lý (sửa + test, hoặc bác + bằng chứng) và trỏ tới `docs/progress/done/<module>/<id>.md`.
- **Phản biện & regression test:** Claude phản biện và kiểm thử **mọi** finding (kể cả khi hai reviewer cùng nêu). Finding được công nhận phải sửa nguyên nhân và **để lại regression test trong `tests/`** dựng từ ca tái hiện (fail trước khi sửa, pass sau khi sửa). Chỉ miễn khi không tự động hoá được (môi trường ngoài, phần cứng thật, UI thủ công hoặc docs — ghi lý do và cách kiểm tay). Finding bị bác ghi bằng chứng vào docs, không cần giữ test.
- **Vòng review lại (= verify):** gọi lại GPT và Gemini kiểm từng finding đã sửa (test tái hiện có trong `tests/`, pass, sửa đúng nguyên nhân) và từng finding bị bác (đủ bằng chứng chưa), kèm soát diff bản sửa có gây lỗi mới không. Kết luận rõ: còn hay hết finding mở.
- **Giới hạn 3 vòng** (vòng đầu + 2 vòng review lại): không gọi vòng 4. Nhận feedback vòng 3 thì sửa finding quan trọng (P1, hoặc làm hỏng dữ liệu/output) kèm test; finding nhẹ thì đề xuất cách xử lý cho từng cái rồi báo user chốt trước khi đóng/merge.

## 5. Đóng ticket & cập nhật docs

- **Điều kiện đóng (hoàn tất):** đủ tiêu chí nghiệm thu (hoặc user chốt lại phạm vi), mọi finding đã sửa có test hoặc đã bác có bằng chứng, test liên quan pass, và **vòng review lại không còn finding mở** (hoặc user chấp nhận phần còn lại). Ghi riêng rủi ro, phần hoãn và tiêu chí chưa kiểm được vì thiếu môi trường; thiếu điều kiện thì giữ ticket mở.
- **Cập nhật docs:** ghi implementation, quyết định, lệnh đã chạy, kết quả, giới hạn và bằng chứng review vào `docs/progress/done/<module>/<id>.md`; cập nhật `done/<module>/README.md` (và `done/README.md` nếu module mới); xoá ticket ở `undone/<module>/<id>.md` (cập nhật các `README.md` index liên quan) và cập nhật [docs/progress/README.md](../progress/README.md).
- **Domain model:** cập nhật thuật ngữ vào [docs/glossary.md](../glossary.md) (không nhồi chi tiết implementation); chỉ tạo ADR trong [docs/adr/](../adr/README.md) khi thỏa cả 3 điều kiện (khó đảo ngược, thiếu ngữ cảnh sẽ khó hiểu, và là trade-off thật).
- Khi đóng xong mới `git merge --no-ff task/<id>` vào `dev` và xoá branch theo [git-workflow.md](git-workflow.md).
