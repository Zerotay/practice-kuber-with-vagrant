#!/bin/bash

swapoff -a && sed -i '/swap/s/^/#/' /etc/fstab
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat <<EOF>>  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
cat << EOF | sudo tee -a /etc/hosts
192.168.32.10 k8s-master
192.168.32.11 k8s-node01
192.168.32.12 k8s-node02
EOF
# 기본 라이브러리 설치
apt update && apt -y install ca-certificates curl gnupg net-tools
# gpg 키 등록
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 10
# 레포지토리 추가
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# 도커 엔진 설치
apt update && apt install -y docker-ce docker-ce-cli containerd.io
# 도커 서비스 등록
systemctl enable docker
sleep 10
useradd dockeradmin
usermod -aG docker dockeradmin
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose -version

