#!/bin/bash
sudo apt update -y
sudo apt install -y docker.io git default-jre ruby wget unzip
cd /home/ubuntu
wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
chmod u+x ./install
sudo ./install auto
rm -rf ./install
cat > /etc/init.d/codedeploy-start.sh << EOF
#!/bin/bash 
sudo service codedeploy-agent restart
sudo systemctl restart docker
EOF
sudo chmod +x /etc/init.d/codedeploy-start.sh
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install