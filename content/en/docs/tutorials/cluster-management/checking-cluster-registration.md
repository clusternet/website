---
title: "检查集群注册状态"
description: "了解如何检查您的子集群注册状态"
date: 2022-01-17
draft: false
weight: 1
---

`clusternet-agent` 会自动为每个集群创建一个注册请求 `ClusterRegistrationRequest`。

```bash
$ # clsrr 是 ClusterRegistrationRequest 的别名
$ kubectl get clsrr
NAME                                              CLUSTER ID                             STATUS     AGE
clusternet-dc91021d-2361-4f6d-a404-7c33b9e01118   dc91021d-2361-4f6d-a404-7c33b9e01118   Approved   3d6h
$ kubectl get clsrr clusternet-dc91021d-2361-4f6d-a404-7c33b9e01118 -o yaml
apiVersion: clusters.clusternet.io/v1beta1
kind: ClusterRegistrationRequest
metadata:
  labels:
    clusters.clusternet.io/cluster-id: dc91021d-2361-4f6d-a404-7c33b9e01118
    clusters.clusternet.io/cluster-name: clusternet-cluster-dzqkw
    clusters.clusternet.io/registered-by: clusternet-agent
  name: clusternet-dc91021d-2361-4f6d-a404-7c33b9e01118
spec:
  clusterId: dc91021d-2361-4f6d-a404-7c33b9e01118
  clusterName: clusternet-cluster-dzqkw
  clusterType: EdgeCluster
status:
  caCertificate: REDACTED
  dedicatedNamespace: clusternet-dhxfs
  managedClusterName: clusternet-cluster-dzqkw
  result: Approved
  token: REDACTED
```

`ClusterRegistrationRequest` 获准后，用于访问父集群的相应凭据的状态将被更新。这些凭据使用集群或项目空间 RBAC 规则进行设置，有关详细信息，请参阅以下两条规则。

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    clusternet.io/autoupdate: "true"
  labels:
    clusters.clusternet.io/bootstrapping: rbac-defaults
    clusters.clusternet.io/cluster-id: dc91021d-2361-4f6d-a404-7c33b9e01118
    clusternet.io/created-by: clusternet-hub
  name: clusternet-dc91021d-2361-4f6d-a404-7c33b9e01118
rules:
  - apiGroups:
      - clusters.clusternet.io
    resources:
      - clusterregistrationrequests
    verbs:
      - create
      - get
  - apiGroups:
      - proxies.clusternet.io
    resourceNames:
      - dc91021d-2361-4f6d-a404-7c33b9e01118
    resources:
      - sockets
    verbs:
      - '*'
```

和

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  annotations:
    clusternet.io/autoupdate: "true"
  labels:
    clusters.clusternet.io/bootstrapping: rbac-defaults
    clusternet.io/created-by: clusternet-hub
  name: clusternet-managedcluster-role
  namespace: clusternet-dhxfs
rules:
  - apiGroups:
      - '*'
    resources:
      - '*'
    verbs:
      - '*'
```

## 检查 ManagedCluster 状态

每个获得批准的注册集群都会拥有一个专属的命名空间。使用 `ManagedCluster` 来表征子集群，包含了集群云数据，集群健康心跳等等。

```bash
$ # mcls 是 ManagedCluster 的别名
$ # kubectl get mcls -A
$ # 或附加“-o wide”以显示额外的列
$ kubectl get mcls -A -o wide
NAMESPACE          NAME                       CLUSTER ID                             CLUSTER TYPE   SYNC MODE   KUBERNETES   READYZ   AGE
clusternet-dhxfs   clusternet-cluster-dzqkw   dc91021d-2361-4f6d-a404-7c33b9e01118   EdgeCluster    Dual        v1.19.10     true     7d23h
$ kubectl get mcls -n clusternet-dhxfs   clusternet-cluster-dzqkw -o yaml
apiVersion: clusters.clusternet.io/v1beta1
kind: ManagedCluster
metadata:
  labels:
    clusters.clusternet.io/cluster-id: dc91021d-2361-4f6d-a404-7c33b9e01118
    clusters.clusternet.io/cluster-name: clusternet-cluster-dzqkw
    clusternet.io/created-by: clusternet-agent
  name: clusternet-cluster-dzqkw
  namespace: clusternet-dhxfs
spec:
  clusterId: dc91021d-2361-4f6d-a404-7c33b9e01118
  clusterType: EdgeCluster
  syncMode: Dual
status:
  apiserverURL: http://10.0.0.10:8080
  appPusher: true
  healthz: true
  k8sVersion: v1.19.10
  lastObservedTime: "2021-06-30T08:55:14Z"
  livez: true
  platform: linux/amd64
  readyz: true
```
