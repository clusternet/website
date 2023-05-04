---
title: "检查聚合状态"
description: "从子群中汇总资源状态"
date: 2022-07-13
draft: false
weight: 8
---

在Clusternet中，您可以通过访问Subscription的状态来检查所有已部署资源的聚合状态。对于每个 feed/resource, 您可以检查每个集群的详细状态 (field `feedStatusDetails`) 以及`status.aggregatedStatuses`中所有集群的汇总状态(field `feedStatusSummary`)。

```yaml
status:
  aggregatedStatuses:
    - apiVersion: v1
      feedStatusDetails:
        - available: true
          clusterId: 851a623b-a38c-42ec-95b5-dbea9ed27116
          clusterName: clusternet-cluster-bb2xp
          replicaStatus: { }
        - available: true
          clusterId: 58602f69-8664-43f5-bbf2-0b20af76b0bc
          clusterName: clusternet-cluster-skxd4
          replicaStatus: { }
      feedStatusSummary:
        available: true
        replicaStatus: { }
      kind: Namespace
      name: qux
    - apiVersion: v1
      feedStatusDetails:
        - available: true
          clusterId: 851a623b-a38c-42ec-95b5-dbea9ed27116
          clusterName: clusternet-cluster-bb2xp
          replicaStatus: { }
        - available: true
          clusterId: 58602f69-8664-43f5-bbf2-0b20af76b0bc
          clusterName: clusternet-cluster-skxd4
          replicaStatus: { }
      feedStatusSummary:
        available: true
        replicaStatus: { }
      kind: Service
      name: my-nginx-svc
      namespace: qux
    - apiVersion: apps/v1
      feedStatusDetails:
        - available: true
          clusterId: 851a623b-a38c-42ec-95b5-dbea9ed27116
          clusterName: clusternet-cluster-bb2xp
          replicaStatus:
            availableReplicas: 1
            observedGeneration: 9
            readyReplicas: 1
            replicas: 1
            updatedReplicas: 1
        - available: true
          clusterId: 58602f69-8664-43f5-bbf2-0b20af76b0bc
          clusterName: clusternet-cluster-skxd4
          replicaStatus:
            availableReplicas: 2
            observedGeneration: 5
            readyReplicas: 2
            replicas: 2
            updatedReplicas: 2
      feedStatusSummary:
        available: true
        replicaStatus:
          availableReplicas: 3
          observedGeneration: 9
          readyReplicas: 3
          replicas: 3
          updatedReplicas: 3
      kind: Deployment
      name: my-nginx
      namespace: qux
  bindingClusters:
    - clusternet-v7wzq/clusternet-cluster-bb2xp
    - clusternet-wlf5b/clusternet-cluster-skxd4
  desiredReleases: 2
  replicas:
    apps/v1/Deployment/qux/my-nginx:
      - 1
      - 2
    v1/Namespace/qux: [ ]
    v1/Service/qux/my-nginx-svc: [ ]
  specHash: 3893382778
```

使用上述示例, 我们可以看到 `qux/my-nginx` 的3个副本已经被部署到2个集群之中。
从 `feedStatusSummary`字段可以看出, 这 3 个副本已经可用，并且运行正常。
