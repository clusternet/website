---
title: "Visiting Child Clusters with curl"
description: "Learn how to use curl visiting your child clusters"
date: 2022-01-17
draft: false
weight: 2
---

Below is a simple snippet to show how to list namespaces in a child cluster with `curl`.

```bash
$ PARENTCLUSTERAUTH="Basic system:anonymous"
```

If anonymous auth is not allowed, then

```bash
$ PARENTCLUSTERTOKEN=`kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="clusternet-hub-proxy")].data.token}' | base64 --decode`
$ PARENTCLUSTERAUTH="Bearer ${PARENTCLUSTERTOKEN}"
```

## If you're using tokens

```bash
$ # Here the token is base64 decoded and from your child cluster. (PLEASE CHANGE ME!!!)
$ CHILDCLUSTERTOKEN="TOKEN-BASE64-DECODED-IN-YOUR-CHILD-CLUSTER"
$ # specify the child cluster id (PLEASE CHANGE ME!!!)
$ CHILDCLUSTERID="dc91021d-2361-4f6d-a404-7c33b9e01118"
$ # The Parent Cluster APIServer Address (PLEASE CHANGE ME!!!)
$ APISERVER="https://10.0.0.10:6443"
$ curl -k -XGET  -H "Accept: application/json" \
  -H "Impersonate-User: clusternet" \
  -H "Authorization: ${PARENTCLUSTERAUTH}" \
  -H "Impersonate-Extra-Clusternet-Token: ${CHILDCLUSTERTOKEN}" \
  "${APISERVER}/apis/proxies.clusternet.io/v1alpha1/sockets/${CHILDCLUSTERID}/proxy/direct/api/v1/namespaces"
```

## If you're using TLS certificates

```bash
$ # base64 encoded certificate from your child cluster. (PLEASE CHANGE ME!!!)
$ CHILDCLUSTERCERT="CERTIFICATE-BASE64-ENCODED-IN-YOUR-CHILD-CLUSTER"
$ # base64 encoded privatekey from your child cluster. (PLEASE CHANGE ME!!!)
$ CHILDCLUSTERKEY="PRIVATEKEY-BASE64-ENCODED-IN-YOUR-CHILD-CLUSTER"
$ # specify the child cluster id (PLEASE CHANGE ME!!!)
$ CHILDCLUSTERID="dc91021d-2361-4f6d-a404-7c33b9e01118"
$ # The Parent Cluster APIServer Address (PLEASE CHANGE ME!!!)
$ APISERVER="https://10.0.0.10:6443"
$ curl -k -XGET  -H "Accept: application/json" \
  -H "Impersonate-User: clusternet" \
  -H "Authorization: ${PARENTCLUSTERAUTH}" \
  -H "Impersonate-Extra-Clusternet-Certificate: ${CHILDCLUSTERCERT}" \
  -H "Impersonate-Extra-Clusternet-PrivateKey: ${CHILDCLUSTERKEY}" \
  "${APISERVER}/apis/proxies.clusternet.io/v1alpha1/sockets/${CHILDCLUSTERID}/proxy/direct/api/v1/namespaces"
```
