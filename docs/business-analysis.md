<!-- nghiệp vụ của hệ thống. -->


# 02 - Phân tích nghiệp vụ hệ thống

## 1. Tổng quan hệ thống

Dự án Web quản lý Câu lạc bộ Sinh viên là hệ thống hỗ trợ nhà trường và các câu lạc bộ quản lý thông tin CLB, thành viên, sự kiện, đăng ký tham gia, điểm danh và thống kê hoạt động.

Hệ thống không chỉ là website giới thiệu CLB, mà là một nền tảng quản lý vòng đời hoạt động CLB sinh viên, từ đăng ký tham gia, duyệt thành viên, tạo sự kiện, đăng ký sự kiện, điểm danh đến thống kê.

## 2. Mục tiêu hệ thống

Hệ thống cần đạt các mục tiêu chính:

- Quản lý danh sách câu lạc bộ trong trường.
- Quản lý thông tin thành viên của từng CLB.
- Quản lý vai trò của người dùng trong từng CLB.
- Quản lý sự kiện do CLB tổ chức.
- Cho phép sinh viên đăng ký tham gia sự kiện.
- Hỗ trợ điểm danh sự kiện.
- Thống kê hoạt động của CLB, sự kiện và thành viên.

## 3. Vai trò người dùng

Hệ thống có 4 nhóm vai trò chính:

### 3.1. Admin

Admin là người quản lý toàn bộ hệ thống.

Quyền chính:

- Quản lý tất cả người dùng.
- Quản lý tất cả CLB.
- Duyệt hoặc khóa CLB.
- Xem toàn bộ danh sách thành viên.
- Quản lý tất cả sự kiện.
- Xem thống kê toàn hệ thống.

### 3.2. Chủ nhiệm CLB

Chủ nhiệm CLB là người quản lý một CLB cụ thể.

Quyền chính:

- Cập nhật thông tin CLB của mình.
- Xem danh sách thành viên trong CLB.
- Duyệt yêu cầu tham gia CLB.
- Gán vai trò thành viên trong CLB.
- Tạo và quản lý sự kiện của CLB.
- Xem thống kê hoạt động của CLB.

### 3.3. Ban điều hành

Ban điều hành là người hỗ trợ vận hành CLB.

Quyền chính:

- Xem danh sách thành viên trong CLB.
- Hỗ trợ quản lý sự kiện.
- Hỗ trợ điểm danh sự kiện.
- Xem một số thống kê cơ bản của CLB.
- Không được xóa CLB.
- Không được thay đổi quyền của Chủ nhiệm CLB.

### 3.4. Thành viên

Thành viên là sinh viên tham gia CLB hoặc sự kiện.

Quyền chính:

- Xem danh sách CLB.
- Gửi yêu cầu tham gia CLB.
- Xem thông tin sự kiện.
- Đăng ký tham gia sự kiện.
- Hủy đăng ký sự kiện.
- Xem lịch sử tham gia của bản thân.

## 4. Nguyên tắc phân quyền quan trọng

Không lưu vai trò CLB trực tiếp trong bảng users.

Lý do:

Một sinh viên có thể có nhiều vai trò khác nhau ở nhiều CLB khác nhau.

Ví dụ:

- Sinh viên A là thành viên CLB IT.
- Sinh viên A là Ban điều hành CLB Tiếng Nhật.
- Sinh viên A là Chủ nhiệm CLB Truyền thông.

Vì vậy, vai trò của người dùng trong từng CLB phải được lưu ở bảng trung gian club_members.

## 5. Bảng phân quyền tổng quát

| Chức năng | Admin | Chủ nhiệm CLB | Ban điều hành | Thành viên |
|---|---|---|---|---|
| Xem danh sách CLB | Có | Có | Có | Có |
| Tạo CLB | Có | Không | Không | Không |
| Duyệt CLB | Có | Không | Không | Không |
| Sửa thông tin CLB | Có | CLB của mình | Không hoặc giới hạn | Không |
| Khóa CLB | Có | Không | Không | Không |
| Xem danh sách thành viên | Có | CLB của mình | CLB của mình | Giới hạn |
| Duyệt thành viên | Có | CLB của mình | Có thể được phân quyền | Không |
| Gán vai trò thành viên | Có | CLB của mình | Không | Không |
| Tạo sự kiện | Có | CLB của mình | Có thể được phân quyền | Không |
| Quản lý sự kiện | Có | CLB của mình | Có thể được phân quyền | Không |
| Đăng ký sự kiện | Có | Có | Có | Có |
| Hủy đăng ký sự kiện | Có | Có | Có | Có |
| Điểm danh | Có | Có | Có | Không hoặc tự check-in |
| Xem thống kê toàn hệ thống | Có | Không | Không | Không |
| Xem thống kê CLB | Có | CLB của mình | Giới hạn | Không |
| Xem lịch sử cá nhân | Có | Có | Có | Có |

## 6. Danh sách nghiệp vụ chính

Hệ thống có các nghiệp vụ chính:

1. Quản lý tài khoản.
2. Quản lý CLB.
3. Quản lý thành viên CLB.
4. Quản lý sự kiện.
5. Đăng ký sự kiện.
6. Điểm danh sự kiện.
7. Thống kê hoạt động.

## 7. Nghiệp vụ quản lý tài khoản

### Mục đích

Cho phép người dùng đăng ký, đăng nhập và sử dụng hệ thống theo đúng quyền.

### Người sử dụng

- Admin
- Chủ nhiệm CLB
- Ban điều hành
- Thành viên

### Dữ liệu cần lưu

- Họ tên
- Email
- Mật khẩu đã mã hóa
- Mã số sinh viên
- Số điện thoại
- Khoa hoặc viện
- Lớp
- Ảnh đại diện
- Trạng thái tài khoản

### Luồng xử lý chính

1. Người dùng đăng ký tài khoản.
2. Người dùng đăng nhập vào hệ thống.
3. Hệ thống xác thực tài khoản.
4. Hệ thống kiểm tra quyền của người dùng.
5. Người dùng được truy cập chức năng phù hợp.

### Kết quả cần đạt

Hệ thống xác định được người dùng là ai, có quyền gì trong toàn hệ thống và đang thuộc những CLB nào.

## 8. Nghiệp vụ quản lý CLB

### Mục đích

Quản lý thông tin chính thức của các CLB trong trường.

### Người sử dụng

- Admin
- Chủ nhiệm CLB

### Dữ liệu cần lưu

- Tên CLB
- Mô tả CLB
- Logo
- Ảnh bìa
- Lĩnh vực hoạt động
- Ngày thành lập
- Email liên hệ
- Fanpage
- Trạng thái hoạt động

### Luồng xử lý chính

1. Admin tạo CLB.
2. Admin gán Chủ nhiệm CLB.
3. Chủ nhiệm CLB cập nhật thông tin CLB.
4. Sinh viên xem thông tin CLB.
5. Admin có thể khóa hoặc tạm ngưng CLB nếu cần.

### Kết quả cần đạt

Hệ thống có danh sách CLB chính thức, rõ ràng và dễ quản lý.

## 9. Nghiệp vụ quản lý thành viên CLB

### Mục đích

Quản lý quá trình sinh viên tham gia CLB, được duyệt, giữ vai trò, rời CLB hoặc bị xóa khỏi CLB.

### Người sử dụng

- Admin
- Chủ nhiệm CLB
- Ban điều hành
- Thành viên

### Dữ liệu cần lưu

- Người dùng nào
- Thuộc CLB nào
- Vai trò trong CLB
- Trạng thái thành viên
- Ngày tham gia
- Người duyệt
- Thời gian duyệt

### Luồng đăng ký tham gia CLB

1. Sinh viên xem danh sách CLB.
2. Sinh viên chọn CLB muốn tham gia.
3. Sinh viên gửi yêu cầu tham gia.
4. Hệ thống tạo bản ghi thành viên với trạng thái pending.
5. Chủ nhiệm CLB xem danh sách chờ duyệt.
6. Chủ nhiệm duyệt hoặc từ chối.
7. Nếu duyệt, trạng thái chuyển thành approved.
8. Nếu từ chối, trạng thái chuyển thành rejected.

### Kết quả cần đạt

Hệ thống biết mỗi CLB có những thành viên nào, ai là Chủ nhiệm, ai là Ban điều hành và ai là Thành viên.

## 10. Nghiệp vụ quản lý sự kiện

### Mục đích

Cho phép CLB tạo và quản lý các sự kiện.

### Người sử dụng

- Admin
- Chủ nhiệm CLB
- Ban điều hành nếu được phân quyền

### Dữ liệu cần lưu

- CLB tổ chức
- Tên sự kiện
- Mô tả
- Địa điểm
- Thời gian bắt đầu
- Thời gian kết thúc
- Số lượng tối đa
- Thời gian mở đăng ký
- Thời gian đóng đăng ký
- Trạng thái sự kiện
- Người tạo

### Luồng xử lý chính

1. Chủ nhiệm hoặc Ban điều hành tạo sự kiện.
2. Sự kiện được lưu ở trạng thái draft hoặc pending.
3. Người có quyền duyệt sự kiện.
4. Khi được duyệt, sự kiện chuyển sang published.
5. Sinh viên có thể xem và đăng ký.
6. Sau khi sự kiện kết thúc, trạng thái chuyển sang completed.

### Kết quả cần đạt

Hệ thống biết sự kiện nào thuộc CLB nào, khi nào diễn ra, ai tạo và trạng thái hiện tại là gì.

## 11. Nghiệp vụ đăng ký sự kiện

### Mục đích

Ghi nhận sinh viên nào muốn tham gia sự kiện.

### Người sử dụng

- Thành viên
- Ban điều hành
- Chủ nhiệm CLB
- Admin

### Dữ liệu cần lưu

- Sự kiện
- Người đăng ký
- Trạng thái đăng ký
- Thời gian đăng ký
- Thời gian hủy
- Người duyệt nếu sự kiện yêu cầu duyệt

### Luồng xử lý chính

1. Sinh viên xem danh sách sự kiện.
2. Sinh viên chọn sự kiện muốn tham gia.
3. Hệ thống kiểm tra:
   - Sự kiện đã công khai chưa.
   - Có còn trong thời gian đăng ký không.
   - Có còn chỗ trống không.
   - Sinh viên đã đăng ký trước đó chưa.
4. Nếu hợp lệ, hệ thống tạo bản ghi đăng ký.
5. Nếu sự kiện cần duyệt, trạng thái là pending.
6. Nếu không cần duyệt, trạng thái là registered.
7. Sinh viên có thể hủy đăng ký trước thời hạn.

### Kết quả cần đạt

Hệ thống biết ai đã đăng ký sự kiện, ai đã hủy, ai đang chờ duyệt và sự kiện còn bao nhiêu chỗ.

## 12. Nghiệp vụ điểm danh sự kiện

### Mục đích

Ghi nhận ai đã tham gia sự kiện thực tế.

### Người sử dụng

- Admin
- Chủ nhiệm CLB
- Ban điều hành
- Thành viên nếu hệ thống cho phép tự check-in QR

### Dữ liệu cần lưu

- Sự kiện
- Người được điểm danh
- Trạng thái điểm danh
- Phương thức điểm danh
- Thời gian check-in
- Người điểm danh
- Ghi chú

### Luồng xử lý chính

1. Sự kiện bắt đầu.
2. Ban điều hành mở điểm danh.
3. Thành viên check-in bằng QR hoặc được điểm danh thủ công.
4. Hệ thống tạo hoặc cập nhật bản ghi điểm danh.
5. Sau sự kiện, hệ thống thống kê số người có mặt, vắng, trễ.

### Kết quả cần đạt

Hệ thống phân biệt được người đăng ký và người tham gia thực tế.

## 13. Nghiệp vụ thống kê hoạt động

### Mục đích

Cung cấp số liệu cho Admin và Chủ nhiệm CLB để đánh giá hoạt động.

### Người sử dụng

- Admin
- Chủ nhiệm CLB
- Ban điều hành nếu được phân quyền

### Chỉ số thống kê cần có

- Tổng số CLB.
- Số CLB đang hoạt động.
- Tổng số thành viên.
- Số thành viên theo từng CLB.
- Số thành viên đang chờ duyệt.
- Tổng số sự kiện.
- Số sự kiện đã tổ chức.
- Số người đăng ký sự kiện.
- Số người tham gia thực tế.
- Tỷ lệ tham gia thực tế.
- Lịch sử tham gia của từng sinh viên.

### Kết quả cần đạt

Admin có dashboard toàn hệ thống. Chủ nhiệm CLB có dashboard riêng của CLB mình.

## 14. Quy tắc nghiệp vụ quan trọng

### Quy tắc 1

Một user có thể tham gia nhiều CLB.

### Quy tắc 2

Một user có thể có vai trò khác nhau ở từng CLB.

### Quy tắc 3

Một CLB có nhiều thành viên.

### Quy tắc 4

Một CLB có nhiều sự kiện.

### Quy tắc 5

Một sự kiện thuộc về một CLB.

### Quy tắc 6

Đăng ký sự kiện và điểm danh sự kiện là hai nghiệp vụ khác nhau.

### Quy tắc 7

Một user không được đăng ký trùng một sự kiện nhiều lần.

### Quy tắc 8

Một user không được có nhiều bản ghi thành viên trùng trong cùng một CLB.

### Quy tắc 9

Chỉ người có quyền trong CLB mới được duyệt thành viên hoặc điểm danh.

### Quy tắc 10

Thống kê hoạt động phải dựa trên dữ liệu đăng ký và điểm danh thực tế.