#!/bin/bash

# Exit the script on any error
set -e

# Restart the chronyd service
echo "Restarting chronyd service..."
sudo systemctl restart chronyd

# Define variables
CLUSTER_NAME="dev-eks"
REGION="ap-south-1"
ZONES="ap-south-1a,ap-south-1b"
NODE_GROUP_NAME="dev-eks-ng-public1"
NODE_TYPE="t3.medium"
MIN_NODES=2
MAX_NODES=4
NODE_VOLUME_SIZE=20
SSH_PUBLIC_KEY="dev-eks"

# Step 1: Create EKS Cluster Control Plane
echo "Creating EKS Cluster Control Plane..."
eksctl create cluster \
    --name=${CLUSTER_NAME} \
    --region=${REGION} \
    --zones=${ZONES} \
    --without-nodegroup

# Step 2: Associate IAM OIDC Provider
echo "Associating IAM OIDC Provider..."
eksctl utils associate-iam-oidc-provider \
    --region=${REGION} \
    --cluster=${CLUSTER_NAME} \
    --approve

# Step 3: Create Public Node Group
echo "Creating Public Node Group..."
eksctl create nodegroup \
    --cluster=${CLUSTER_NAME} \
    --region=${REGION} \
    --name=${NODE_GROUP_NAME} \
    --node-type=${NODE_TYPE} \
    --nodes=${MIN_NODES} \
    --nodes-min=${MIN_NODES} \
    --nodes-max=${MAX_NODES} \
    --node-volume-size=${NODE_VOLUME_SIZE} \
    --ssh-access \
    --ssh-public-key=${SSH_PUBLIC_KEY} \
    --managed \
    --asg-access \
    --external-dns-access \
    --full-ecr-access \
    --appmesh-access \
    --alb-ingress-access

echo "EKS Cluster setup complete!"
