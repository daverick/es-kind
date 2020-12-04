#!/usr/local/bin/bash


echo "Applying elasticsearch.yaml ..."
kubectl apply -f elasticsearch-2.yaml 

sleep 2

echo "Waiting for elasticsearch-2 to be ready... ⏳🚦"
ATTEMPTS=0
ES_STATUS_CMD="kubectl get  elasticsearch elasticsearch-2 -o=jsonpath={.status.health}"
until [ "$($ES_STATUS_CMD)" = "green" ] || [ $ATTEMPTS -eq 60 ]; do
  ATTEMPTS=$((attempts + 1))
  sleep 10
  echo "Waiting for elasticsearch-2 to be ready..."
done



echo "Applying kibana-2.yaml ..."

kubectl apply -f kibana-2.yaml

sleep 2

echo "Waiting for Kibana-2 to be ready... ⏳🚦"
ATTEMPTS=0
KB_STATUS_CMD="kubectl get  kibana kibana-2 -o=jsonpath={.status.health}"
until [ "$($KB_STATUS_CMD)" = "green" ] || [ $ATTEMPTS -eq 60 ]; do
  ATTEMPTS=$((attempts + 1))
  sleep 10
  echo "Waiting for Kibana  to be ready..."
done

echo "Getting password and creatin port-forward ..."
./port-forward_and_password-2.sh
