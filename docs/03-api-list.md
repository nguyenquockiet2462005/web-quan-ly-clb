# 03. Danh sách API

## Mục đích

File này dùng để ghi lại toàn bộ API cần có cho hệ thống Web Quản lí Câu lạc bộ Sinh viên.

API là cầu nối giữa frontend, backend và database.

Ví dụ: khi người dùng bấm nút đăng nhập trên giao diện, frontend sẽ gọi API đăng nhập ở backend. Backend kiểm tra dữ liệu trong database rồi trả kết quả lại cho frontend.

Việc viết danh sách API trước giúp:

- Biết backend cần code những chức năng nào.
- Biết frontend cần gọi endpoint nào.
- Tránh làm thiếu chức năng.
- Dễ test bằng Postman sau này.

---

# 1. Auth API

Auth API dùng cho đăng ký, đăng nhập và lấy thông tin người dùng hiện tại.

---

## 1.1. POST /api/auth/register

**Mục đích:**
Cho phép người dùng đăng ký tài khoản.

**Quyền truy cập:**
Public, không cần đăng nhập.

**Request body:**

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
```

**Response:**

```json
{
  "message": "Register successfully"
}
```

**Database liên quan:**

- users

---

## 1.2. POST /api/auth/login

**Mục đích:**
Cho phép người dùng đăng nhập và nhận token.

**Quyền truy cập:**
Public, không cần đăng nhập.

**Request body:**

```json
{
  "email": "vana@example.com",
  "password": "123456"
}
```

**Response:**

```json
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
```

**Database liên quan:**

- users

---

## 1.3. GET /api/auth/me

**Mục đích:**
Lấy thông tin người dùng hiện tại dựa trên token.

**Quyền truy cập:**
Người dùng đã đăng nhập.

**Header:**

```txt
Authorization: Bearer jwt_token_here
```

**Response:**

```json
{
  "id": 1,
  "full_name": "Nguyen Van A",
  "email": "vana@example.com",
  "system_role": "user"
}
```

**Database liên quan:**

- users

---

# 2. Club API

Club API dùng để quản lí câu lạc bộ.

---

## 2.1. GET /api/clubs

**Mục đích:**
Lấy danh sách tất cả câu lạc bộ.

**Quyền truy cập:**
Người dùng đã đăng nhập.

**Response:**

```json
[
  {
    "id": 1,
    "name": "CLB Tin học",
    "category": "Học thuật",
    "status": "active"
  }
]
```

**Database liên quan:**

- clubs

---

## 2.2. POST /api/clubs

**Mục đích:**
Tạo câu lạc bộ mới.

**Quyền truy cập:**
Admin.

**Request body:**

```json
{
  "name": "CLB Tin học",
  "description": "Câu lạc bộ dành cho sinh viên yêu thích công nghệ",
  "logo_url": "https://example.com/logo.png",
  "category": "Học thuật",
  "founded_date": "2024-01-01",
  "status": "active"
}
```

**Response:**

```json
{
  "message": "Club created successfully",
  "club_id": 1
}
```

**Database liên quan:**

- clubs

---

## 2.3. GET /api/clubs/:id

**Mục đích:**
Lấy thông tin chi tiết của một câu lạc bộ.

**Quyền truy cập:**
Người dùng đã đăng nhập.

**Response:**

```json
{
  "id": 1,
  "name": "CLB Tin học",
  "description": "Câu lạc bộ dành cho sinh viên yêu thích công nghệ",
  "logo_url": "https://example.com/logo.png",
  "category": "Học thuật",
  "founded_date": "2024-01-01",
  "status": "active"
}
```

**Database liên quan:**

- clubs

---

## 2.4. PUT /api/clubs/:id

**Mục đích:**
Cập nhật thông tin câu lạc bộ.

**Quyền truy cập:**
Admin hoặc Chủ nhiệm CLB.

**Request body:**

```json
{
  "name": "CLB Công nghệ thông tin",
  "description": "Nội dung mô tả mới",
  "logo_url": "https://example.com/new-logo.png",
  "category": "Học thuật",
  "status": "active"
}
```

**Response:**

```json
{
  "message": "Club updated successfully"
}
```

**Database liên quan:**

- clubs
- club_members

---

## 2.5. DELETE /api/clubs/:id

**Mục đích:**
Xóa hoặc đổi trạng thái câu lạc bộ.

**Quyền truy cập:**
Admin.

**Response:**

```json
{
  "message": "Club deleted successfully"
}
```

**Database liên quan:**

- clubs

---

# 3. Club Member API

Club Member API dùng để quản lí thành viên trong từng câu lạc bộ.

---

## 3.1. GET /api/clubs/:clubId/members

**Mục đích:**
Lấy danh sách thành viên của một CLB.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Response:**

```json
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
```

**Database liên quan:**

- users
- club_members
- clubs

---

## 3.2. POST /api/clubs/:clubId/members

**Mục đích:**
Thêm một user vào CLB.

**Quyền truy cập:**
Admin hoặc Chủ nhiệm CLB.

**Request body:**

```json
{
  "user_id": 2,
  "club_role": "member",
  "status": "active"
}
```

**Response:**

```json
{
  "message": "Member added successfully"
}
```

**Database liên quan:**

- users
- clubs
- club_members

---

## 3.3. PUT /api/clubs/:clubId/members/:memberId

**Mục đích:**
Cập nhật vai trò hoặc trạng thái thành viên trong CLB.

**Quyền truy cập:**
Admin hoặc Chủ nhiệm CLB.

**Request body:**

```json
{
  "club_role": "executive",
  "status": "active"
}
```

**Response:**

```json
{
  "message": "Member updated successfully"
}
```

**Database liên quan:**

- club_members

---

## 3.4. DELETE /api/clubs/:clubId/members/:memberId

**Mục đích:**
Xóa hoặc cho thành viên rời CLB.

**Quyền truy cập:**
Admin hoặc Chủ nhiệm CLB.

**Response:**

```json
{
  "message": "Member removed successfully"
}
```

**Database liên quan:**

- club_members

---

# 4. Event API

Event API dùng để quản lí sự kiện.

---

## 4.1. GET /api/events

**Mục đích:**
Lấy danh sách sự kiện.

**Quyền truy cập:**
Người dùng đã đăng nhập.

**Response:**

```json
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
```

**Database liên quan:**

- events
- clubs

---

## 4.2. POST /api/events

**Mục đích:**
Tạo sự kiện mới.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Request body:**

```json
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
```

**Response:**

```json
{
  "message": "Event created successfully",
  "event_id": 1
}
```

**Database liên quan:**

- events
- clubs
- club_members

---

## 4.3. GET /api/events/:id

**Mục đích:**
Lấy chi tiết một sự kiện.

**Quyền truy cập:**
Người dùng đã đăng nhập.

**Response:**

```json
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
```

**Database liên quan:**

- events
- clubs

---

## 4.4. PUT /api/events/:id

**Mục đích:**
Cập nhật thông tin sự kiện.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Request body:**

```json
{
  "title": "Workshop ReactJS nâng cao",
  "description": "Nội dung mới",
  "start_time": "2026-07-01 08:00:00",
  "end_time": "2026-07-01 11:30:00",
  "location": "Phòng B-10.12",
  "max_participants": 120,
  "status": "upcoming"
}
```

**Response:**

```json
{
  "message": "Event updated successfully"
}
```

**Database liên quan:**

- events
- club_members

---

## 4.5. DELETE /api/events/:id

**Mục đích:**
Xóa hoặc hủy sự kiện.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Response:**

```json
{
  "message": "Event deleted successfully"
}
```

**Database liên quan:**

- events

---

## 4.6. GET /api/clubs/:clubId/events

**Mục đích:**
Lấy danh sách sự kiện thuộc một CLB.

**Quyền truy cập:**
Người dùng đã đăng nhập.

**Response:**

```json
[
  {
    "id": 1,
    "title": "Workshop ReactJS",
    "start_time": "2026-07-01 08:00:00",
    "location": "Phòng B-10.12",
    "status": "upcoming"
  }
]
```

**Database liên quan:**

- events
- clubs

---

# 5. Event Registration API

Event Registration API dùng để đăng ký tham gia sự kiện.

---

## 5.1. POST /api/events/:eventId/register

**Mục đích:**
Cho thành viên đăng ký tham gia sự kiện.

**Quyền truy cập:**
Thành viên đã đăng nhập và thuộc CLB tổ chức sự kiện.

**Response:**

```json
{
  "message": "Registered successfully"
}
```

**Database liên quan:**

- event_registrations
- events
- club_members

---

## 5.2. DELETE /api/events/:eventId/register

**Mục đích:**
Cho thành viên hủy đăng ký sự kiện.

**Quyền truy cập:**
Thành viên đã đăng nhập.

**Response:**

```json
{
  "message": "Registration cancelled successfully"
}
```

**Database liên quan:**

- event_registrations
- events

---

## 5.3. GET /api/events/:eventId/registrations

**Mục đích:**
Lấy danh sách người đã đăng ký sự kiện.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Response:**

```json
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
```

**Database liên quan:**

- event_registrations
- users
- events

---

# 6. Attendance API

Attendance API dùng để điểm danh sự kiện.

---

## 6.1. GET /api/events/:eventId/attendance

**Mục đích:**
Lấy danh sách điểm danh của sự kiện.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Response:**

```json
[
  {
    "user_id": 2,
    "full_name": "Nguyen Van B",
    "student_code": "22110002",
    "attendance_status": "present",
    "checked_at": "2026-07-01 08:30:00"
  }
]
```

**Database liên quan:**

- attendance
- users
- events

---

## 6.2. POST /api/events/:eventId/attendance

**Mục đích:**
Tạo hoặc lưu kết quả điểm danh cho nhiều thành viên.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Request body:**

```json
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
```

**Response:**

```json
{
  "message": "Attendance saved successfully"
}
```

**Database liên quan:**

- attendance
- event_registrations
- users

---

## 6.3. PUT /api/events/:eventId/attendance/:userId

**Mục đích:**
Cập nhật trạng thái điểm danh của một thành viên.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Request body:**

```json
{
  "status": "present"
}
```

**Response:**

```json
{
  "message": "Attendance updated successfully"
}
```

**Database liên quan:**

- attendance

---

# 7. Statistics API

Statistics API dùng để thống kê dữ liệu.

---

## 7.1. GET /api/statistics/overview

**Mục đích:**
Lấy thống kê tổng quan toàn hệ thống.

**Quyền truy cập:**
Admin.

**Response:**

```json
{
  "total_clubs": 10,
  "total_members": 250,
  "total_events": 35,
  "total_registrations": 800
}
```

**Database liên quan:**

- clubs
- users
- club_members
- events
- event_registrations

---

## 7.2. GET /api/statistics/clubs/:clubId

**Mục đích:**
Lấy thống kê của một CLB.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Response:**

```json
{
  "club_id": 1,
  "total_members": 50,
  "total_events": 8,
  "total_registrations": 200,
  "attendance_rate": 85
}
```

**Database liên quan:**

- clubs
- club_members
- events
- event_registrations
- attendance

---

## 7.3. GET /api/statistics/events/:eventId

**Mục đích:**
Lấy thống kê của một sự kiện.

**Quyền truy cập:**
Admin, Chủ nhiệm CLB, Ban điều hành CLB.

**Response:**

```json
{
  "event_id": 1,
  "total_registrations": 80,
  "total_present": 70,
  "total_absent": 10,
  "attendance_rate": 87.5
}
```

**Database liên quan:**

- events
- event_registrations
- attendance

---

# 8. Tổng kết danh sách API

## 8.1. Auth API

```txt
POST /api/auth/register
POST /api/auth/login
GET  /api/auth/me
```

## 8.2. Club API

```txt
GET    /api/clubs
POST   /api/clubs
GET    /api/clubs/:id
PUT    /api/clubs/:id
DELETE /api/clubs/:id
```

## 8.3. Club Member API

```txt
GET    /api/clubs/:clubId/members
POST   /api/clubs/:clubId/members
PUT    /api/clubs/:clubId/members/:memberId
DELETE /api/clubs/:clubId/members/:memberId
```

## 8.4. Event API

```txt
GET    /api/events
POST   /api/events
GET    /api/events/:id
PUT    /api/events/:id
DELETE /api/events/:id
GET    /api/clubs/:clubId/events
```

## 8.5. Event Registration API

```txt
POST   /api/events/:eventId/register
DELETE /api/events/:eventId/register
GET    /api/events/:eventId/registrations
```

## 8.6. Attendance API

```txt
GET  /api/events/:eventId/attendance
POST /api/events/:eventId/attendance
PUT  /api/events/:eventId/attendance/:userId
```

## 8.7. Statistics API

```txt
GET /api/statistics/overview
GET /api/statistics/clubs/:clubId
GET /api/statistics/events/:eventId
```

---

# 9. Kết quả cần đạt

Sau khi hoàn thành file này, nhìn vào tài liệu có thể biết:

- Backend cần code những route nào.
- Frontend cần gọi endpoint nào.
- Mỗi API dùng để làm gì.
- Ai được quyền gọi API đó.
- API nhận dữ liệu gì.
- API trả về dữ liệu gì.
- API liên quan đến bảng database nào.

Tài liệu này sẽ được dùng để code backend Express ở bước sau.

---

# 10. Ghi chú

Tài liệu API này là bản thiết kế ban đầu cho giai đoạn MVP.

Khi code backend, nếu endpoint, request body hoặc response có thay đổi thì cần quay lại cập nhật file này để tài liệu luôn khớp với code thực tế.
