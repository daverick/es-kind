# CCR on ECK for filebeat!

## Description

Theses files create two Elasticsearch clusters in the same ECK, allow remote cluster between them. Some `_ccr/auto_follow`  are set up on filebeat indices.
Some k8s jobs allow filebeat to be setup ilm, templates and so on.
One ILM bootstrap need to be done on one cluster

## Instructions

Execute in this order:

* `up-1.sh` start the first cluster and its Kibana
* `up-2.sh` start the second cluster and its Kibana
* `load.sh` that loads in their respectives clusters the `_ccr/auto_follow` objets needed
* `kubectl apply -f job-filebeat-setup-1.yaml` to create and run the job that will setup filebeat against the 1st cluster
* `kubectl apply -f job-filebeat-setup-2.yaml` to create and run the job that will setup filebeat against the 2nd cluster
* execute the following on the second cluster to bootstrap the ilm on the second cluster ( the filebeat setup has not done it as the alias already exists thanks to the CCR ):

```JSON
PUT %3Cfilebeat-7.10.0-%7Bnow%2Fd%7D-000001%3E
{
  "aliases": {
    "filebeat-7.10.0": {
      "is_write_index": true
    }
  }
}
```

## other solution

instead of activating the `_ccr/auto_follow` and execute Filebeat's setup, the setup can then be made first, and then the `_ccr/auto_follow` rules created.

In that case the indices already created have to been followed manually:

```JSON
PUT /two-filebeat-7.10.0-2020.12.04-000001/_ccr/follow?wait_for_active_shards=1
{
  "remote_cluster" : "cluster-two",
  "leader_index" : "filebeat-7.10.0-2020.12.04-000001"
}
````

