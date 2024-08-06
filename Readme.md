# Elastic stack on kind with ECK

## Requirements

* Docker
* Install [kind](https://kind.sigs.k8s.io) in this folder.
* Have `crds.yaml` from [https://download.elastic.co/downloads/eck/2.13.0/crds.yaml] and `operator.yaml` from [https://download.elastic.co/downloads/eck/2.13.0/operator.yaml] in this folder ( you can use:
  ```bash
  curl https://download.elastic.co/downloads/eck/2.13.0/operator.yaml -o operator.yaml
  curl https://download.elastic.co/downloads/eck/2.13.0/crds.yaml -o crds.yaml
  ```
   to download them).

## Usage

[`./up.sh`](./up.sh) spin up everything

[`.downn.sh`](./down.sh) destroy everything (in fact only the kind cluster ;-) )
