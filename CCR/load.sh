#!/bin/bash


PASSWORD=$(kubectl get secret elasticsearch-1-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

./git2es.sh cluster-one https://localhost:9201 -k -u elastic:"$PASSWORD"

PASSWORD=$(kubectl get secret elasticsearch-2-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

./git2es.sh cluster-two https://localhost:9202 -k -u elastic:"$PASSWORD"