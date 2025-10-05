# Export dữ liệu lớn thành file Excel (\*.xlsx)

Nhiều hệ thống cần export dữ liệu lớn (hàng triệu dòng) thành file Excel để phục vụ nhu cầu báo cáo, phân tích dữ liệu. Vấn đề phát sinh sau khi VCBInvoice áp dụng nghị định 70/2023/NĐ-CP về hoá đơn điện tử.

## Vấn đề của Export dữ liệu lớn?

- Thời gian xử lý lâu (Chờ nhận response từ server khi export):

  - Quá trình tạo file có thể mất từ vài phút đến hàng chục phút. Dẫn đến request timeout và trải nghiệm người dùng kém.

- Không tái sử dụng được file đã tạo nếu người dùng có nhu cầu tải lại file.

- Giới hạn của file Excel:

  - Giới hạn số dòng (1.048.576 cho file Excel).
  - Không thể mở được file với máy có cấu hình thấp.

- Tài nguyên hệ thống:
  - RAM: Có thể chiếm hàng GB RAM nếu export hàng triệu dòng dữ liệu.
  - CPU: Quá trình tạo file có thể làm CPU tăng cao, ảnh hưởng đến hiệu năng hệ thống.
  - Ổ cứng: Lưu trữ file tạm thời trong quá trình tạo file.
  - Ảnh hưởng đến các services trên cùng server (nếu có).

## Khắc phục vấn đề Export dữ liệu lớn

- Sử dụng cơ chế xử lý bất đồng bộ (Asynchronous):

  - Sử dụng Job.
  - Sử dụng Queue.
  - Gửi email thông báo khi file đã sẵn sàng để tải về. Đính kèm link tải file (Có cấu hình thời gian tồn tại của file).

- Lưu trữ file tạm thời trên, S3, MinIO.

- Chia nhỏ dữ liệu thành các phần (chunk/batch) nhỏ hơn

  - Mỗi phần có thể chứa 10.000 - 100.000 dòng tuỳ theo cấu hình server.
  - Tạo file Excel cho từng chunk/batch.

- Tài nguyên hệ thống:
  - Tối ưu truy vấn DB. Chạy explan để kiểm tra cost của câu truy vấn.
  - Sử dụng Stream để lấy dữ liệu từ DB thay vì lấy toàn bộ dữ liệu vào RAM.
  - Chia nhỏ dữ liệu thành các phần (chunk/batch) nhỏ hơn.
  - Set thời gian timeout hợp lý khi truy vấn DB. Trách việc chiếm connection pool quá lâu.
  - Sử dụng Stream để ghi dữ liệu vào file. Và lựa chọn các thưc viện có hỗ trợ ghi file theo dạng stream.
    - OpenXml SDK (.NET Core).
    - Apache POI (Java) => Copilot gợi ý 😅.
    - Pandas (Python).
  - Nén file Excel (zip) để giảm dung lượng lưu trữ trước khi lưu trữ và gửi email.
  - Tối ưu hàm upload file lên S3, MinIO. Kiểm tra xem có load toàn bộ file vào RAM lưu trữ dạng byte[] trước khi upload lên MinIO không?
  - Tách service export ra một server riêng biệt. Tránh ảnh hường đến các services khác.
  - Xoá file tạm thời sau khi upload lên S3, MinIO thành công.
