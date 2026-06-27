# 03. Danh sách API

## Mục đích

File này dùng để ghi lại toàn bộ API cần có cho hệ thống Web Quản lí Câu lạc bộ Sinh viên.

API là cầu nối giữa frontend, backend và database.

Ví dụ:
Khi người dùng bấm nút đăng nhập trên giao diện, frontend sẽ gọi API đăng nhập ở backend.
Backend kiểm tra dữ liệu trong database rồi trả kết quả lại cho frontend.

Việc viết danh sách API trước giúp:

- Biết backend cần code những chức năng nào.
- Biết frontend cần gọi endpoint nào.
- Tránh làm thiếu chức năng.
- Dễ test bằng Postman sau này.

---

# 1. Auth API

Auth API dùng cho đăng ký, đăng nhập và lấy thông tin người dùng hiện tại.

## POST /api/auth/register

Mục đích:
Cho phép người dùng đăng ký tài khoản.

Quyền truy cập:
Public, không cần đăng nhập.

Request body:

```json
{
  "full_name": "Nguyen Van A",
  "email": "vana@example.com",
  "password": "123456",
  "student_code": "22110001",
  "phone": "0900000000",
  "class_name": "22DTHA1",
  "major": "Công nghệ thông tin"
}
Response:
{
  "message": "Register successfully"
}
Database liên quan:
users
POST /api/auth/login
Mục đích:
Cho phép người dùng đăng nhập và nhận token.
Quyền truy cập:
Public, không cần đăng nhập.
Request body:
{
  "email": "vana@example.com",
  "password": "123456"
}
Response:
{
  "message": "Login successfully",
  "token": "jwt_token_here",
  "user": {
    "id": 1,
    "full_name": "Nguyen Van A",
    "email": "vana@example.com",
    "system_role": "user"
  }
}
Database liên quan:
users
GET /api/auth/me
Mục đích:
Lấy thông tin người dùng hiện tại dựa trên token.
Quyền truy cập:
Người dùng đã đăng nhập.
Header:
Authorization: Bearer jwt_token_here
Response:
{
  "id": 1,
  "full_name": "Nguyen Van A",
  "email": "vana@example.com",
  "system_role": "user"
}
Database liên quan:
users
2. Club API
Club API dùng để quản lí câu lạc bộ.
GET /api/clubs
Mục đích:
Lấy danh sách tất cả câu lạc bộ.
Quyền truy cập:
Người dùng đã đăng nhập.
Response:
[
  {
    "id": 1,
    "name": "CLB Tin học",
    "category": "Học thuật",
    "status": "active"
  }
]
Database liên quan:
clubs
POST /api/clubs
Mục đích:
Tạo câu lạc bộ mới.
Quyền truy cập:
Admin.
Request body:
{
  "name": "CLB Tin học",
  "description": "Câu lạc bộ dành cho sinh viên yêu thích công nghệ",
  "logo_url": "https://example.com/logo.png",
  "category": "Học thuật",
  "founded_date": "2024-01-01",
  "status": "active"
}
Response:
{
  "message": "Club created successfully",
  "club_id": 1
}
Database liên quan:
clubs
GET /api/clubs/:id
Mục đích:
Lấy thông tin chi tiết của một câu lạc bộ.
Quyền truy cập:
Người dùng đã đăng nhập.
Response:
{
  "id": 1,
  "name": "CLB Tin học",
  "description": "Câu lạc bộ dành cho sinh viên yêu thích công nghệ",
  "logo_url": "https://example.com/logo.png",
  "category": "Học thuật",
  "founded_date": "2024-01-01",
  "status": "active"
}
Database liên quan:
clubs
PUT /api/clubs/:id
Mục đích:
Cập nhật thông tin câu lạc bộ.
Quyền truy cập:
Admin hoặc Chủ nhiệm CLB.
Request body:
{
  "name": "CLB Công nghệ thông tin",
  "description": "Nội dung mô tả mới",
  "logo_url": "https://example.com/new-logo.png",
  "category": "Học thuật",
  "status": "active"
}
Response:
{
  "message": "Club updated successfully"
}
Database liên quan:
clubs
club_members
DELETE /api/clubs/:id
Mục đích:
Xóa hoặc đổi trạng thái câu lạc bộ.
Quyền truy cập:
Admin.
Response:
{
  "message": "Club deleted successfully"
}
Database liên quan:
clubs
3. Club Member API
Club Member API dùng để quản lí thành viên trong từng câu lạc bộ.
GET /api/clubs/:clubId/members
Mục đích:
Lấy danh sách thành viên của một CLB.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Response:
[
  {
    "member_id": 1,
    "user_id": 2,
    "full_name": "Nguyen Van B",
    "email": "vanb@example.com",
    "student_code": "22110002",
    "club_role": "member",
    "status": "active"
  }
]
Database liên quan:
users
club_members
clubs
POST /api/clubs/:clubId/members
Mục đích:
Thêm một user vào CLB.
Quyền truy cập:
Admin hoặc Chủ nhiệm CLB.
Request body:
{
  "user_id": 2,
  "club_role": "member",
  "status": "active"
}
Response:
{
  "message": "Member added successfully"
}
Database liên quan:
users
clubs
club_members
PUT /api/clubs/:clubId/members/:memberId
Mục đích:
Cập nhật vai trò hoặc trạng thái thành viên trong CLB.
Quyền truy cập:
Admin hoặc Chủ nhiệm CLB.
Request body:
{
  "club_role": "executive",
  "status": "active"
}
Response:
{
  "message": "Member updated successfully"
}
Database liên quan:
club_members
DELETE /api/clubs/:clubId/members/:memberId
Mục đích:
Xóa hoặc cho thành viên rời CLB.
Quyền truy cập:
Admin hoặc Chủ nhiệm CLB.
Response:
{
  "message": "Member removed successfully"
}
Database liên quan:
club_members
4. Event API
Event API dùng để quản lí sự kiện.
GET /api/events
Mục đích:
Lấy danh sách sự kiện.
Quyền truy cập:
Người dùng đã đăng nhập.
Response:
[
  {
    "id": 1,
    "title": "Workshop ReactJS",
    "club_id": 1,
    "location": "Phòng B-10.12",
    "start_time": "2026-07-01 08:00:00",
    "status": "upcoming"
  }
]
Database liên quan:
events
clubs
POST /api/events
Mục đích:
Tạo sự kiện mới.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Request body:
{
  "club_id": 1,
  "title": "Workshop ReactJS",
  "description": "Buổi chia sẻ kiến thức ReactJS cơ bản",
  "start_time": "2026-07-01 08:00:00",
  "end_time": "2026-07-01 11:00:00",
  "location": "Phòng B-10.12",
  "max_participants": 100,
  "status": "upcoming"
}
Response:
{
  "message": "Event created successfully",
  "event_id": 1
}
Database liên quan:
events
clubs
club_members
GET /api/events/:id
Mục đích:
Lấy chi tiết một sự kiện.
Quyền truy cập:
Người dùng đã đăng nhập.
Response:
{
  "id": 1,
  "club_id": 1,
  "club_name": "CLB Tin học",
  "title": "Workshop ReactJS",
  "description": "Buổi chia sẻ kiến thức ReactJS cơ bản",
  "start_time": "2026-07-01 08:00:00",
  "end_time": "2026-07-01 11:00:00",
  "location": "Phòng B-10.12",
  "max_participants": 100,
  "status": "upcoming"
}
Database liên quan:
events
clubs
PUT /api/events/:id
Mục đích:
Cập nhật thông tin sự kiện.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Request body:
{
  "title": "Workshop ReactJS nâng cao",
  "description": "Nội dung mới",
  "start_time": "2026-07-01 08:00:00",
  "end_time": "2026-07-01 11:30:00",
  "location": "Phòng B-10.12",
  "max_participants": 120,
  "status": "upcoming"
}
Response:
{
  "message": "Event updated successfully"
}
Database liên quan:
events
club_members
DELETE /api/events/:id
Mục đích:
Xóa hoặc hủy sự kiện.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Response:
{
  "message": "Event deleted successfully"
}
Database liên quan:
events
GET /api/clubs/:clubId/events
Mục đích:
Lấy danh sách sự kiện thuộc một CLB.
Quyền truy cập:
Người dùng đã đăng nhập.
Response:
[
  {
    "id": 1,
    "title": "Workshop ReactJS",
    "start_time": "2026-07-01 08:00:00",
    "location": "Phòng B-10.12",
    "status": "upcoming"
  }
]
Database liên quan:
events
clubs
5. Event Registration API
Event Registration API dùng để đăng ký tham gia sự kiện.
POST /api/events/:eventId/register
Mục đích:
Cho thành viên đăng ký tham gia sự kiện.
Quyền truy cập:
Thành viên đã đăng nhập và thuộc CLB tổ chức sự kiện.
Response:
{
  "message": "Registered successfully"
}
Database liên quan:
event_registrations
events
club_members
DELETE /api/events/:eventId/register
Mục đích:
Cho thành viên hủy đăng ký sự kiện.
Quyền truy cập:
Thành viên đã đăng nhập.
Response:
{
  "message": "Registration cancelled successfully"
}
Database liên quan:
event_registrations
events
GET /api/events/:eventId/registrations
Mục đích:
Lấy danh sách người đã đăng ký sự kiện.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Response:
[
  {
    "registration_id": 1,
    "user_id": 2,
    "full_name": "Nguyen Van B",
    "student_code": "22110002",
    "email": "vanb@example.com",
    "status": "registered",
    "registered_at": "2026-06-27 09:00:00"
  }
]
Database liên quan:
event_registrations
users
events
6. Attendance API
Attendance API dùng để điểm danh sự kiện.
GET /api/events/:eventId/attendance
Mục đích:
Lấy danh sách điểm danh của sự kiện.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Response:
[
  {
    "user_id": 2,
    "full_name": "Nguyen Van B",
    "student_code": "22110002",
    "attendance_status": "present",
    "checked_at": "2026-07-01 08:30:00"
  }
]
Database liên quan:
attendance
users
events
POST /api/events/:eventId/attendance
Mục đích:
Tạo hoặc lưu kết quả điểm danh cho nhiều thành viên.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Request body:
{
  "attendance": [
    {
      "user_id": 2,
      "status": "present"
    },
    {
      "user_id": 3,
      "status": "absent"
    }
  ]
}
Response:
{
  "message": "Attendance saved successfully"
}
Database liên quan:
attendance
event_registrations
users
PUT /api/events/:eventId/attendance/:userId
Mục đích:
Cập nhật trạng thái điểm danh của một thành viên.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Request body:
{
  "status": "present"
}
Response:
{
  "message": "Attendance updated successfully"
}
Database liên quan:
attendance

7. Statistics API
Statistics API dùng để thống kê dữ liệu.
GET /api/statistics/overview
Mục đích:
Lấy thống kê tổng quan toàn hệ thống.
Quyền truy cập:
Admin.
Response:
{
  "total_clubs": 10,
  "total_members": 250,
  "total_events": 35,
  "total_registrations": 800
}
Database liên quan:
clubs
users
club_members
events
event_registrations
GET /api/statistics/clubs/:clubId
Mục đích:
Lấy thống kê của một CLB.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Response:
{
  "club_id": 1,
  "total_members": 50,
  "total_events": 8,
  "total_registrations": 200,
  "attendance_rate": 85
}
Database liên quan:
clubs
club_members
events
event_registrations
attendance
GET /api/statistics/events/:eventId
Mục đích:
Lấy thống kê của một sự kiện.
Quyền truy cập:
Admin, Chủ nhiệm CLB, Ban điều hành CLB.
Response:
{
  "event_id": 1,
  "total_registrations": 80,
  "total_present": 70,
  "total_absent": 10,
  "attendance_rate": 87.5
}
Database liên quan:
events
event_registrations
attendance
```
