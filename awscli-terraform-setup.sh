#!/bin/bash

# Update system packages
yum update -y

# Set hostname
hostnamectl set-hostname terraserver

# Install essential packages
yum install -y vim wget tar make unzip

# Change to /opt directory
cd /opt

# Download and install Terraform
TERRAFORM_VERSION="1.11.0-alpha20241106"
wget https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
terraform --version

# Download and install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -f awscliv2.zip
aws --version

echo "Setup complete!"
