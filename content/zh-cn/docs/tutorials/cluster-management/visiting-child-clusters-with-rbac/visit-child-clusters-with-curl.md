---
title: "使用curl访问子集群"
description: "了解如何使用curl访问您的子集群"
date: 2022-01-17
draft: false
weight: 2
---

下面是一个简单的片段，展示了如何使用`curl`列出子集群中的命名空间。

```bash
PARENTCLUSTERAUTH="Basic system:anonymous"
```

如果不允许匿名身份验证，则

```bash
PARENTCLUSTERTOKEN=`kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="clusternet-hub-proxy")].data.token}' | base64 --decode`
PARENTCLUSTERAUTH="Bearer ${PARENTCLUSTERTOKEN}"
```

## 如果您使用令牌

```bash
# 此处的令牌经过 base64 解码，来自您的子集群。 （请记得替换！！！）
CHILDCLUSTERTOKEN="TOKEN-BASE64-DECODED-IN-YOUR-CHILD-CLUSTER"
# 指定子集群 ID（请记得替换！！！）
CHILDCLUSTERID="dc91021d-2361-4f6d-a404-7c33b9e01118"
# 父集群 APIServer 地址（请记得替换！！！）
APISERVER="https://10.0.0.10:6443"
curl -k -XGET  -H "Accept: application/json" \
  -H "Impersonate-User: clusternet" \
  -H "Authorization: ${PARENTCLUSTERAUTH}" \
  -H "Impersonate-Extra-Clusternet-Token: ${CHILDCLUSTERTOKEN}" \
  "${APISERVER}/apis/proxies.clusternet.io/v1alpha1/sockets/${CHILDCLUSTERID}/proxy/direct/api/v1/namespaces"
```

## 如果您使用 TLS 证书

```bash
# 来自您的子集群的 base64 编码证书。 （请记得替换！！！）
CHILDCLUSTERCERT="CERTIFICATE-BASE64-ENCODED-IN-YOUR-CHILD-CLUSTER"
# 来自子集群的 base64 编码私钥。 （请记得替换！！！）
CHILDCLUSTERKEY="PRIVATEKEY-BASE64-ENCODED-IN-YOUR-CHILD-CLUSTER"
# 指定子集群 ID（请记得替换！！！）
CHILDCLUSTERID="dc91021d-2361-4f6d-a404-7c33b9e01118"
# 父集群 APIServer 地址（请记得替换！！！）
APISERVER="https://10.0.0.10:6443"
curl -k -XGET  -H "Accept: application/json" \
  -H "Impersonate-User: clusternet" \
  -H "Authorization: ${PARENTCLUSTERAUTH}" \
  -H "Impersonate-Extra-Clusternet-Certificate: ${CHILDCLUSTERCERT}" \
  -H "Impersonate-Extra-Clusternet-PrivateKey: ${CHILDCLUSTERKEY}" \
  "${APISERVER}/apis/proxies.clusternet.io/v1alpha1/sockets/${CHILDCLUSTERID}/proxy/direct/api/v1/namespaces"
```
