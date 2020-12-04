kubectl config set-context kind-elastic

kubectl port-forward service/elasticsearch-2-es-http 9202:9200   > /dev/null 2>&1 &

PASSWORD=$(kubectl get secret elasticsearch-2-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "Password for elasticsearch-2 is: $PASSWORD"

echo "----"
echo "Connect to Elasticsearch-2 with:"
echo "curl -u \"elastic:$PASSWORD\" -k \"https://localhost:9202\""
echo "----"

kubectl port-forward service/kibana-2-kb-http 5602:5601  > /dev/null 2>&1 &

echo "----"
echo "Connect to Kibana at: \"https://localhost:5602\""
echo "----"