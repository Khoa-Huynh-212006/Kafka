import time
import random
from faker import Faker
import mysql.connector

db_config = {
    'user': 'root',
    'password': 'root_password',  
    'host': 'localhost',
    'database': 'olist_db',
    'port': 3308                    
}

fake = Faker()

def create_connection():
    return mysql.connector.connect(**db_config)

def generate_fake_data():
    conn = create_connection()
    cursor = conn.cursor()
    
    print("Bắt đầu bơm data giả vào olist_db...")
    try:
        while True:
            order_id = fake.uuid4()
            customer_id = fake.uuid4()
            status = random.choice(['approved', 'processing', 'shipped', 'delivered'])
            
            sql = "INSERT INTO olist_orders (order_id, customer_id, order_status) VALUES (%s, %s, %s)" # %s là 1 cái ghế trống giờ val điền vào 
            val = (order_id, customer_id, status)
            
            cursor.execute(sql, val) #lưu code vào bộ nhớ tạm
            conn.commit() # chạy code trong cursor.execute và xóa code trong bộ nhớ tạm
            
            print(f"Đã tạo đơn: {order_id} Status: {status}")
            
            time.sleep(2)
            
    except KeyboardInterrupt:
        print("Đã dừng bơm data.")
    except Exception as e:
        print(f"Lỗi kết nối: {e}")
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

if __name__ == "__main__":

    generate_fake_data()
