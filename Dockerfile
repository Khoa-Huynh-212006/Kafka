FROM confluentinc/cp-kafka-connect:7.5.0

USER root

RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:2.2.1

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.7.4


RUN cd /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib && \
    curl -O https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar


RUN touch /tmp/debug.txt
