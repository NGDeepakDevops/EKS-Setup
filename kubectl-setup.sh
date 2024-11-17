#kubectl install and setup

vim kubectl-setup.sh 

#!/bin/bash

# Step 1: Create a directory for kubectl binary under /opt
mkdir -p /opt/kubectlbinary

# Step 2: Change into the /opt/kubectlbinary directory
cd /opt/kubectlbinary

# Step 3: List contents (optional)
ll

# Step 4: Download kubectl binary
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl

# Step 5: Make kubectl executable
chmod +x ./kubectl

# Step 6: Copy kubectl to $HOME/bin and update PATH
mkdir -p $HOME/bin
cp ./kubectl $HOME/bin/kubectl
export PATH=$PATH:$HOME/bin

# Step 7: Add PATH export to .bash_profile for persistence
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile

# Step 8: Verify kubectl version (without --short)
kubectl version --client

# Step 9: Display AWS caller identity (to verify AWS CLI access)
aws sts get-caller-identity
