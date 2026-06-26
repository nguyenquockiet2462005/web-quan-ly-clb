# Student Club Management System

## Giới thiệu

Đây là hệ thống web quản lí câu lạc bộ sinh viên, hỗ trợ nhà trường hoặc ban quản lí CLB quản lí thông tin câu lạc bộ, thành viên, sự kiện, đăng ký tham gia, điểm danh và thống kê hoạt động.

## Công nghệ dự kiến

- Frontend: React
- Backend: Node.js, Express.js
- Database: MySQL hoặc PostgreSQL
- Authentication: JWT
- API Testing: Postman
- Version Control: Git, GitHub

## Vai trò người dùng

- Admin
- Club Manager
- Member

## Chức năng MVP

- Đăng ký, đăng nhập
- Phân quyền người dùng
- Quản lí CLB
- Quản lí thành viên CLB
- Quản lí sự kiện
- Đăng ký tham gia sự kiện
- Điểm danh thủ công
- Thống kê cơ bản

## Cấu trúc thư mục

```txt
student-club-management-system/
│
├── backend/
├── frontend/
├── docs/
│   ├── requirement.md
│   ├── erd.md
│   ├── api-list.md
│   └── report.md
│
├── README.md
└── .gitignore


# Requirement Document

## 1. Mục tiêu dự án

Xây dựng hệ thống web quản lí câu lạc bộ sinh viên, giúp quản lí thông tin CLB, thành viên, sự kiện, đăng ký tham gia, điểm danh và thống kê hoạt động.

## 2. Đối tượng sử dụng

### Admin

- Quản lí toàn bộ hệ thống
- Quản lí danh sách CLB
- Quản lí tài khoản người dùng
- Xem thống kê tổng quan

### Club Manager

- Quản lí CLB của mình
- Quản lí thành viên trong CLB
- Tạo và quản lí sự kiện
- Điểm danh người tham gia sự kiện

### Member

- Xem danh sách CLB
- Tham gia CLB
- Xem sự kiện
- Đăng ký tham gia sự kiện
- Xem lịch sử tham gia

## 3. MVP

Các chức năng thuộc MVP v1:

1. Đăng ký
2. Đăng nhập
3. Quản lí CLB
4. Quản lí thành viên CLB
5. Phân quyền
6. Quản lí sự kiện
7. Đăng ký tham gia sự kiện
8. Điểm danh thủ công
9. Thống kê cơ bản

## 4. Chức năng phát triển sau

1. QR check-in
2. Upload ảnh/logo trực tiếp
3. Xuất Excel
4. Gửi email
5. Dashboard biểu đồ nâng cao
6. Thông báo real-time
7. Ghi nhận điểm rèn luyện

```
