apt-get install 
y
apt install nodejs
y
apt install npm
y
iptables -I INPUT -p tcp -m tcp --dport 3000 -j ACCEPT
git clone https://github.com/aakashk2910/iot_app.git
cd iot_app
npm install
npm start