---
title: "Visiting Child Clusters with Dedicated KubeConfig"
description: "Learn how to construct a dedicated KubeConfig for a child cluster"
date: 2022-01-17
draft: false
weight: 3
---

You need to follow below **2 steps** to construct a dedicated kubeconfig to access a child cluster with `kubectl`.

## Step 1: Modify Server URL

Append `/apis/proxies.clusternet.io/v1alpha1/sockets/<CLUSTER-ID>/proxy/https/<SERVER-URL>`
or `/apis/proxies.clusternet.io/v1alpha1/sockets/<CLUSTER-ID>/proxy/direct` at the end of original **parent cluster**
server address

- `CLUSTER-ID` is a UUID for your child cluster, which is auto-populated by `clusternet-agent`, such as dc91021d-2361-4f6d-a404-7c33b9e01118. You could get this UUID from objects `ClusterRegistrationRequest`,
  `ManagedCluster`, etc. Also this UUID is labeled with key `clusters.clusternet.io/cluster-id`.

- `SERVER-URL` is the apiserver address of your child cluster, it could be `localhost`, `127.0.0.1` and etc, only if
  `clusternet-agent` could access.

You can follow below commands to help modify above changes.

```bash
$ # suppose your parent cluster kubeconfig locates at /home/demo/.kube/config.parent
$ kubectl config view --kubeconfig=/home/demo/.kube/config.parent --minify=true --raw=true > ./config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
$
$ export KUBECONFIG=`pwd`/config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://10.0.0.10:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
$
$ # suppose your child cluster running at https://demo1.cluster.net
$ kubectl config set-cluster `kubectl config get-clusters | grep -v NAME` \
  --server=https://10.0.0.10:6443/apis/proxies.clusternet.io/v1alpha1/sockets/dc91021d-2361-4f6d-a404-7c33b9e01118/proxy/https/demo1.cluster.net
$ # or just use the direct proxy path
$ kubectl config set-cluster `kubectl config get-clusters | grep -v NAME` \
  --server=https://10.0.0.10:6443/apis/proxies.clusternet.io/v1alpha1/sockets/dc91021d-2361-4f6d-a404-7c33b9e01118/proxy/direct
```

{{% alert title="Note" color="primary" %}}
Clusternet supports both http and https scheme.

If you want to use scheme `http` to demonstrate how it works, i.e. `/apis/proxies.clusternet.io/v1alpha1/sockets/<CLUSTER-ID>/proxy/http/<SERVER-URL>`,
you can simply ***run a local proxy in your child cluster***, for example,

```bash
kubectl proxy --address='10.212.0.7' --accept-hosts='^*$'
```

Please replace `10.212.0.7` with your real local IP address.

Then follow above url modification as well.
{{% /alert %}}

## Step 2: Configure Credentials from Child Clusters

Then update user entry with **credentials from child clusters**.

{{% alert title="Note" color="info" %}}
`Clusternet-hub` does not care about those credentials at all, passing them directly to child clusters.
{{% /alert %}}

### If you're using tokens

Here the tokens can be [bootstrap tokens](https://kubernetes.io/docs/reference/access-authn-authz/bootstrap-tokens/),
[ServiceAccount tokens](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-multiple-service-accounts)
, etc.

Please follow below modifications.

```bash
$ export KUBECONFIG=`pwd`/config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
$ # below is what we modified in above step 1
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://10.0.0.10:6443/apis/proxies.clusternet.io/v1alpha1/sockets/dc91021d-2361-4f6d-a404-7c33b9e01118/proxy/direct
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
$
$ # modify user part to below
$ vim config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
  ...
  user:
    username: system:anonymous
    as: clusternet
    as-user-extra:
        clusternet-token:
            - BASE64-DECODED-PLEASE-CHANGE-ME
```

Please replace `BASE64-DECODED-PLEASE-CHANGE-ME` to a token that valid from **child cluster**. ***Please notice the
tokens replaced here should be base64 decoded.***

{{% alert title="Important Note" color="primary" %}}
If anonymous auth is not allowed, please replace `username: system:anonymous` to `token: PARENT-CLUSTER-TOKEN`.
Here `PARENT-CLUSTER-TOKEN` can be retrieved with below command,

```bash
kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="clusternet-hub-proxy")].data.token}' | base64 --decode; echo
```
{{% /alert %}}

### If you're using TLS certificates

Please follow below modifications.

```bash
$ export KUBECONFIG=`pwd`/config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
$ # below is what we modified in above step 1
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://10.0.0.10:6443/apis/proxies.clusternet.io/v1alpha1/sockets/dc91021d-2361-4f6d-a404-7c33b9e01118/proxy/direct
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
$
$ # modify user part to below
$ vim config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
  ...
  user:
    username: system:anonymous
    as: clusternet
    as-user-extra:
        clusternet-certificate:
            - CLIENT-CERTIFICATE-DATE-BASE64-ENCODED-PLEASE-CHANGE-ME
        clusternet-privatekey:
            - CLIENT-KEY-DATE-PLEASE-BASE64-ENCODED-CHANGE-ME
```

Please replace `CLIENT-CERTIFICATE-DATE-BASE64-ENCODED-PLEASE-CHANGE-ME`
and `CLIENT-KEY-DATE-PLEASE-BASE64-ENCODED-CHANGE-ME` with certficate and private key from child cluster. **Please
notice the tokens replaced here should be base64 encoded.**

{{% alert title="Important Note" color="primary" %}}
If anonymous auth is not allowed, please replace `username: system:anonymous` to `token: PARENT-CLUSTER-TOKEN`.
Here `PARENT-CLUSTER-TOKEN` can be retrieved with below command,

```bash
kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="clusternet-hub-proxy")].data.token}' | base64 --decode; echo
```
{{% /alert %}}
