kubectl config set-context kind-elastic

kubectl port-forward service/elasticsearch-simple-es-http 9205:9200  > /dev/null 2>&1 &

PASSWORD=$(kubectl get secret elasticsearch-simple-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "Password for elasticsearch-simple is: $PASSWORD"

echo "----"
echo "Connect to Elasticsearch-simple with:"
echo "curl -u \"elastic:$PASSWORD\" -k \"https://localhost:9205\""
echo "----"

kubectl port-forward service/kibana-simple-kb-http 5602:5601  > /dev/null 2>&1 &

echo "----"
echo "Connect to Kibana at: \"https://localhost:5602\""
echo "----"
