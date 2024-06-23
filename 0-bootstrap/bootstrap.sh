#!/bin/bash

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f 0-bootstrap/core-project.yaml
kubectl apply -f 0-bootstrap/core-application.yaml
