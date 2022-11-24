---
title: "引言"
description: "Clusternet 引言"
date: 2022-06-27
draft: false
weight: 1
---

----

像访问 Internet 一样轻松管理您的集群（包括公共、私有、混合、边缘等）。

----

![](/images/clusternet-in-a-nutshell.png)

Clusternet (**Cluster** Inter**net**) 是一款可以帮助您像访问 Internet 一样简单地管理数以百万计的 Kubernetes 集群的开源插件。
无论集群是在公共云、私有云、混合云还是在边缘运行，Clusternet 都可以让您像是在本地运行一样管理/访问它们，无需为每个集群安装不同管理工具。

**Clusternet 还可以从托管集群中将一组 API 部署或协调到多个集群。**

当您的集群运行在 VPC 网络、边缘网络或防火墙后时，Clusternet 可以以配置的方式设置网络隧道。

Clusternet 还提供了 Kubernetes 风格的 API，在这里你可以继续使用像是 KubeConfig 的 Kubernetes 的方式， 来访问某个托管的 Kubernetes 集群或 Kubernetes 服务。

Clusternet现在支持多个平台，包括`linux/amd64`、`linux/arm64`、`linux/ppc64le`、`linux/s390x`
, `linux/386` 和 `linux/arm`;

## Core Features

- Kubernetes Multi-Cluster Management and Governance
  - managing Kubernetes clusters running in cloud providers, such as AWS, Google Cloud, Tencent Cloud, Alibaba Cloud,
    etc
  - managing on-premise Kubernetes clusters
  - managing any [Certified Kubernetes Distributions](https://www.cncf.io/certification/software-conformance/), such
    as [k3s](https://github.com/k3s-io/k3s)
  - managing Kubernetes clusters running at the edge
  - automatically discovering and registering clusters created by [cluster-api](https://github.com/kubernetes-sigs/cluster-api)
  - parent cluster can also register itself as a child cluster to run workloads
  - managing Kubernetes upper than v1.17.x (Learn more
    about [Kubernetes Version Skew](/docs/introduction/#kubernetes-version-skew))
  - visiting any managed clusters with dynamic RBAC rules (Learn more
    from [this tuorial](/docs/tutorials/cluster-management/visiting-child-clusters-with-rbac/))
  - cluster auto-labelling based on [Node Feature Discovery](https://github.com/kubernetes-sigs/node-feature-discovery)
- Application Coordinations
  - Scheduling Framework (`in-tree` plugins, `out-of-tree` plugins)
  - Cross-Cluster Scheduling
    - replication scheduling
    - static dividing scheduling by weight
    - dynamic dividing scheduling by capacity
      - cluster resource predictor framework for `in-tree` and `out-of-tree` implementations
      - various deployment topologies for cluster resource predictors
    - subgroup cluster scheduling
  - Various Resource Types
    - Kubernetes native objects, such as `Deployment`, `StatefulSet`, etc
    - CRDs
    - helm charts, including [OCI-based Helm charts](https://helm.sh/docs/topics/registries/)
  - Resource interpretation with `in-tree` or `out-of-tree` controller
  - [Setting Overrides](/docs/tutorials/multi-cluster-apps/setting-overrides/)
    - two-stage priority based override strategies
    - easy to rollback overrides
    - cross-cluster canary rollout
  - Multi-Cluster Services
    - multi-cluster services discovery with [mcs-api](https://github.com/kubernetes-sigs/mcs-api)
- CLI
  - providing a kubectl plugin, which can be installed with `kubectl krew install clusternet`
  - consistent user experience with `kubectl`
  - create/update/watch/delete multi-cluster resources
  - interacting with any child clusters the same as local cluster
- Client-go
  - easy to integrate via
    a [client-go wrapper](https://github.com/clusternet/clusternet/blob/main/examples/clientgo/READEME.md)

## 架构

![](/images/clusternet-arch.png)

Clusternet 是一个轻量级插件，由“clusternet-agent”、“clusternet-scheduler”和“clusternet-hub”三个组件组成.

`clusternet-agent` 负责

- 自动将当前集群注册到父集群作为子集群，也称为“ManagedCluster”;
- 报告当前集群的心跳，包括Kubernetes版本、运行平台、`healthz`/`readyz`/`livez`、状态等;
- 建立一个 websocket 连接，它通过单个 TCP 连接来提供全双工通信通道到父集群;

`clusternet-scheduler` 负责

- 基于`SchedulingStrategy`来调度资源/feeds到匹配的子集群;

`clusternet-hub` 负责

- 批准集群注册请求并为每个子集群创建专用资源，例如命名空间、服务帐户和 RBAC 规则;
- 作为**aggregated apiserver (AA)** 服务。提供 shadow APIs，并用作 websocket 服务器，来维护子集群的多个活动 websocket 连接;
- 提供 Kubernstes 风格的 API， 将请求重定向/代理/升级到每个子集群;
- 利用 API， 协调和部署应用程序到多个集群;

{{% alert title="Note" color="warning" %}}
由于 `clusternet-hub` 是作为 AA 服务运行，请确保父 apiserver 可以访问 `clusternet-hub` 服务。
{{% /alert %}}

## Kubernetes 版本支持

`Clusternet` 兼容多个 Kubernetes 版本。 例如，您可以使用 Kubernetes v1.20.8 运行“clusternet-hub”，而子 Kubernetes 集群的版本范围
可以从 v1.18.x 到 v1.23.x。

如果集群运行的 Kubernetes 版本高于 `v1.24.0`，请将 `Clusternet` 升级到至少 `v0.13.0` 版本。

| 版本              | Kubernetes v1.17.x | v1.18.x | v1.19.x ~ v1.23.x | > = v1.24.x |
|-------------------| ------------------ | ------- | ----------------- | ----------- |
| Clusternet v0.5.0 | \*                 | \*      | ✓                 | \*          |
| v0.6.0 ~ v0.12.0  | \*                 | ✓       | ✓                 | \*          |
| >= v0.13.0        | \*                 | ✓       | ✓                 | ✓           |
| HEAD (main)       | \*                 | ✓       | ✓                 | ✓           |

注:

* `✓` Clusternet 与此 Kubernetes 版本兼容。
* `*` Clusternet 不保证支持该 Kubernetes 版本。 将需要更多兼容的测试。

{{% alert title="Note" color="warning" %}}
Special Flag Setting in `kube-apiserver`

To fully use the features of Clusternet, please remember to set the flag `--aggregator-reject-forwarding-redirect=false`
for the `kube-apiserver` running in the parent cluster.

This is **ONLY** applicable for below Kubernetes versions.

- kube-apiserver v1.26+ ~ latest
- kube-apiserver >= v1.25.1
- kube-apiserver >= v1.24.5
- kube-apiserver >= v1.23.11
- kube-apiserver >= v1.22.14
{{% /alert %}}
