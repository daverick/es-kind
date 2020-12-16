#!/bin/bash


PASSWORD=$(kubectl get secret elasticsearch-ldap-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

./git2es.sh elasticsearch-ldap https://localhost:9204 -k -u elastic:"$PASSWORD"
