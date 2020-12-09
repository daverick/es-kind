# Minio and Searchable Snapshot (on es-kind)

## Description

Theses files create a Minio service in Kubernetes, and Elasticsearch objects are loaded to demo searchable snapshots.

## Instructions

Execute in this order:

* `up Minio.sh` start a Minio service in Kubernetes
* `load.sh` load snapshots repository, slm, ilm, components templates and index templates in the Elasticsearch cluster

## Demo script

```JSON

# A more reactive ILM ;-)
PUT /_cluster/settings
{
  "transient": {
    "indices.lifecycle.poll_interval":"1s"
    }
}

# Clean up
DELETE _data_stream/data-tier-test

# create a data stream and their index
POST data-tier-test/_doc
{
  "toto" : "is here!",
  "@timestamp": "2020-12-10T11:04:05.000Z"
}

# have a look at the evolution of the data stream indices
GET _cat/indices/*data-tier-test*

# Clean up!!! ( it generates a index every minutes!)
DELETE _data_stream/data-tier-test
```