(
echo d
echo n
echo p
echo 1
echo 
echo 
echo t
echo 83
echo a
echo p
echo w
) | fdisk /dev/vda

partprobe /dev/vda
resize2fs /dev/vda1
add-apt-repository -y ppa:webupd8team/java
apt update

apt install oracle-java8-installer -y

(
    echo y | apt install zookeeperd

)

wget http://apache.lauf-forum.at/kafka/1.1.0/kafka_2.12-1.1.0.tgz
tar -xvf kafka_2.12-1.1.0.tgz
(
    echo y | apt install python3-pip

pip3 install kafka-python
wget http://apache.lauf-forum.at/flink/flink-1.4.2/flink-1.4.2-bin-hadoop28-scala_2.11.tgz
tar -xvf flink-1.4.2-bin-hadoop28-scala_2.11.tgz

git clone https://github.com/aakashk2910/kafka-elasticsearch-jar.git
cp -r ../kafka-elasticsearch-jar/target/kafka-connect-elasticsearch-3.2.0-SNAPSHOT-package/share/java/kafka-connect-elasticsearch/ ../kafka_2.12-1.1.0/libs/

ufw enable

ufw allow 22

iptables -I INPUT -p tcp -m tcp --dport 3000 -j ACCEPT