kubectl config set-context kind-elastic

kubectl port-forward service/monitoring-cluster-es-http  9201   > /dev/null 2>&1 &

PASSWORD=$(kubectl get secret monitoring-cluster-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "Password for monitoring elasticsearch is: $PASSWORD"

kubectl port-forward service/monitoring-kibana-kb-http 5602:5601  > /dev/null 2>&1 &

echo "----"
echo "Connect to Kibana at: \"https://localhost:5602\""
echo "----"