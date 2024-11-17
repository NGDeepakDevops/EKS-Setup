#!/bin/bash

# Check if the user is running the script as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit 1
fi

# Define the eksctl version and URL
EKSCTL_VERSION="v0.194.0"
EKSCTL_URL="https://github.com/eksctl-io/eksctl/releases/download/$EKSCTL_VERSION/eksctl_Linux_amd64.tar.gz"

echo "Downloading eksctl version $EKSCTL_VERSION..."

# Download eksctl package
wget $EKSCTL_URL -O /tmp/eksctl_Linux_amd64.tar.gz

# Check if wget succeeded
if [ $? -ne 0 ]; then
    echo "Download failed. Exiting..."
    exit 1
fi

# Extract the tar file
echo "Extracting eksctl package..."
tar -xvzf /tmp/eksctl_Linux_amd64.tar.gz -C /tmp

# Move the extracted binary to a directory in your PATH
echo "Moving eksctl binary to /usr/local/bin..."
sudo mv /tmp/eksctl /usr/local/bin

# Clean up the downloaded tar file
rm -f /tmp/eksctl_Linux_amd64.tar.gz

# Verify eksctl version
echo "Verifying eksctl version..."
eksctl version

echo "eksctl installation complete!"

