#!/bin/bash

# AWS CLI Configuration and Test Script

echo "Starting AWS CLI Configuration..."

# Prompt for AWS credentials and configuration
read -p "Enter your AWS Access Key ID: " AWS_ACCESS_KEY_ID
read -p "Enter your AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
read -p "Enter your Default Region (e.g., ap-south-1): " AWS_DEFAULT_REGION
read -p "Enter your Preferred Output Format (json, text, or table): " AWS_OUTPUT_FORMAT

# Configure AWS CLI with provided details
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_DEFAULT_REGION
aws configure set output $AWS_OUTPUT_FORMAT

# Verification step
echo -e "\nAWS CLI has been configured with the following details:"
echo "------------------------------------------------------"
echo "AWS Access Key ID: $AWS_ACCESS_KEY_ID"
echo "AWS Secret Access Key: (hidden)"
echo "Region: $AWS_DEFAULT_REGION"
echo "Output Format: $AWS_OUTPUT_FORMAT"
echo "------------------------------------------------------"

# Test the configuration by listing all S3 buckets
echo -e "\nTesting AWS CLI configuration by listing S3 buckets..."
aws s3 ls

# Check if the aws command was successful
if [ $? -eq 0 ]; then
    echo "AWS CLI configuration is working correctly!"
else
    echo "There was an error with AWS CLI configuration. Please check your credentials and try again."
fi

