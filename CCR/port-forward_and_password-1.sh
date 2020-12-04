kubectl config set-context kind-elastic

kubectl port-forward service/elasticsearch-1-es-http 9201:9200   > /dev/null 2>&1 &

PASSWORD=$(kubectl get secret elasticsearch-1-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "Password for elasticsearch-1 is: $PASSWORD"

echo "----"
echo "Connect to Elasticsearch-1 with:"
echo "curl -u \"elastic:$PASSWORD\" -k \"https://localhost:9201\""
echo "----"

kubectl port-forward service/kibana-1-kb-http 5611:5601  > /dev/null 2>&1 &

echo "----"
echo "Connect to Kibana at: \"https://localhost:5611\""
echo "----"