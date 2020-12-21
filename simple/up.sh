#!/usr/local/bin/bash
echo "Applying elasticsearch-simple.yaml ..."
kubectl apply -f elasticsearch-simple.yaml 

sleep 2

echo "Waiting for elasticsearch-simple to be ready... ⏳🚦"
ATTEMPTS=0
ES_STATUS_CMD="kubectl get  elasticsearch elasticsearch-simple -o=jsonpath={.status.health}"
until [ "$($ES_STATUS_CMD)" = "green" ] || [ $ATTEMPTS -eq 60 ]; do
  ATTEMPTS=$((attempts + 1))
  sleep 10
  echo "Waiting for elasticsearch-simple to be ready..."
done


echo "Applying kibana.yaml ..."

kubectl apply -f kibana-simple.yaml

sleep 2

echo "Waiting for Kibana-simple to be ready... ⏳🚦"
ATTEMPTS=0
KB_STATUS_CMD="kubectl get  kibana kibana-simple -o=jsonpath={.status.health}"
until [ "$($KB_STATUS_CMD)" = "green" ] || [ $ATTEMPTS -eq 60 ]; do
  ATTEMPTS=$((attempts + 1))
  sleep 10
  echo "Waiting for Kibana-simple  to be ready..."
done


echo "Getting password and creatin port-forward ..."
./port-forward_and_password.sh
