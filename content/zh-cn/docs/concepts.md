---
title: "概念"
date: 2020-02-02
weight: 4
description: "更加深入的理解 Clusternet 是如何工作的"
---

## 术语

每个想要被管理的 Kubernetes 集群，我们称之为**子集群**。 子集群注册到的集群，我们称之为**父集群**.

`clusternet-agent` 运行在子集群, 而 `clusternet-scheduler` and `clusternet-hub` 运行在父集群.

- `ClusterRegistrationRequest` 是 `clusternet-agent` 在父集群中为子集群注册创建的对象.
- `ManagedCluster`是`clusternet-hub`在同意`ClusterRegistrationRequest`后，在父集群中创建的对象.
- `HelmChart` 是一个包含 [helm chart](https://helm.sh/docs/topics/charts/) 配置的对象.
- `Subscription` 定义了订阅者想要安装到集群中的资源。 支持多种`SchedulingStrategy`，例如`Replication`，`StaticDividing` and `DynamicDividing`
  。对于每个匹配的集群，都会在其专用的命名空间中创建一个对应的`Base`对象.
- `Clusternet` 提供了***两个阶段优先级***的覆盖策略。
  `Localization` 和 `Globalization` 定义了优先级覆盖策略，其中较低的数字被认为是较低的优先级。
  `Localization` 是命名空间范围的资源，而 `Globalization`
  是集群范围的。可以参考这篇[在 Clusternet 中如何设置覆盖值](/zh-cn/docs/tutorials/multi-cluster-apps/setting-overrides/).
- `Base` 对象将被渲染为 `Description` 对象，并应用了 `Globalization` 和 `Localization` 设置。
  `Description` 是要部署到目标子集群的最终资源。

![](/images/clusternet-apps-concepts.png)
