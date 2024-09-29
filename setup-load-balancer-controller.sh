#!/bin/bash

# Variables
CLUSTER_NAME="msd"  # Replace with your EKS cluster name
NAMESPACE="kube-system"
SERVICE_ACCOUNT_NAME="aws-load-balancer-controller"

# Function to install Helm if not already installed
install_helm() {
    echo "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    if [ $? -ne 0 ]; then
        echo "Error installing Helm."
        exit 1
    fi
}

# Ensure Helm is installed
if ! command -v helm &> /dev/null; then
    echo "Helm not installed. Installing Helm..."
    install_helm
else
    echo "Helm is already installed."
fi

# Verify Helm installation
helm version

# Add the AWS Load Balancer Controller Helm repo if not added already
helm repo add eks https://aws.github.io/eks-charts

# Update the Helm repo
helm repo update

# Install or Upgrade AWS Load Balancer Controller
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --set clusterName="$CLUSTER_NAME" \
  --set serviceAccount.create=false \
  --set serviceAccount.name="$SERVICE_ACCOUNT_NAME" \
  -n $NAMESPACE

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "AWS Load Balancer Controller installed successfully."
else
    echo "Error installing AWS Load Balancer Controller."
    exit 1
fi

# Check the status of the deployment
kubectl get deployment aws-load-balancer-controller -n $NAMESPACE
