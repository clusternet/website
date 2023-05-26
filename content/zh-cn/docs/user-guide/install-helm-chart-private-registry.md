---
title: "从私有仓库安装Helm Charts"
date: 2022-10-12
draft: false
weight: 1
collapsible: false
---

此页面说明了如何将私有仓库中的Helm Chart部署到子集群。

使用[Secret](https://kubernetes.io/docs/concepts/configuration/secret/) 存储私有仓库的认证信息.

## 创建 Secret

在大多数的shell中，转义密码的最简单的方法是使用单引号将其括起来(`'`).例如, 如果您的密码是 `S!B\*d$zDsb=`, 
执行以下命令:

```shell
kubectl create ns my-system
kubectl create secret generic my-helm-repo -n my-system \
  --from-literal=username=devuser \
  --from-literal=password='S!B\*d$zDsb='
```

或者我们可以使用命令应用下面的yaml文件 `kubectl apply`,

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-helm-repo
  namespace: my-system
type: Opaque
stringData:
  password: S!B\*d$zDsb=
  username: devuser
```

## 创建一个使用您的Secret的helm chart

以下是一个示例的 `HelmChart`， 该chart使用存储在 `my-helm-repo`中的凭证访问私有仓库:

```yaml
apiVersion: apps.clusternet.io/v1alpha1
kind: HelmChart
metadata:
  name: mysql
  namespace: default
spec:
  repo: https://my.private.repo/registry
  chartPullSecret:
    name: my-helm-repo
    namespace: my-system
  chart: mysql
  version: 9.2.0
  targetNamespace: abc
```

之后您可以根据 [tutorials on multi-cluster applications](../../tutorials/multi-cluster-apps) 将这个`HelmChart` 部署到子集群之中.
