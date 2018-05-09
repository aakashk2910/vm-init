fdisk /dev/vda
d
n
p
1


t
83
a
p
w
partprobe /dev/vda
resize2fs /dev/vda1
add-apt-repository -y ppa:webupd8team/java
apt update
apt install oracle-java8-installer -y

yes
apt install zookeeperd
y
wget http://apache.lauf-forum.at/kafka/1.1.0/kafka_2.12-1.1.0.tgz
tar -xvf kafka_2.12-1.1.0.tgz
apt install python3-pip
y
pip3 install kafka-python
wget http://apache.lauf-forum.at/flink/flink-1.4.2/flink-1.4.2-bin-hadoop28-scala_2.11.tgz
tar -xvf flink-1.4.2-bin-hadoop28-scala_2.11.tgz

git clone https://github.com/aakashk2910/kafka-elasticsearch-jar.git
mv -r kafka-elasticsearch-jar/target/kafka-connect-elasticsearch-3.2.0-SNAPSHOT-package/share/java/kafka-connect-elasticsearch/ kafka_2.12-1.1.0/libs/

ufw enable

ufw allow 22

iptables -I INPUT -p tcp -m tcp --dport 3000 -j ACCEPT