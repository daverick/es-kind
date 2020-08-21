kubectl config set-context kind-elastic

kubectl port-forward service/elasticsearch-es-http 9200   > /dev/null 2>&1 &

PASSWORD=$(kubectl get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "Password for elasticsearch is: $PASSWORD"

echo "----"
echo "Connect to Elasticsearch with:"
echo "curl -u \"elastic:$PASSWORD\" -k \"https://localhost:9200\""
echo "----"

kubectl port-forward service/kibana-kb-http 5601  > /dev/null 2>&1 &

echo "----"
echo "Connect to Kibana at: \"https://localhost:5601\""
echo "----"