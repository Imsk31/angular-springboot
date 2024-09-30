#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e

# Creating OIDC Provider for cluster
cluster_name=msd
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
echo $oidc_id
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve

# Install AWS Load Balancer Controller with manifests
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/install/iam_policy.json

# Check if the IAM policy already exists
if aws iam get-policy --policy-arn arn:aws:iam::891377175977:policy/AWSLoadBalancerControllerIAMPolicy 2>/dev/null; then
    echo "Policy AWSLoadBalancerControllerIAMPolicy already exists."
else
    aws iam create-policy \
        --policy-name AWSLoadBalancerControllerIAMPolicy \
        --policy-document file://iam_policy.json
fi

eksctl create iamserviceaccount \
  --cluster=$cluster_name \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::891377175977:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.13.5/cert-manager.yaml
curl -Lo v2_7_2_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.7.2/v2_7_2_full.yaml
sed -i.bak -e '612,620d' ./v2_7_2_full.yaml
sed -i.bak -e 's|your-cluster-name|msd|' ./v2_7_2_full.yaml
kubectl apply -f v2_7_2_full.yaml
curl -Lo v2_7_2_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.7.2/v2_7_2_ingclass.yaml
kubectl apply -f v2_7_2_ingclass.yaml
kubectl get deployment -n kube-system aws-load-balancer-controller
