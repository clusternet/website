---
title: "使用动态调度将应用程序部署到多个集群"
description: "基于集群容量调度多个副本的应用程序到多个集群"
date: 2022-07-13
draft: false
weight: 3
---

This tutorial will walk you through how to deploy applications to multiple clusters with dynamic scheduling. It is
different from static dividing scheduling. When using dynamic scheduling, the replicas of an application will be split
based on cluster capacity.

## Defining Your Applications

Let's see an example using dynamic scheduling. Below `Subscription` "dynamic-dividing-scheduling-demo" defines the
target child clusters to be distributed to, and the resources to be deployed with.

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

The `Deployment` qux/my-nginx above will run in a set of clusters with a total of 6 replicas. For example, if we've got
three matching clusters as below.

- `cluster-01` can run 3 replicas of Deployment `qux/my-nginx`
- `cluster-02` can run 6 replicas of Deployment `qux/my-nginx`
- `cluster-03` can run 9 replicas of Deployment `qux/my-nginx`

`clusternet-scheduler` will assign replicas to each matching cluster by their capacity. As a result, these three clusters
will run 1, 2, 3 replicas respectively.

You can get the scheduling result by checking the status of Subscription `dynamic-dividing-scheduling-demo`.

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

If you want to apply overrides per cluster, please
follow [How to Set Overrides in Clusternet](/docs/tutorials/multi-cluster-apps/setting-overrides/).

## Applying Your Applications

After installing kubectl plugin [kubectl-clusternet](/docs/kubectl-clusternet/), you could run commands below to
distribute this application to child clusters.

```bash
$ kubectl clusternet apply -f examples/dynamic-dividing-scheduling/
namespace/qux created
deployment.apps/my-nginx created
service/my-nginx-svc created
subscription.apps.clusternet.io/dynamic-dividing-scheduling-demo created
$ # or
$ # kubectl-clusternet apply -f examples/dynamic-dividing-scheduling/
```

You can [check aggregated status](docs/tutorials/multi-cluster-apps/aggregated-status/) of feeds/resources running in
each child clusters.
