-- ===================================================
-- PHẦN 1: VAI TRÒ SYSTEM ADMIN (Tạo User & Cấp Quyền)
-- ===================================================

-- 1. Tạo user 'user_de' để Debezium sử dụng (Không dùng root cho an toàn)
CREATE USER 'user_de'@'%' IDENTIFIED WITH mysql_native_password BY 'password_de';

-- 2. Cấp quyền Replication (QUAN TRỌNG NHẤT CHO CDC)
-- Debezium cần quyền này để đọc Binlog
GRANT RELOAD, FLUSH_TABLES, REPLICATION CLIENT, REPLICATION SLAVE, SHOW DATABASES ON *.* TO 'user_de'@'%';

-- 3. Cấp quyền thao tác dữ liệu trên DB olist_db
GRANT ALL PRIVILEGES ON olist_db.* TO 'user_de'@'%';

FLUSH PRIVILEGES;

-- ===================================================
-- PHẦN 2: VAI TRÒ DATABASE ARCHITECT (Tạo Cấu Trúc)
-- ===================================================

CREATE DATABASE IF NOT EXISTS olist_db;
USE olist_db;

-- Tạo bảng Đơn hàng (Đây là bảng chúng ta sẽ Stream)
CREATE TABLE olist_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ===================================================
-- PHẦN 3: VAI TRÒ TESTER (Nạp Dữ Liệu Mẫu)
-- ===================================================

-- Insert dữ liệu giả để khi hệ thống chạy lên là có cái test ngay
INSERT INTO olist_orders (order_id, customer_id, order_status, order_purchase_timestamp) VALUES 
('ORD_001', 'CUST_A', 'delivered', '2023-10-01 10:00:00'),
('ORD_002', 'CUST_B', 'shipped', '2023-10-01 11:30:00'),
('ORD_003', 'CUST_C', 'processing', '2023-10-01 12:00:00');