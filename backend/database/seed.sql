-- =====================================================
-- Student Club Management System - Seed Data
-- =====================================================

-- Lưu ý:
-- File này dùng để thêm dữ liệu mẫu phục vụ kiểm thử.
-- Cần chạy schema.sql trước, sau đó mới chạy seed.sql.

-- =====================================================
-- 1. USERS
-- =====================================================

INSERT INTO users (
    full_name,
    email,
    password_hash,
    student_code,
    phone,
    faculty,
    class_name,
    system_role,
    status
) VALUES
(
    'System Admin',
    'admin@example.com',
    '$2b$10$examplehashedpasswordadmin',
    NULL,
    '0900000000',
    'Phòng Công tác Sinh viên',
    NULL,
    'admin',
    'active'
),
(
    'Nguyễn Văn An',
    'an@example.com',
    '$2b$10$examplehashedpassword1',
    'SV001',
    '0900000001',
    'Công nghệ thông tin',
    '24DTHA1',
    'student',
    'active'
),
(
    'Trần Thị Bình',
    'binh@example.com',
    '$2b$10$examplehashedpassword2',
    'SV002',
    '0900000002',
    'Công nghệ thông tin',
    '24DTHA1',
    'student',
    'active'
),
(
    'Lê Minh Cường',
    'cuong@example.com',
    '$2b$10$examplehashedpassword3',
    'SV003',
    '0900000003',
    'Ngôn ngữ Nhật',
    '24DTHJA1',
    'student',
    'active'
),
(
    'Phạm Gia Hân',
    'han@example.com',
    '$2b$10$examplehashedpassword4',
    'SV004',
    '0900000004',
    'Truyền thông đa phương tiện',
    '24DTTT1',
    'student',
    'active'
);

-- =====================================================
-- 2. CLUBS
-- =====================================================

INSERT INTO clubs (
    name,
    slug,
    description,
    logo_url,
    cover_url,
    category,
    founded_date,
    contact_email,
    fanpage_url,
    status,
    created_by
) VALUES
(
    'CLB Công nghệ Thông tin',
    'clb-cong-nghe-thong-tin',
    'Câu lạc bộ dành cho sinh viên yêu thích lập trình, công nghệ, AI và phát triển phần mềm.',
    NULL,
    NULL,
    'Học thuật',
    '2022-09-01',
    'itclub@example.com',
    'https://facebook.com/itclub',
    'active',
    1
),
(
    'CLB Tiếng Nhật AKIKO',
    'clb-tieng-nhat-akiko',
    'Câu lạc bộ dành cho sinh viên yêu thích tiếng Nhật, văn hóa Nhật Bản và giao lưu học thuật.',
    NULL,
    NULL,
    'Ngôn ngữ - Văn hóa',
    '2021-10-15',
    'akiko@example.com',
    'https://facebook.com/akiko',
    'active',
    1
),
(
    'CLB Truyền thông Sinh viên',
    'clb-truyen-thong-sinh-vien',
    'Câu lạc bộ phụ trách truyền thông, hình ảnh, nội dung và tổ chức sự kiện sinh viên.',
    NULL,
    NULL,
    'Truyền thông',
    '2020-05-20',
    'media@example.com',
    'https://facebook.com/studentmedia',
    'active',
    1
);

-- =====================================================
-- 3. CLUB_MEMBERS
-- =====================================================

INSERT INTO club_members (
    user_id,
    club_id,
    role,
    status,
    joined_at,
    approved_by,
    approved_at,
    note
) VALUES
-- CLB Công nghệ Thông tin
(
    2,
    1,
    'club_manager',
    'approved',
    '2024-09-10 08:00:00',
    1,
    '2024-09-10 08:30:00',
    'Chủ nhiệm CLB Công nghệ Thông tin'
),
(
    3,
    1,
    'executive',
    'approved',
    '2024-09-12 09:00:00',
    2,
    '2024-09-12 09:20:00',
    'Ban điều hành phụ trách sự kiện'
),
(
    4,
    1,
    'member',
    'approved',
    '2024-09-15 10:00:00',
    2,
    '2024-09-15 10:15:00',
    'Thành viên chính thức'
),

-- CLB Tiếng Nhật AKIKO
(
    4,
    2,
    'club_manager',
    'approved',
    '2024-09-11 08:00:00',
    1,
    '2024-09-11 08:30:00',
    'Chủ nhiệm CLB AKIKO'
),
(
    2,
    2,
    'member',
    'approved',
    '2024-09-16 10:00:00',
    4,
    '2024-09-16 10:10:00',
    'Thành viên yêu thích tiếng Nhật'
),
(
    5,
    2,
    'executive',
    'approved',
    '2024-09-18 14:00:00',
    4,
    '2024-09-18 14:30:00',
    'Ban điều hành phụ trách truyền thông'
),

-- CLB Truyền thông Sinh viên
(
    5,
    3,
    'club_manager',
    'approved',
    '2024-09-20 08:00:00',
    1,
    '2024-09-20 08:30:00',
    'Chủ nhiệm CLB Truyền thông'
),
(
    3,
    3,
    'member',
    'pending',
    NULL,
    NULL,
    NULL,
    'Đang chờ duyệt tham gia CLB'
);

-- =====================================================
-- 4. EVENTS
-- =====================================================

INSERT INTO events (
    club_id,
    title,
    slug,
    description,
    location,
    start_time,
    end_time,
    max_participants,
    registration_start,
    registration_end,
    requires_approval,
    status,
    created_by,
    approved_by,
    approved_at
) VALUES
(
    1,
    'Workshop Nhập môn Web Development',
    'workshop-nhap-mon-web-development',
    'Buổi workshop giới thiệu HTML, CSS, JavaScript và cách xây dựng một website cơ bản.',
    'Phòng B-10.12',
    '2026-07-05 08:00:00',
    '2026-07-05 11:00:00',
    50,
    '2026-06-20 00:00:00',
    '2026-07-04 23:59:59',
    false,
    'published',
    2,
    1,
    '2026-06-20 09:00:00'
),
(
    2,
    'Giao lưu Văn hóa Nhật Bản',
    'giao-luu-van-hoa-nhat-ban',
    'Sự kiện giao lưu văn hóa Nhật Bản, chia sẻ kinh nghiệm học tiếng Nhật và JLPT.',
    'Hội trường E1',
    '2026-07-10 13:30:00',
    '2026-07-10 16:30:00',
    80,
    '2026-06-22 00:00:00',
    '2026-07-09 23:59:59',
    false,
    'published',
    4,
    1,
    '2026-06-22 10:00:00'
),
(
    3,
    'Training Kỹ năng Truyền thông Sự kiện',
    'training-ky-nang-truyen-thong-su-kien',
    'Buổi training về chụp ảnh, viết nội dung, thiết kế bài đăng và truyền thông sự kiện.',
    'Phòng E-03.05',
    '2026-07-15 18:00:00',
    '2026-07-15 20:30:00',
    40,
    '2026-06-25 00:00:00',
    '2026-07-14 23:59:59',
    true,
    'published',
    5,
    1,
    '2026-06-25 09:00:00'
);

-- =====================================================
-- 5. EVENT_REGISTRATIONS
-- =====================================================

INSERT INTO event_registrations (
    event_id,
    user_id,
    status,
    registered_at,
    cancelled_at,
    approved_by,
    approved_at,
    note
) VALUES
-- Workshop Web Development
(
    1,
    2,
    'registered',
    '2026-06-21 08:00:00',
    NULL,
    NULL,
    NULL,
    'Chủ nhiệm CLB cũng tham gia hỗ trợ workshop'
),
(
    1,
    3,
    'registered',
    '2026-06-21 09:00:00',
    NULL,
    NULL,
    NULL,
    'Ban điều hành tham gia hỗ trợ'
),
(
    1,
    4,
    'registered',
    '2026-06-22 10:00:00',
    NULL,
    NULL,
    NULL,
    'Thành viên đăng ký tham gia'
),

-- Giao lưu Văn hóa Nhật Bản
(
    2,
    2,
    'registered',
    '2026-06-23 08:30:00',
    NULL,
    NULL,
    NULL,
    'Thành viên CLB IT đăng ký giao lưu'
),
(
    2,
    4,
    'registered',
    '2026-06-23 09:30:00',
    NULL,
    NULL,
    NULL,
    'Chủ nhiệm CLB AKIKO tham gia tổ chức'
),
(
    2,
    5,
    'registered',
    '2026-06-24 14:00:00',
    NULL,
    NULL,
    NULL,
    'Ban điều hành truyền thông hỗ trợ sự kiện'
),

-- Training Truyền thông
(
    3,
    3,
    'pending',
    '2026-06-26 10:00:00',
    NULL,
    NULL,
    NULL,
    'Chờ duyệt vì sự kiện yêu cầu phê duyệt'
),
(
    3,
    5,
    'approved',
    '2026-06-26 11:00:00',
    NULL,
    1,
    '2026-06-26 12:00:00',
    'Được duyệt tham gia training'
);

-- =====================================================
-- 6. ATTENDANCES
-- =====================================================

INSERT INTO attendances (
    event_id,
    user_id,
    registration_id,
    status,
    checkin_method,
    checked_in_at,
    checked_by,
    note
) VALUES
-- Điểm danh Workshop Web Development
(
    1,
    2,
    1,
    'present',
    'manual',
    '2026-07-05 07:55:00',
    3,
    'Có mặt đúng giờ'
),
(
    1,
    3,
    2,
    'present',
    'manual',
    '2026-07-05 07:50:00',
    3,
    'Ban điều hành hỗ trợ check-in'
),
(
    1,
    4,
    3,
    'late',
    'qr',
    '2026-07-05 08:20:00',
    3,
    'Check-in bằng QR, đến trễ 20 phút'
),

-- Điểm danh Giao lưu Văn hóa Nhật Bản
(
    2,
    2,
    4,
    'present',
    'qr',
    '2026-07-10 13:20:00',
    5,
    'Có mặt trước giờ bắt đầu'
),
(
    2,
    4,
    5,
    'present',
    'manual',
    '2026-07-10 13:10:00',
    5,
    'Thành viên ban tổ chức'
),
(
    2,
    5,
    6,
    'absent',
    'manual',
    NULL,
    4,
    'Đăng ký nhưng vắng mặt'
);

-- =====================================================
-- 7. NOTIFICATIONS
-- =====================================================

INSERT INTO notifications (
    user_id,
    title,
    content,
    type,
    is_read
) VALUES
(
    2,
    'Đăng ký sự kiện thành công',
    'Bạn đã đăng ký thành công sự kiện Workshop Nhập môn Web Development.',
    'registration',
    false
),
(
    4,
    'Bạn đã được duyệt vào CLB',
    'Yêu cầu tham gia CLB Công nghệ Thông tin của bạn đã được duyệt.',
    'club',
    false
),
(
    5,
    'Sự kiện mới từ CLB AKIKO',
    'CLB Tiếng Nhật AKIKO vừa công bố sự kiện Giao lưu Văn hóa Nhật Bản.',
    'event',
    false
);

-- =====================================================
-- 8. ACTIVITY_LOGS
-- =====================================================

INSERT INTO activity_logs (
    actor_id,
    action,
    target_type,
    target_id,
    description
) VALUES
(
    1,
    'CREATE_CLUB',
    'club',
    1,
    'Admin tạo CLB Công nghệ Thông tin'
),
(
    1,
    'CREATE_CLUB',
    'club',
    2,
    'Admin tạo CLB Tiếng Nhật AKIKO'
),
(
    2,
    'CREATE_EVENT',
    'event',
    1,
    'Chủ nhiệm CLB IT tạo sự kiện Workshop Nhập môn Web Development'
),
(
    4,
    'APPROVE_MEMBER',
    'club_member',
    5,
    'Chủ nhiệm CLB AKIKO duyệt thành viên'
),
(
    3,
    'CHECK_ATTENDANCE',
    'attendance',
    1,
    'Ban điều hành điểm danh sự kiện Workshop Nhập môn Web Development'
);