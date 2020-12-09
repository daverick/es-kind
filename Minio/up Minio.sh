#!/usr/local/bin/bash

echo "Applying minio pvc ..."
kubectl apply -f minio-pvc.yaml 

echo "Applying minio.yml ..."
kubectl apply -f minio.yaml 

echo "Applying minio-svc.yml ..."
kubectl apply -f minio-svc.yaml 

echo "port-forwarding http://localhost:9000"
kubectl port-forward service/minio-service 9000 > /dev/null 2>&1 &
