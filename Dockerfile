# 1. Chọn nền tảng (Base Image)
FROM confluentinc/cp-kafka-connect:7.5.0

# 2. Chuyển sang quyền Root
USER root

# 3. Cài đặt Debezium Connector (Có sẵn driver MySQL riêng của nó, nhưng JDBC Sink không dùng chung được)
RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:2.2.1

# 4. Cài đặt JDBC Connector (Cái này đang bị thiếu Driver)
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.7.4

# 5. [MỚI] Tải MySQL Driver và bỏ vào thư mục của JDBC Sink
# Chúng ta tải driver chính hãng từ Maven về
RUN cd /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib && \
    curl -O https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar

# 6. Tạo file debug (như cũ)
RUN touch /tmp/debug.txt