# ERD - Student Club Management System

## 1. Mục đích

Tài liệu này mô tả sơ đồ quan hệ dữ liệu của hệ thống Web quản lý Câu lạc bộ Sinh viên.

ERD giúp xác định:

- Các bảng chính trong hệ thống.
- Các cột quan trọng của từng bảng.
- Khóa chính.
- Khóa ngoại.
- Quan hệ giữa các bảng.
- Luồng dữ liệu giữa người dùng, CLB, thành viên, sự kiện, đăng ký và điểm danh.

## 2. Các bảng trong hệ thống

Database MVP gồm 6 bảng chính:

1. users
2. clubs
3. club_members
4. events
5. event_registrations
6. attendances

Có thể mở rộng thêm:

7. notifications
8. activity_logs

## 3. ERD bằng Mermaid

```mermaid
erDiagram

    USERS {
        bigint id PK
        varchar full_name
        varchar email UK
        varchar password_hash
        varchar student_code UK
        varchar phone
        varchar avatar_url
        varchar faculty
        varchar class_name
        enum system_role
        enum status
        datetime created_at
        datetime updated_at
    }

    CLUBS {
        bigint id PK
        varchar name
        varchar slug UK
        text description
        varchar logo_url
        varchar cover_url
        varchar category
        date founded_date
        varchar contact_email
        varchar fanpage_url
        enum status
        bigint created_by FK
        datetime created_at
        datetime updated_at
    }

    CLUB_MEMBERS {
        bigint id PK
        bigint user_id FK
        bigint club_id FK
        enum role
        enum status
        datetime joined_at
        bigint approved_by FK
        datetime approved_at
        text note
        datetime created_at
        datetime updated_at
    }

    EVENTS {
        bigint id PK
        bigint club_id FK
        varchar title
        varchar slug UK
        text description
        varchar location
        datetime start_time
        datetime end_time
        int max_participants
        datetime registration_start
        datetime registration_end
        boolean requires_approval
        enum status
        bigint created_by FK
        bigint approved_by FK
        datetime approved_at
        datetime created_at
        datetime updated_at
    }

    EVENT_REGISTRATIONS {
        bigint id PK
        bigint event_id FK
        bigint user_id FK
        enum status
        datetime registered_at
        datetime cancelled_at
        bigint approved_by FK
        datetime approved_at
        text note
    }

    ATTENDANCES {
        bigint id PK
        bigint event_id FK
        bigint user_id FK
        bigint registration_id FK
        enum status
        enum checkin_method
        datetime checked_in_at
        bigint checked_by FK
        text note
        datetime created_at
        datetime updated_at
    }

    NOTIFICATIONS {
        bigint id PK
        bigint user_id FK
        varchar title
        text content
        enum type
        boolean is_read
        datetime created_at
    }

    ACTIVITY_LOGS {
        bigint id PK
        bigint actor_id FK
        varchar action
        varchar target_type
        bigint target_id
        text description
        datetime created_at
    }

    USERS ||--o{ CLUBS : creates

    USERS ||--o{ CLUB_MEMBERS : joins
    CLUBS ||--o{ CLUB_MEMBERS : has_members
    USERS ||--o{ CLUB_MEMBERS : approves_members

    CLUBS ||--o{ EVENTS : organizes
    USERS ||--o{ EVENTS : creates_events
    USERS ||--o{ EVENTS : approves_events

    EVENTS ||--o{ EVENT_REGISTRATIONS : has_registrations
    USERS ||--o{ EVENT_REGISTRATIONS : registers
    USERS ||--o{ EVENT_REGISTRATIONS : approves_registrations

    EVENTS ||--o{ ATTENDANCES : has_attendances
    USERS ||--o{ ATTENDANCES : attends
    EVENT_REGISTRATIONS ||--o| ATTENDANCES : may_have_attendance
    USERS ||--o{ ATTENDANCES : checks_attendance

    USERS ||--o{ NOTIFICATIONS : receives

    USERS ||--o{ ACTIVITY_LOGS : performs
```
