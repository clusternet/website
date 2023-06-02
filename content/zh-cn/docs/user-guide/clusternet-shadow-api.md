---
title: "Clusternet 的资源创建"
description: "Clusternet 如何在单独的视图中管理资源"
date: 2022-10-18
draft: false
weight: 1
collapsible: false
---

此页面将展示 Clusternet 如何在单独的视图中管理 Kubernetes 集群内的资源。

Clusternet 设计为以组件化的形式部署到 Kubernetes 集群。
那么我们如何区分来自 `kube-apiserver` 创建的资源。
例如，当我们在 `kube-apiserver` 中创建一个 `Deployment` 时， Kubernetes 控制平面会收到通知，并创建出期望副本数的 pod。 
对于多集群管理，这种行为不是我们想要的，因为我们不希望在管理集群中创建 pod。 
我们想要的是把这个 `Deployment` 当作一个模板资源，这样我们就可以将它分发到多个子集群中。

因此，我们需要为这些资源创建一个单独的视图。 
在 Clusternet 中，我们创建了 **shadow APIs** 来实现这一点。
`clusternet-hub` 组件作为聚合 `apiserver` 运行，并在 `shadow/v1alpha1` 上为所有注册资源提供 **shadow APIs** 能力，包括原生 Kubernetes 资源（`Deployment`、`Configmap`、`Namespace`）和其他自定义资源。

下图显示了 Clusternet 如何为各种资源创建单独的视图。
Clusternet 提供了一个 [client-go wrapper](/docs/tutorials/using-client-go-in-clusternet/) 来自动将请求转换为 `shadow/v1alpha1` 组。
例如，该 wrapper 会将 `/apis/apps/v1/namespace/abc/deployments` 的请求转换为 `/apis/shadow/v1alpha1/namespace/abc/deployments`。
所有这些转换后的请求都会被 `kube-apiserver` 自动转发到 `clusternet-hub`。
Clusternet 定义的所有 CRD 都不会被映射。
`clusternet-hub` 将解析对象并存储为 `Manifest` 对象。
通过这种方式，Clusternet 为各种资源创建了一个单独的视图。

![](/images/clusternet-shadow-api.png)

对于命令行操作，我们可以使用`kubectl clusternet`来管理这些资源，比如创建、删除、修改等。
这个插件和 kubectl 的使用体验是一致的。 可从 [kubectl clusternet 插件](/docs/kubectl-clusternet/) 了解更多信息。

下面的命令片段展示了 **shadow APIs** 的魔力，我们可以在其中拥有单独的资源视图。

```shell
# list namespaces with kubectl clusternet plugin
# we can not see those kube namespaces
$ kubectl clusternet get ns
No resources found
# create namespace with kubectl clusternet plugin
$ kubectl clusternet create ns abc
namespace/abc created
# list namespaces with kubectl clusternet plugin
$ kubectl clusternet get ns
NAME   STATUS   AGE
abc             3s
# list namespaces natively with kubectl
# namespace abc is not in this list as well
$ kubectl get ns
NAME                  STATUS   AGE
clusternet-reserved   Active   98s
clusternet-system     Active   98s
default               Active   12m
kube-flannel          Active   2m36s
kube-node-lease       Active   12m
kube-public           Active   12m
kube-system           Active   12m
```

关于 client-go 的操作，请遵循[client-go 中的 clusternet wrapper](/docs/tutorials/using-client-go-in-clusternet/)。
