---
title: "使用专用 KubeConfig 访问子集群"
description: "了解如何为子集群构建专用的 KubeConfig"
date: 2022-01-17
draft: false
weight: 3
---

Before moving forward, please follow [this guide](/docs/configuration/aggregator-forwarding-redirect/) to make sure
that redirecting requests by `clusternet-hub` are supported in your parent cluster.

您需要按照以下 **2 个步骤** 来构建专用 kubeconfig 来使用 `kubectl` 访问子集群。

## 步骤一: 修改服务器地址

在`/apis/proxies.clusternet.io/v1alpha1/sockets/<CLUSTER-ID>/proxy/https/<SERVER-URL>`
或者`/apis/proxies.clusternet.io/v1alpha1/sockets/<CLUSTER-ID>/proxy/direct` 在**parent cluster**的末尾
附加服务器地址

- `CLUSTER-ID` 是您的子集群的 UUID，由 `clusternet-agent` 自动填充，例如 dc91021d-2361-4f6d-a404-7c33b9e01118。您可以从 ClusterRegistrationRequest，ManagedCluster等资源对象中获取此 UUID。这个 UUID 也以键值为 clusters.clusternet.io/cluster-id 的标签存在。

- `SERVER-URL` 是你的子集群的 apiserver 地址，它可以是 `localhost`、`127.0.0.1` 等等，前提是
   `clusternet-agent` 可以访问。

您可以按照以下命令帮助修改上述更改。

```bash
$ # 假设您的父集群kubeconfig位于 /home/demo/.kube/config.parent
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
$ # 假设您的子集群在 https://demo1.cluster.net 运行
$ kubectl config set-cluster `kubectl config get-clusters | grep -v NAME` \
  --server=https://10.0.0.10:6443/apis/proxies.clusternet.io/v1alpha1/sockets/dc91021d-2361-4f6d-a404-7c33b9e01118/proxy/https/demo1.cluster.net
$ # 或者只使用直接代理路径
$ kubectl config set-cluster `kubectl config get-clusters | grep -v NAME` \
  --server=https://10.0.0.10:6443/apis/proxies.clusternet.io/v1alpha1/sockets/dc91021d-2361-4f6d-a404-7c33b9e01118/proxy/direct
```

{{% alert title="Note" color="primary" %}}
Clusternet 支持 http 和 https 方案。

如果你想使用方案`http`来演示它是如何工作的，即`/apis/proxies.clusternet.io/v1alpha1/sockets/<CLUSTER-ID>/proxy/http/<SERVER-URL>`，
您可以简单地***在您的子集群中运行本地代理***，例如，

```bash
kubectl proxy --address='10.212.0.7' --accept-hosts='^*$'
```

请将 `10.212.0.7` 替换为您的真实本地IP地址。

然后也按照上面的 url 修改。
{{% /alert %}}

## 步骤 2：从子集群配置凭证

然后使用**来自子集群的凭据**更新用户条目。

{{% alert title="Note" color="info" %}}
`Clusternet-hub` 根本不关心这些凭据，直接将它们传递给子集群。
{{% /alert %}}

### 如果您使用令牌

这里的令牌可以是 [bootstrap tokens](https://kubernetes.io/docs/reference/access-authn-authz/bootstrap-tokens/),
[ServiceAccount tokens](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-multiple-service-accounts)
,等等。

请按照以下修改。

```bash
$ export KUBECONFIG=`pwd`/config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
$ # 以下是我们在上述步骤 1 中修改的内容
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
$ # 照下面的方式修改用户部分
$ vim config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
  ...
  user:
    username: system:anonymous
    as: clusternet
    as-user-extra:
        clusternet-token:
            - BASE64-DECODED-PLEASE-CHANGE-ME
```

请将 `BASE64-DECODED-PLEASE-CHANGE-ME` 替换为对**子集群**有效的令牌。 ***请注意此处替换的令牌应经过 base64 解码。***

{{% alert title="Important Note" color="primary" %}}
如果不允许匿名身份验证，请将 `username: system:anonymous` 替换为 `token: PARENT-CLUSTER-TOKEN`。
在这里，可以使用以下命令检索 `PARENT-CLUSTER-TOKEN`，

```bash
kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="clusternet-hub-proxy")].data.token}' | base64 --decode; echo
```
{{% /alert %}}

### 如果您使用 TLS 证书

请按照以下修改。

```bash
$ export KUBECONFIG=`pwd`/config-cluster-dc91021d-2361-4f6d-a404-7c33b9e01118
$ # 以下是我们在上述步骤 1 中修改的内容
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
$ # 照下面的方式修改用户部分
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

请替换 `CLIENT-CERTIFICATE-DATE-BASE64-ENCODED-PLEASE-CHANGE-ME`
以及带有来自子集群的证书和私钥的“CLIENT-KEY-DATE-PLEASE-BASE64-ENCODED-CHANGE-ME”。 **请注意这里替换的标记应该是base64编码的。**

{{% alert title="Important Note" color="primary" %}}
如果不允许匿名身份验证，请将 `username: system:anonymous` 替换为 `token: PARENT-CLUSTER-TOKEN`。
在这里，可以使用以下命令检索 `PARENT-CLUSTER-TOKEN`，

```bash
kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="clusternet-hub-proxy")].data.token}' | base64 --decode; echo
```
{{% /alert %}}
