-- 1. Tạo Database
CREATE DATABASE IF NOT EXISTS analytics_db;
USE analytics_db;

-- 2. [FIX LỖI] Tạo User thủ công để chắc chắn nó tồn tại
-- (Nếu user đã có rồi thì lệnh này sẽ bỏ qua, không lỗi)
CREATE USER IF NOT EXISTS 'analytics_user'@'%' IDENTIFIED BY 'analytics_password';

-- 3. Cấp quyền
GRANT ALL PRIVILEGES ON analytics_db.* TO 'analytics_user'@'%';
FLUSH PRIVILEGES;

-- 4. Tạo bảng đích (Schema chuẩn)
CREATE TABLE IF NOT EXISTS olist_orders_analytics (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    updated_at TEXT
);