#!/usr/local/bin/bash

echo "Deleting a kind cluster named elastic..."
./kind delete cluster --name elastic

echo "Creating a kind cluster named elastic..."
./kind create cluster --config kind-config.yaml --name elastic

echo "Applying ECK operator 1.3 ..."
kubectl apply -f eck-operator-1.3.yaml 

kubectl wait --timeout=60s --for condition=ready pod --selector='control-plane=elastic-operator' --namespace elastic-system

echo "Applying elasticsearch.yaml ..."
kubectl apply -f elasticsearch.yaml 

sleep 2

echo "Waiting for elasticsearch to be ready... ⏳🚦"
ATTEMPTS=0
ES_STATUS_CMD="kubectl get  elasticsearch elasticsearch -o=jsonpath={.status.health}"
until [ "$($ES_STATUS_CMD)" = "green" ] || [ $ATTEMPTS -eq 60 ]; do
  ATTEMPTS=$((attempts + 1))
  sleep 10
  echo "Waiting for elasticsearch to be ready..."
done

echo "putting a trial license..."
./put-a-trial-license.sh

echo "Applying kibana.yaml ..."

kubectl apply -f kibana.yaml

sleep 2

echo "Waiting for Kibana to be ready... ⏳🚦"
ATTEMPTS=0
KB_STATUS_CMD="kubectl get  kibana kibana -o=jsonpath={.status.health}"
until [ "$($KB_STATUS_CMD)" = "green" ] || [ $ATTEMPTS -eq 60 ]; do
  ATTEMPTS=$((attempts + 1))
  sleep 10
  echo "Waiting for Kibana  to be ready..."
done

echo "Getting password and creatin port-forward ..."
./port-forward_and_password.sh

echo "Applying stack-monitoring.yaml ..."
kubectl apply -f stack-monitoring.yaml

echo "Applying heartbeat.yaml ..."
kubectl apply -f heartbeat.yaml

echo "Applying metricbeat.yaml ..."
kubectl apply -f metricbeat.yaml
