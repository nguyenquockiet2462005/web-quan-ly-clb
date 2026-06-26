<!-- mô tả thiết kế database. mô tả thiết kế database. -->

# 02 - Database Design

## 1. Tổng quan thiết kế database

Database của hệ thống Web quản lý Câu lạc bộ Sinh viên được thiết kế để quản lý:

- Người dùng
- Câu lạc bộ
- Thành viên trong CLB
- Sự kiện
- Đăng ký sự kiện
- Điểm danh
- Thông báo
- Lịch sử hoạt động

Database MVP gồm 6 bảng bắt buộc:

- users
- clubs
- club_members
- events
- event_registrations
- attendances

Có thể mở rộng thêm 2 bảng:

- notifications
- activity_logs

## 2. Nguyên tắc thiết kế

### 2.1. Không lưu role CLB trực tiếp trong users

Một user có thể có nhiều vai trò ở nhiều CLB khác nhau. Vì vậy, vai trò trong CLB được lưu ở bảng club_members.

### 2.2. Tách đăng ký sự kiện và điểm danh

Đăng ký sự kiện thể hiện người dùng muốn tham gia. Điểm danh thể hiện người dùng đã tham gia thực tế.

Vì vậy, cần tách thành 2 bảng:

- event_registrations
- attendances

### 2.3. Các bảng quan trọng cần có status

Status giúp hệ thống xử lý các trạng thái thực tế như chờ duyệt, đã duyệt, bị từ chối, đã hủy, hoàn tất.

### 2.4. Cần có khóa chính và khóa ngoại rõ ràng

Khóa chính dùng để định danh bản ghi. Khóa ngoại dùng để liên kết dữ liệu giữa các bảng.

## 3. Bảng users

### 3.1. Mục đích

Lưu thông tin tài khoản người dùng.

### 3.2. Cấu trúc bảng

| Cột           | Kiểu dữ liệu gợi ý | Ràng buộc        | Ý nghĩa              |
| ------------- | ------------------ | ---------------- | -------------------- |
| id            | BIGINT hoặc UUID   | Primary Key      | Mã người dùng        |
| full_name     | VARCHAR(255)       | NOT NULL         | Họ tên               |
| email         | VARCHAR(255)       | UNIQUE, NOT NULL | Email đăng nhập      |
| password_hash | VARCHAR(255)       | NOT NULL         | Mật khẩu đã mã hóa   |
| student_code  | VARCHAR(50)        | UNIQUE, NULL     | Mã số sinh viên      |
| phone         | VARCHAR(20)        | NULL             | Số điện thoại        |
| avatar_url    | VARCHAR(500)       | NULL             | Ảnh đại diện         |
| faculty       | VARCHAR(255)       | NULL             | Khoa hoặc viện       |
| class_name    | VARCHAR(100)       | NULL             | Lớp                  |
| system_role   | ENUM               | DEFAULT student  | Quyền toàn hệ thống  |
| status        | ENUM               | DEFAULT active   | Trạng thái tài khoản |
| created_at    | DATETIME           | NOT NULL         | Ngày tạo             |
| updated_at    | DATETIME           | NOT NULL         | Ngày cập nhật        |

### 3.3. Giá trị enum

system_role:

- admin
- student

status:

- active
- inactive
- banned

### 3.4. Ghi chú

system_role chỉ dùng để phân quyền toàn hệ thống.

Vai trò trong từng CLB không lưu ở bảng users mà lưu ở bảng club_members.

## 4. Bảng clubs

### 4.1. Mục đích

Lưu thông tin câu lạc bộ.

### 4.2. Cấu trúc bảng

| Cột           | Kiểu dữ liệu gợi ý | Ràng buộc        | Ý nghĩa              |
| ------------- | ------------------ | ---------------- | -------------------- |
| id            | BIGINT hoặc UUID   | Primary Key      | Mã CLB               |
| name          | VARCHAR(255)       | NOT NULL         | Tên CLB              |
| slug          | VARCHAR(255)       | UNIQUE, NOT NULL | Đường dẫn thân thiện |
| description   | TEXT               | NULL             | Mô tả CLB            |
| logo_url      | VARCHAR(500)       | NULL             | Logo                 |
| cover_url     | VARCHAR(500)       | NULL             | Ảnh bìa              |
| category      | VARCHAR(100)       | NULL             | Lĩnh vực hoạt động   |
| founded_date  | DATE               | NULL             | Ngày thành lập       |
| contact_email | VARCHAR(255)       | NULL             | Email liên hệ        |
| fanpage_url   | VARCHAR(500)       | NULL             | Link fanpage         |
| status        | ENUM               | DEFAULT pending  | Trạng thái CLB       |
| created_by    | BIGINT hoặc UUID   | Foreign Key      | Người tạo            |
| created_at    | DATETIME           | NOT NULL         | Ngày tạo             |
| updated_at    | DATETIME           | NOT NULL         | Ngày cập nhật        |

### 4.3. Giá trị enum

status:

- pending
- active
- inactive
- rejected

### 4.4. Khóa ngoại

created_by tham chiếu đến users.id.

### 4.5. Ghi chú

Mỗi CLB có thể có nhiều thành viên và nhiều sự kiện.

## 5. Bảng club_members

### 5.1. Mục đích

Lưu quan hệ giữa người dùng và CLB.

Đây là bảng quan trọng nhất trong hệ thống vì nó cho biết user thuộc CLB nào và giữ vai trò gì trong CLB đó.

### 5.2. Cấu trúc bảng

| Cột         | Kiểu dữ liệu gợi ý | Ràng buộc             | Ý nghĩa               |
| ----------- | ------------------ | --------------------- | --------------------- |
| id          | BIGINT hoặc UUID   | Primary Key           | Mã bản ghi            |
| user_id     | BIGINT hoặc UUID   | Foreign Key, NOT NULL | Thành viên            |
| club_id     | BIGINT hoặc UUID   | Foreign Key, NOT NULL | CLB                   |
| role        | ENUM               | NOT NULL              | Vai trò trong CLB     |
| status      | ENUM               | DEFAULT pending       | Trạng thái thành viên |
| joined_at   | DATETIME           | NULL                  | Ngày tham gia         |
| approved_by | BIGINT hoặc UUID   | Foreign Key, NULL     | Người duyệt           |
| approved_at | DATETIME           | NULL                  | Thời gian duyệt       |
| note        | TEXT               | NULL                  | Ghi chú               |
| created_at  | DATETIME           | NOT NULL              | Ngày tạo              |
| updated_at  | DATETIME           | NOT NULL              | Ngày cập nhật         |

### 5.3. Giá trị enum

role:

- club_manager
- executive
- member

status:

- pending
- approved
- rejected
- left
- removed

### 5.4. Khóa ngoại

- user_id tham chiếu đến users.id
- club_id tham chiếu đến clubs.id
- approved_by tham chiếu đến users.id

### 5.5. Ràng buộc unique

Một user không được có nhiều bản ghi trùng trong cùng một CLB.

Ràng buộc:

```text
unique(user_id, club_id)
```
