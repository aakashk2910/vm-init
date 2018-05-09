#start zookeeper
./kafka_2.12-1.1.0/bin/zookeeper-server-start.sh -daemon ./kafka_2.12-1.1.0/config/zookeeper.properties

# start broker
./kafka_2.12-1.1.0/bin/kafka-server-start.sh -daemon ./kafka_2.12-1.1.0/config/server.properties 

# create topic “test”
./kafka_2.12-1.1.0/bin/kafka-topics.sh --create --topic weather --zookeeper localhost:2181 --partitions 1 --replication-factor 1

# consume from the topic using the console producer
./kafka_2.12-1.1.0/bin/kafka-console-consumer.sh -daemon --topic weather --zookeeper localhost:2181

# produce something into the topic (write something and hit enter)
./kafka_2.12-1.1.0/bin/kafka-console-producer.sh -daemon --topic weather --broker-list localhost:9092


echo "name=elasticsearch-sink
connector.class=io.confluent.connect.elasticsearch.ElasticsearchSinkConnector
tasks.max=1
topics=logs
topic.index.map=logs:logs_index
connection.url=http://localhost:9200
type.name=log
key.ignore=true
schema.ignore=true" >> kafka_2.12-1.1.0/config/elasticsearch-connect.properties

echo "bootstrap.servers=localhost:9092
key.converter=org.apache.kafka.connect.json.JsonConverter
value.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schemas.enable=false
value.converter.schemas.enable=false
internal.key.converter=org.apache.kafka.connect.json.JsonConverter
internal.value.converter=org.apache.kafka.connect.json.JsonConverter
internal.key.converter.schemas.enable=false
internal.value.converter.schemas.enable=false
offset.storage.file.filename=/tmp/connect.offsets
offset.flush.interval.ms=10000" >> kafka_2.12-1.1.0/config/connect-standalone.properties

kafka_2.12-1.1.0/bin/connect-standalone.sh config/connect-standalone.properties config/elasticsearch-connect.properties