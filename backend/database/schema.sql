-- =====================================================
-- Student Club Management System - Database Schema
-- =====================================================

-- Xóa bảng cũ nếu cần chạy lại schema
-- Lưu ý: chỉ dùng khi đang phát triển, không dùng trên production

DROP TABLE IF EXISTS activity_logs;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS attendances;
DROP TABLE IF EXISTS event_registrations;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS club_members;
DROP TABLE IF EXISTS clubs;
DROP TABLE IF EXISTS users;

-- =====================================================
-- 1. USERS
-- Mục đích: Lưu thông tin tài khoản người dùng
-- =====================================================

CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,

    student_code VARCHAR(50) UNIQUE,
    phone VARCHAR(20),
    avatar_url VARCHAR(500),
    faculty VARCHAR(255),
    class_name VARCHAR(100),

    system_role ENUM('admin', 'student') NOT NULL DEFAULT 'student',
    status ENUM('active', 'inactive', 'banned') NOT NULL DEFAULT 'active',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================
-- 2. CLUBS
-- Mục đích: Lưu thông tin câu lạc bộ
-- =====================================================

CREATE TABLE clubs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    logo_url VARCHAR(500),
    cover_url VARCHAR(500),
    category VARCHAR(100),
    founded_date DATE,
    contact_email VARCHAR(255),
    fanpage_url VARCHAR(500),

    status ENUM('pending', 'active', 'inactive', 'rejected') NOT NULL DEFAULT 'pending',

    created_by BIGINT NOT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_clubs_created_by
        FOREIGN KEY (created_by) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =====================================================
-- 3. CLUB_MEMBERS
-- Mục đích: Lưu user thuộc CLB nào và giữ vai trò gì
-- =====================================================

CREATE TABLE club_members (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    user_id BIGINT NOT NULL,
    club_id BIGINT NOT NULL,

    role ENUM('club_manager', 'executive', 'member') NOT NULL DEFAULT 'member',
    status ENUM('pending', 'approved', 'rejected', 'left', 'removed') NOT NULL DEFAULT 'pending',

    joined_at DATETIME,
    approved_by BIGINT,
    approved_at DATETIME,
    note TEXT,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_club_members_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_club_members_club
        FOREIGN KEY (club_id) REFERENCES clubs(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_club_members_approved_by
        FOREIGN KEY (approved_by) REFERENCES users(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT uq_club_members_user_club
        UNIQUE (user_id, club_id)
);

-- =====================================================
-- 4. EVENTS
-- Mục đích: Lưu thông tin sự kiện của CLB
-- =====================================================

CREATE TABLE events (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    club_id BIGINT NOT NULL,

    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    location VARCHAR(255),

    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,

    max_participants INT,
    registration_start DATETIME,
    registration_end DATETIME,

    requires_approval BOOLEAN NOT NULL DEFAULT FALSE,

    status ENUM('draft', 'pending', 'published', 'cancelled', 'completed') NOT NULL DEFAULT 'draft',

    created_by BIGINT NOT NULL,
    approved_by BIGINT,
    approved_at DATETIME,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_events_club
        FOREIGN KEY (club_id) REFERENCES clubs(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_events_created_by
        FOREIGN KEY (created_by) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_events_approved_by
        FOREIGN KEY (approved_by) REFERENCES users(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT chk_events_time
        CHECK (end_time > start_time),

    CONSTRAINT chk_events_max_participants
        CHECK (max_participants IS NULL OR max_participants > 0)
);

-- =====================================================
-- 5. EVENT_REGISTRATIONS
-- Mục đích: Lưu danh sách người đăng ký sự kiện
-- =====================================================

CREATE TABLE event_registrations (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    event_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,

    status ENUM('pending', 'approved', 'registered', 'rejected', 'cancelled') NOT NULL DEFAULT 'registered',

    registered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cancelled_at DATETIME,

    approved_by BIGINT,
    approved_at DATETIME,

    note TEXT,

    CONSTRAINT fk_event_registrations_event
        FOREIGN KEY (event_id) REFERENCES events(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_event_registrations_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_event_registrations_approved_by
        FOREIGN KEY (approved_by) REFERENCES users(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT uq_event_registrations_event_user
        UNIQUE (event_id, user_id)
);

-- =====================================================
-- 6. ATTENDANCES
-- Mục đích: Lưu kết quả điểm danh thực tế
-- =====================================================

CREATE TABLE attendances (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    event_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    registration_id BIGINT,

    status ENUM('present', 'absent', 'late', 'excused') NOT NULL,
    checkin_method ENUM('manual', 'qr', 'admin') NOT NULL DEFAULT 'manual',

    checked_in_at DATETIME,
    checked_by BIGINT,

    note TEXT,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_attendances_event
        FOREIGN KEY (event_id) REFERENCES events(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_attendances_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_attendances_registration
        FOREIGN KEY (registration_id) REFERENCES event_registrations(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_attendances_checked_by
        FOREIGN KEY (checked_by) REFERENCES users(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT uq_attendances_event_user
        UNIQUE (event_id, user_id)
);

-- =====================================================
-- 7. NOTIFICATIONS
-- Mục đích: Lưu thông báo gửi cho người dùng
-- =====================================================

CREATE TABLE notifications (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    user_id BIGINT NOT NULL,

    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,

    type ENUM('club', 'event', 'registration', 'attendance', 'system') NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notifications_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================================
-- 8. ACTIVITY_LOGS
-- Mục đích: Lưu lịch sử thao tác quan trọng
-- =====================================================

CREATE TABLE activity_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    actor_id BIGINT NOT NULL,

    action VARCHAR(100) NOT NULL,
    target_type VARCHAR(100) NOT NULL,
    target_id BIGINT NOT NULL,
    description TEXT,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_activity_logs_actor
        FOREIGN KEY (actor_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================================
-- INDEXES
-- Mục đích: Tăng tốc truy vấn
-- =====================================================

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_student_code ON users(student_code);

CREATE INDEX idx_clubs_status ON clubs(status);
CREATE INDEX idx_clubs_category ON clubs(category);

CREATE INDEX idx_club_members_user_id ON club_members(user_id);
CREATE INDEX idx_club_members_club_id ON club_members(club_id);
CREATE INDEX idx_club_members_status ON club_members(status);
CREATE INDEX idx_club_members_role ON club_members(role);

CREATE INDEX idx_events_club_id ON events(club_id);
CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_start_time ON events(start_time);

CREATE INDEX idx_event_registrations_event_id ON event_registrations(event_id);
CREATE INDEX idx_event_registrations_user_id ON event_registrations(user_id);
CREATE INDEX idx_event_registrations_status ON event_registrations(status);

CREATE INDEX idx_attendances_event_id ON attendances(event_id);
CREATE INDEX idx_attendances_user_id ON attendances(user_id);
CREATE INDEX idx_attendances_status ON attendances(status);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);

CREATE INDEX idx_activity_logs_actor_id ON activity_logs(actor_id);
CREATE INDEX idx_activity_logs_target ON activity_logs(target_type, target_id);