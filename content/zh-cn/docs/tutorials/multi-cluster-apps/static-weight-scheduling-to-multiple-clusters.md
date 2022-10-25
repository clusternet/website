---
title: "使用静态权重调度将应用部署到多个集群"
description: "通过集群的静态权重在多个集群上调度应用的多个副本"
date: 2022-04-11
draft: false
weight: 2
---

本教程将带您了解如何使用静态权重调度(`static weight scheduling`)将应用程序部署到多个集群。

它不同于复制调度(`replication scheduling`)。使用静态权重调度时，应用程序的副本将根据集群权重进行拆分。例如，如果您要将一个具有6个副本的`Deployment`部署到2个集群(“cluster-01”的权重为1，“cluster-02”的权重为2)，那么“cluster-01”将运行这样一个具有2个副本的`Deployment`，“cluster-02”将运行另外4个副本。

## 定义应用

让我们看一个使用静态权重调度的例子。在下面"static-dividing-scheduling-demo" `Subscription`中定义了要分发到的目标子集群，以及要部署的资源。

```yaml
# examples/static-dividing-scheduling/subscription.yaml
apiVersion: apps.clusternet.io/v1alpha1
kind: Subscription
metadata:
  name: static-dividing-scheduling-demo
  namespace: default
spec:
  subscribers: # defines the clusters to be distributed to
    - clusterAffinity:
        matchLabels:
          clusters.clusternet.io/cluster-id: dc91021d-2361-4f6d-a404-7c33b9e01118 # PLEASE UPDATE THIS CLUSTER-ID TO YOURS!!!
      weight: 1 # Deployment bar/my-nginx will have 2 replicas running in this cluster
    - clusterAffinity:
        matchLabels:
          clusters.clusternet.io/cluster-id: 5f9da921-0437-4fea-a89d-42aa1ede9b25 # PLEASE UPDATE THIS CLUSTER-ID TO YOURS!!!
      weight: 2 # Deployment bar/my-nginx will have 4 replicas running in this cluster
  schedulingStrategy: Dividing
  dividingScheduling:
    type: Static
  feeds: # defines all the resources to be deployed with
    - apiVersion: v1
      kind: Namespace
      name: bar
    - apiVersion: v1
      kind: Service
      name: my-nginx-svc
      namespace: bar
    - apiVersion: apps/v1 # with a total of 6 replicas
      kind: Deployment
      name: my-nginx
      namespace: bar
```

上面的 bar/my-nginx `Deployment`将在两个集群中运行，总共有6个副本，而2个副本在ID为`dc91021d-2361-4f6d-a404-7c33b9e01118`的集群中运行, 有4个副本在ID为`5f9da921-0437-4fea-a89d-42aa1ede9b25`的集群中。

您可以通过检查`static-dividing-scheduling-demo` Subscription的状态来获得调度结果。

```yaml
bindingClusters:
  - clusternet-v7wzq/clusternet-cluster-bb2xp
  - clusternet-wlf5b/clusternet-cluster-skxd4
  desiredReleases: 6
  replicas:
    apps/v1/Deployment/qux/my-nginx:
    - 2
    - 4
    v1/Namespace/qux: []
    v1/Service/qux/my-nginx-svc: []
```

在部署该`Subscription`前, 请将文件 [examples/static-dividing-scheduling/subscription.yaml](https://github.com/clusternet/clusternet/blob/main/examples/static-dividing-scheduling/subscription.yaml) 中的集群ID修改为你的集群ID.

如果你想在每个集群中使用`overrides`, 请参考[How to Set Overrides in Clusternet](/docs/tutorials/multi-cluster-apps/setting-overrides/).

## 部署应用

安装完[kubectl-clusternet](/docs/kubectl-clusternet/)插件后, 您可以运行下面的命令将此应用程序分发到子群中。

```bash
$ kubectl clusternet apply -f examples/static-dividing-scheduling/
namespace/bar created
deployment.apps/my-nginx created
service/my-nginx-svc created
subscription.apps.clusternet.io/static-dividing-scheduling-demo created
$ # or
$ # kubectl-clusternet apply -f examples/static-dividing-scheduling/
```

你可以对每个子集群中运行的feeds/resources[检查聚合状态](docs/tutorials/multi-cluster-apps/aggregated-status/)。
