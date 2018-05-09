docker run -e ADV_HOST=127.0.0.1 -e EULA="https://dl.lenses.stream/d/?id=8631a6f8-1bf6-4c64-9a55-9d0b1d30642e" --rm -p 3030:3030 -p 9092:9092 -p 2181:2181 -p 8081:8081 -p 9581:9581 -p 9582:9582 -p 9584:9584 -p 9585:9585 landoop/kafka-lenses-dev

docker run -e --net=host \
   -e LICENSE_URL="https://milou.landoop.com/download/lensesdl/?id={YOUR_OWN_KEY}" \
   --rm -p 3030:3030 -p 9092:9092 -p 2181:2181 -p 8081:8081 \
   -p 9581:9581 -p 9582:9582 -p 9584:9584 -p 9585:9585 \
   -e DISABLE=mqtt -e SAMPLEDATA=0 \
   -v  ~/work/mqtt-connector:/connectors/mqtt-connector \
   landoop/kafka-lenses-dev

docker run -e --net=host -e LICENSE_URL="https://milou.landoop.com/download/lensesdl/?id=8631a6f8-1bf6-4c64-9a55-9d0b1d30642e" --rm -p 3030:3030 -p 9092:9092 -p 2181:2181 -p 8081:8081 -p 9581:9581 -p 9582:9582 -p 9584:9584 -p 9585:9585 -e DISABLE=mqtt -v ~/iot/connector/mqtt-connector:/connectors/mqtt-connector landoop/kafka-lenses-dev



sudo docker run -p 8086:8086 -v influxdb:/tmp/influxdb influxdb:1.3.0

curl -XPOST "http://localhost:8086/query" --data-urlencode "q=CREATE DATABASE iot"

curl -XPOST "http://localhost:8086/query" --data-urlencode "q=SHOW DATABASES"


#Sensor Data stream

/root/iot_mqtt/sensor/mqtt-sensor-data-1.0/bin/mqtt-sensor-data 1883 /sensor_data


#MQTT Connector Configuration file

com.datamountaineer.streamreactor.connect.converters.source.JsonSimpleConverter

name=Mqtt-Sensor-Source
connector.class=com.datamountaineer.streamreactor.connect.mqtt.source.MqttSourceConnector
tasks.max=1
connect.mqtt.kcql=INSERT INTO sensor_data SELECT * FROM /sensor_data 
  WITHCONVERTER=`com.datamountaineer.streamreactor.connect.converters.source.JsonSimpleConverter` WITHKEY(id)
connect.mqtt.connection.clean=true
connect.mqtt.connection.timeout=1000
connect.mqtt.connection.keep.alive=1000
connect.mqtt.client.id=lenses_mqtt_sensor
connect.mqtt.converter.throw.on.error=true
connect.mqtt.hosts=tcp://localhost:1883
connect.mqtt.service.quality=1
key.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schemas.enable=false
value.converter=org.apache.kafka.connect.json.JsonConverter
value.converter.schemas.enable=false


"name": "mqtt-sensor-source",
  "config": {
    "connector.class": "com.datamountaineer.streamreactor.connect.mqtt.source.MqttSourceConnector",
    "tasks.max": "1",
    "topics": "position-reports",
    "connect.mqtt.connection.clean": "true",
    "connect.mqtt.connection.timeout": "1000",
    "connect.mqtt.kcql": "INSERT INTO sensor_data SELECT * FROM /sensor_data WITHCONVERTER=`com.datamountaineer.streamreactor.connect.converters.source.JsonSimpleConverter` WITHKEY(id)",
    "connect.mqtt.connection.keep.alive": "1000",
    "connect.source.converter.avro.schemas": "/ais=/classAPositionReportSchema.json",
    "connect.mqtt.client.id": "lenses_mqtt_sensor",
    "connect.mqtt.converter.throw.on.error": "true",
    "connect.mqtt.hosts": "tcp://localhost:1883",
    "connect.mqtt.service.quality": "1"
  }

{
  "name": "mqtt-source",
  "config": {
    "connector.class": "com.datamountaineer.streamreactor.connect.mqtt.source.MqttSourceConnector",
    "tasks.max": "1",
    "topics": "position-reports",
    "connect.mqtt.connection.clean": "true",
    "connect.mqtt.connection.timeout": "1000",
    "connect.mqtt.kcql": "INSERT INTO position-reports SELECT * FROM /ais WITHCONVERTER=`com.datamountaineer.streamreactor.connect.converters.source.AvroConverter`",
    "connect.mqtt.connection.keep.alive": "1000",
    "connect.source.converter.avro.schemas": "/ais=/classAPositionReportSchema.json",
    "connect.mqtt.client.id": "ais-mqtt-connect-01",
    "connect.mqtt.converter.throw.on.error": "true",
    "connect.mqtt.hosts": "tcp://localhost:1883",
    "connect.mqtt.service.quality": "1"
  }
}


name=MqttSourceConnector
connector.class=com.datamountaineer.streamreactor.connect.mqtt.source.MqttSourceConnector
tasks.max=1
connect.mqtt.kcql=INSERT INTO sensor_data SELECT * FROM /sensor_data 
  WITHCONVERTER=`com.datamountaineer.streamreactor.connect.converters.source.JsonSimpleConverter` WITHKEY(id)
connect.mqtt.hosts=tcp://127.0.0.1:1883
connect.mqtt.service.quality=1
connect.mqtt.kcql=INSERT INTO mqtt_kafka_topic SELECT * FROM mqtt2kafka WITHCONVERTER=com.datamountaineer.streamreactor.connect.converters.source.JsonSimpleConverter
key.converter=org.apache.kafka.connect.json.JsonConverter
value.converter=org.apache.kafka.connect.json.JsonConverter


docker commit -a {auther} conatinerId {Image-name:Tag}

docker run -d -w /{wd} -p 9000:3000 {Image-name:Tag} command

docker tag {image-name:tag} {image-name:latest} 


sudo apt-get install mosquitto mosquitto-clients



sudo nano /etc/mosquitto/conf.d/default.conf



Mosquitto comes with a password file generating utility called mosquitto_passwd.

sudo mosquitto_passwd -c /etc/mosquitto/passwd dave
Password: password
Create a configuration file for Mosquitto pointing to the password file we have just created.

sudo nano /etc/mosquitto/conf.d/default.conf
This will open an empty file. Paste the following into it.

allow_anonymous false
password_file /etc/mosquitto/passwd
Save and exit the text editor with "Ctrl+O", "Enter" and "Ctrl+X".

Now restart Mosquitto server and test our changes.

sudo systemctl restart mosquitto


res.render('consumer', { title: 'IOT App', consumerData: sensorData });


# start zookeeper server
./bin/zookeeper-server-start.sh ./config/zookeeper.properties

# start broker
./bin/kafka-server-start.sh ./config/server.properties 

# create topic “test”
 ./bin/kafka-topics.sh --create --topic weather --zookeeper localhost:2181 --partitions 1 --replication-factor 1

# consume from the topic using the console producer
./bin/kafka-console-consumer.sh --topic weather --zookeeper localhost:2181

# produce something into the topic (write something and hit enter)
./bin/kafka-console-producer.sh --topic weather --broker-list localhost:9092



## Elastic search
git clone -b 0.10.0.0 https://github.com/confluentinc/kafka-connect-elasticsearch.git

cd kafka-connect-elasticsearch
mvn clean package

target/kafka-connect-elasticsearch-3.2.0-SNAPSHOT-package/share/java/kafka-connect-elasticsearch/



#Configuring Elasticsearch Connector
elasticsearch-connect.properties with the following content:

name=elasticsearch-sink
connector.class=io.confluent.connect.elasticsearch.ElasticsearchSinkConnector
tasks.max=1
topics=logs
topic.index.map=logs:logs_index
connection.url=http://localhost:9200
type.name=log
key.ignore=true
schema.ignore=true

# Running Standalone
connect-standalone.properties and which will have the following contents:

bootstrap.servers=localhost:9092
key.converter=org.apache.kafka.connect.json.JsonConverter
value.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schemas.enable=false
value.converter.schemas.enable=false
internal.key.converter=org.apache.kafka.connect.json.JsonConverter
internal.value.converter=org.apache.kafka.connect.json.JsonConverter
internal.key.converter.schemas.enable=false
internal.value.converter.schemas.enable=false
offset.storage.file.filename=/tmp/connect.offsets
offset.flush.interval.ms=10000


bin/connect-standalone.sh config/connect-standalone.properties config/elasticsearch-connect.properties

# Running Distributed  
connect-distributed.properties file:

bootstrap.servers=localhost:9092
key.converter=org.apache.kafka.connect.json.JsonConverter
value.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schemas.enable=false
value.converter.schemas.enable=false
internal.key.converter=org.apache.kafka.connect.json.JsonConverter
internal.value.converter=org.apache.kafka.connect.json.JsonConverter
internal.key.converter.schemas.enable=false
internal.value.converter.schemas.enable=false
offset.flush.interval.ms=10000
group.id=connect-cluster
offset.storage.topic=connect-offsets
config.storage.topic=connect-configs
status.storage.topic=connect-status

bin/connect-distributed.sh config/connect-distributed.properties


ssh root@141.40.254.37
