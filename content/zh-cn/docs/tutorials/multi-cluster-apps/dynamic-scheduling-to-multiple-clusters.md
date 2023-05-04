---
title: "使用动态调度将应用程序部署到多个集群"
description: "基于集群容量调度多个副本的应用程序到多个集群"
date: 2022-07-13
draft: false
weight: 3
---

本教程将指导您如何使用动态调度将应用程序部署到多个集群。不同于静态调度，使用动态调度时，应用程序的副本将基于集群容量进行动态划分。

## 定义你的应用

让我们看一个使用动态调度的示例。 下面的 `Subscription` "dynamic-dividing-scheduling-demo" 定义了应用要调度到的子集群, 以及需要进行部署的资源。

```yaml
# examples/dynamic-dividing-scheduling/subscription.yaml
apiVersion: apps.clusternet.io/v1alpha1
kind: Subscription
metadata:
  name: dynamic-dividing-scheduling-demo
  namespace: default
spec:
  subscribers: # filter out a set of desired clusters
    - clusterAffinity:
        matchExpressions:
          - key: clusters.clusternet.io/cluster-id
            operator: Exists
  schedulingStrategy: Dividing
  dividingScheduling:
    type: Dynamic
    dynamicDividing:
      strategy: Spread # currently we only support Spread dividing strategy
  feeds: # defines all the resources to be deployed with
    - apiVersion: v1
      kind: Namespace
      name: qux
    - apiVersion: v1
      kind: Service
      name: my-nginx-svc
      namespace: qux
    - apiVersion: apps/v1 # with a total of 6 replicas
      kind: Deployment
      name: my-nginx
      namespace: qux
```

上面的`Deployment` qux/my-nginx 将会在一系列集群中启动共计6个副本. 举个例子, 如果我们有以下三个可以匹配的集群.

- `cluster-01` 可以运行 `qux/my-nginx`的3个副本
- `cluster-02` 可以运行 `qux/my-nginx`的6个副本
- `cluster-03` 可以运行 `qux/my-nginx`的9个副本

`clusternet-scheduler` 将根据各集群的副本的容量为每个匹配的集群分配副本。因此，这三个集群将分别运行1、2、3个副本。

您可以通过检查Subscription `dynamic-dividing-scheduling-demo`的状态来获得调度结果。

```yaml
bindingClusters:
  - clusternet-v7wzq/clusternet-cluster-bb2xp
  - clusternet-wlf5b/clusternet-cluster-skxd4
  - clusternet-bbf20/clusternet-cluster-aqx3b
  desiredReleases: 6
  replicas:
    apps/v1/Deployment/qux/my-nginx:
    - 1
    - 2
    - 3
    v1/Namespace/qux: []
    v1/Service/qux/my-nginx-svc: []
```

如果要对每个集群使用overrides，请遵循[在 Clusternet 中如何设置 Overrides](/zh-cn/docs/tutorials/multi-cluster-apps/setting-overrides/).

## 部署您的应用程序

安装完 kubectl 插件 [kubectl-clusternet](/zh-cn/docs/kubectl-clusternet/)之后, 您可以使用以下命令将应用分发到子集群之中。

```bash
$ kubectl clusternet apply -f examples/dynamic-dividing-scheduling/
namespace/qux created
deployment.apps/my-nginx created
service/my-nginx-svc created
subscription.apps.clusternet.io/dynamic-dividing-scheduling-demo created
$ # or
$ # kubectl-clusternet apply -f examples/dynamic-dividing-scheduling/
```

您可以对运行在每个子集群中的feeds/resources [检查聚合状态](/zh-cn/docs/tutorials/multi-cluster-apps/aggregated-status/).
