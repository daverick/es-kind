# LDAP config for a cluster in ECK

## Description

Theses files create a simple Elasticsearch cluster in ECK with ldap authentication against [ldap.forumsys.com, an online ldap test server](https://www.forumsys.com/tutorials/integration-how-to/ldap/online-ldap-test-server/).

## Instructions

Execute in this order:

* `up.sh` start the `elasticsearch-ldap` cluster, it will be available on [https://localhost:9204]
* `load.sh` that loads a scientist role, a role mapping and a index in the cluster

## Test it!

`newton` is a scientist so he can search `science*` but not `gauss`

```bash
curl -k -u newton:password -XGET https://localhost:9204/science\*
{"science42":{"aliases":{},"mappings":{},"settings":{"index":{"routing":{"allocation":{"include":{"_tier_preference":"data_content"}}},"number_of_shards":"1","provided_name":"science42","creation_date":"1608144231134","number_of_replicas":"1","uuid":"5PSKNLnmQkGe4vT4TnUiqA","version":{"created":"7100099"}}}}}

curl -k -u gauss:password -XGET https://localhost:9204/science\* 
{"error":{"root_cause":[{"type":"security_exception","reason":"action [indices:admin/get] is unauthorized for user [gauss]"}],"type":"security_exception","reason":"action [indices:admin/get] is unauthorized for user [gauss]"},"status":403}
```

## note on the secret `my-ldap`

To create the secret that will contain the `secure_bind_password` it is not sufficient to encode it in base64 as a special character is needed at the end.
The following command can be used to create the secret:

```bash
kubectl create secret generic my-ldap-new --from-literal=xpack.security.authc.realms.ldap.my-ldap.secure_bind_password=password
```

and you can recover the necessary value to put in yaml file with:

```bash
kubectl get secret my-ldap -o=jsonpath='{.data}'
```
