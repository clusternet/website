---
title: "引言"
description: "Clusternet 引言."
date: 2022-06-27
draft: false
weight: 1
---

# 引言

----

像访问 Internet 一样轻松管理您的集群（包括公共、私有、混合、边缘等）。

----

<div align="center"><img src="https://raw.githubusercontent.com/clusternet/clusternet/main/docs/images/clusternet-in-a-nutshell.png" style="width:900px;" /></div>



Clusternet (**Cluster** Inter**net**) 是一款可以帮助您像访问 Internet 一样简单地管理数以百万计的 Kubernetes 集群的开源插件。 
无论集群是在公共云、私有云、混合云还是在边缘运行，Clusternet 都可以让您像是在本地运行一样管理/访问它们，无需为每个集群安装不同管理工具。

**Clusternet 还可以从托管集群中将一组 API 部署或协调到多个集群。**

当您的集群运行在 VPC 网络、边缘网络或防火墙后时，Clusternet 可以配置的方式设置网络隧道。

Clusternet 还提供了 Kubernetes 风格的 API，在这里你可以继续使用像是 KubeConfig 的 Kubernetes 的方式，
来访问某个托管的 Kubernetes 集群或 Kubernetes 服务。

Clusternet现在支持多个平台，包括`linux/amd64`、`linux/arm64`、`linux/ppc64le`、`linux/s390x`
, `linux/386` 和 `linux/arm`;

## 架构

<div align="center"><img src="https://raw.githubusercontent.com/clusternet/clusternet/main/docs/images/clusternet-arch.png" style="width:600px;" /></div>

Clusternet 是一个轻量级插件，由“clusternet-agent”、“clusternet-scheduler”和“clusternet-hub”三个组件组成.

`clusternet-agent` 负责

- 自动将当前集群注册到父集群作为子集群，也称为“ManagedCluster”;
- 报告当前集群的心跳，包括Kubernetes版本、运行平台、`healthz`/`readyz`/`livez`、状态等;
- 建立一个 websocket 连接，它通过单个 TCP 连接来提供全双工通信通道到父集群;

`clusternet-scheduelr` 负责

- 基于`SchedulingStrategy`来调度资源/feeds到匹配的子集群;

`clusternet-hub` 负责

- 批准集群注册请求并为每个子集群创建专用资源，例如命名空间、服务帐户和 RBAC 规则;
- 作为**aggregated apiserver (AA)**服务。用作 websocket 服务器，来维护子集群的多个活动 websocket 连接;
- 提供 Kubernstes 风格的 API， 将请求重定向/代理/升级到每个子集群;
- 利用 API， 协调和部署应用程序到多个集群;

> :pushpin: :pushpin: Note:
>
> 由于 `clusternet-hub` 是作为 AA 服务运行，请确保父 apiserver 可以访问 `clusternet-hub` 服务

## 概念

每个想要被管理的 Kubernetes 集群，我们称之为**子集群**。 
子集群注册到的集群，我们称之为**父集群**.

`clusternet-agent` 运行在子集群, 而 `clusternet-scheduler` and `clusternet-hub` 运行在父集群.

- `ClusterRegistrationRequest` 是 `clusternet-agent` 在父集群中为子集群注册创建的对象.
- `ManagedCluster`是`clusternet-hub`在同意`ClusterRegistrationRequest`后，在父集群中创建的对象.
- `HelmChart` 是一个包含 [helm chart](https://helm.sh/docs/topics/charts/) 配置的对象.
- `Subscription` 定义了订阅者想要安装到集群中的资源。 支持多种`SchedulingStrategy`，例如`Replication`，`Rebalancing`（实现）等。
   对于每个匹配的集群，都会在其专用的命名空间中创建一个对应的`Base`对象.
- `Clusternet` 提供了***两个阶段优先级***的覆盖策略。 
  `Localization` 和 `Globalization` 定义了优先级覆盖策略，其中较低的数字被认为是较低的优先级。 
  `Localization` 是命名空间范围的资源，而 `Globalization` 是集群范围的。 
- `Base` 对象将被渲染为 `Description` 对象，并应用了 `Globalization` 和 `Localization` 设置。
  `Description` 是要部署到目标子集群的最终资源。

<div align="center"><img src="https://raw.githubusercontent.com/clusternet/clusternet/main/docs/images/clusternet-apps-concepts.png" style="width:900px;"/></div>

## Kubernetes 版本支持

`Clusternet` 兼容多个 Kubernetes 版本。 
例如，您可以使用 Kubernetes v1.20.8 运行“clusternet-hub”，而子 Kubernetes 集群的版本范围可以从 v1.18.x 到 v1.22.x。

| 版本                     | Kubernetes v1.17.x | Kubernetes v1.18.x | Kubernetes v1.19.x | Kubernetes v1.20.x | Kubernetes v1.21.x | Kubernetes v1.22.x |
|------------------------|--------------------|--------------------|--------------------|--------------------|--------------------|--------------------|
| Clusternet v0.5.0      | \*                 | \*                 | ✓                  | ✓                  | ✓                  | ✓                  |
| Clusternet v0.6.0      | \*                 | ✓                  | ✓                  | ✓                  | ✓                  | ✓                  |
| Clusternet v0.7.0      | \*                 | ✓                  | ✓                  | ✓                  | ✓                  | ✓                  |
| Clusternet HEAD (main) | \*                 | ✓                  | ✓                  | ✓                  | ✓                  | ✓                  |

注:

* `✓` Clusternet 与此 Kubernetes 版本兼容。
* `*` Clusternet 不保证支持该 Kubernetes 版本。 将需要更多兼容的测试。
