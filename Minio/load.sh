#!/bin/bash


PASSWORD=$(kubectl get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

./git2es.sh elasticsearch https://localhost:9200 -k -u elastic:"$PASSWORD"

