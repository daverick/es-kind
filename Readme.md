# Elastic stack on kind with ECK

## Requirements

* Install [kind](https://kind.sigs.k8s.io) in this folder. Tested with kind version 0.11.1 .
* Having Docker. Tested with Docker version 19.03.12->20.10.7.
* Have `eck-operator-1.5.yaml` in this folder ( from https://download.elastic.co/downloads/eck/1.5.0/all-in-one.yaml)

Tested on MacOS Catalina 10.15.6->11.6

## Usage

[`./up.sh`](./up.sh) spin up everything

[`.downn.sh`](./down.sh) destroy everything (in fact only the kind cluster ;-) )

## Limitations

* What is inside the kind cluster do not support docker to be restarted (some network stuff).

## 'Interesting' things

The [`stack-monitoring.yaml`](./stack-monitoring.yaml) is based on [ECK beats stack monitoring doc examples](https://github.com/elastic/cloud-on-k8s/blob/master/config/recipes/beats/stack_monitoring.yaml) but it has been tuned to use k8s annotations and k8s labels to only monitor the stack elements.

## Upgrade operator

* update the `up.sh` to use the operator 1.3.0 
* `up.sh`
* annotate some ressources to exclude them from the upgrade (in fact not managed by the operator) like for example `kubectl annotate --overwrite elasticsearch elasticsearch 'eck.k8s.elastic.co/managed=false'`
* `kubectl apply -f eck-operator-1.5.yaml` => all the non elasticsearch pods are restarted! some are crashlooping! but they get back after the kibana are restarted?
* allow the elasticsearch to be managed by ECK:`kubectl annotate --overwrite elasticsearch elasticsearch 'eck.k8s.elastic.co/managed=true'`

