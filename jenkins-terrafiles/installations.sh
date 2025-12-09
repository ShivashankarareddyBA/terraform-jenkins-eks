#!/bin/bash
set -e

echo "=== Updating system ==="
sudo apt update -y
sudo apt upgrade -y

########################################
# Install Jenkins
########################################
echo "=== Installing Jenkins ==="

# Install Java (required by Jenkins)
sudo apt install -y fontconfig openjdk-17-jre
# or we can also run sudo apt install openjdk-24-jdk -y

# Add Jenkins repo
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Jenkins installed."

########################################
# Install Git
########################################
echo "=== Installing Git ==="
sudo apt install -y git
echo "Git installed."

########################################
# Install Terraform
########################################
echo "=== Installing Terraform ==="

sudo apt install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update -y
sudo apt install -y terraform

echo "Terraform installed."

########################################
# Install kubectl
########################################
echo "=== Installing kubectl ==="

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

echo "kubectl installed."

echo "=== All tools installed successfully! ==="
