#!/usr/bin/bash
AWS_DEFAULT_REGION=us-east-1


PASS=$(aws ecr get-login-password --region us-east-1)
kubectl create secret docker-registry aws-ecr-us-east-1 \
    --docker-server=$AWS-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$PASS \
    --namespace argocd