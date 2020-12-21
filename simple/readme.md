# Simplest Elastic Stack 1ES and 1KB

## Description

Theses files create a simple Elasticsearch cluster in ECK with a single Kibana.

## Instructions

Execute in this order:

* `up.sh` start the `elasticsearch-simple` cluster, it will be available on [https://localhost:9205] and a single Kibana it will be available on [https://localhost:5602]

## Miscellaneous

`job-filebeat-setup.yaml` is a Kubernetes Job manifest to setup filebeat on the cluster. 