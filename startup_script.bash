#! /bin/bash

# Install dependencies from apt
sudo apt update -y
sudo apt install git -y

mkdir /app
cd /app

# Install nodejs
mkdir /opt/nodejs
curl https://nodejs.org/dist/v8.12.0/node-v8.12.0-linux-x64.tar.gz | tar xvzf - -C /opt/nodejs --strip-components=1
ln -s /opt/nodejs/bin/node /usr/bin/node
ln -s /opt/nodejs/bin/npm /usr/bin/npm

#Install SQL Proxy
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy

#Initialize the Cloud SQL instance
./cloud_sql_proxy -instances="stone-door-258502:us-west1:instance2"=tcp:3306 &

# Get the application source code
git clone https://github.com/stashconsulting/nodejsdemo.git
cd ./nodejsdemo/

# Install app dependencies
npm install

#run app
node app.js &
