#!/usr/local/bin/bash
echo "Applying elasticsearch-ldap.yaml ..."
kubectl apply -f elasticsearch-ldap.yaml 

sleep 2

echo "Waiting for elasticsearch-ldap to be ready... ⏳🚦"
ATTEMPTS=0
ES_STATUS_CMD="kubectl get  elasticsearch elasticsearch-ldap -o=jsonpath={.status.health}"
until [ "$($ES_STATUS_CMD)" = "green" ] || [ $ATTEMPTS -eq 60 ]; do
  ATTEMPTS=$((attempts + 1))
  sleep 10
  echo "Waiting for elasticsearch-ldap to be ready..."
done


echo "Getting password and creatin port-forward ..."
./port-forward_and_password.sh
