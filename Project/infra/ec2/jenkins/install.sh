#!/bin/bash
sudo apt update -y
sudo apt install -y zip
cd /home/ubuntu
git clone https://github.com/s4616/jenkins_Scripts.git
mkdir jenkins
cd jenkins_Scripts
chmod u+x install-docker.sh
chmod u+x install-docker-compose.sh
./install-docker.sh
./install-docker-compose.sh
docker-compose up -d --build