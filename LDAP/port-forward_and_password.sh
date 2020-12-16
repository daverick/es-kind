kubectl config set-context kind-elastic

kubectl port-forward service/elasticsearch-ldap-es-http 9204:9200  > /dev/null 2>&1 &

PASSWORD=$(kubectl get secret elasticsearch-ldap-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

echo "Password for elasticsearch-ldap is: $PASSWORD"

echo "----"
echo "Connect to Elasticsearch-ldap with:"
echo "curl -u \"elastic:$PASSWORD\" -k \"https://localhost:9204\""
echo "----"

