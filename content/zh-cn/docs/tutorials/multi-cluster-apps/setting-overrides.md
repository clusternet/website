---
title: "在 Clusternet 中如何设置 Overrides"
description: "设置基于优先级的 Overrides"
date: 2022-04-11
draft: false
weight: 10
---

`Clusternet` 还提供了***基于两阶段优先级的***覆盖策略。 你可以定义有优先级的命名空间范围的`Localization`和集群范围的`Globalization`（范围从0到1000，默认为为 500），
其中较低的数字被认为是较低的优先级。这些`Globalization`和`Localization`将被应用按优先级从低到高的顺序。这意味着较低的`Globalization`中的覆盖值将被那些覆盖在更高的`Globalization`
中。首先是`Globalization`，然后是`Localization`。

{{% alert title="举例" color="primary" %}}
Globalization (优先级 : 100) -> Globalization (优先级: 600) -> Localization (优先级: 100) -> Localization (优先级 500)
{{% /alert %}}

同时，支持以下覆盖策略。

- `ApplyNow` 将立即为匹配的对象应用覆盖，包括那些已经填充的对象。
- 默认覆盖策略`ApplyLater`只会在下次更新时应用覆盖匹配的对象（包括更新在 `Subscription`、`HelmChart` 等）或新创建的对象。

Here you can refer below samples to learn more,

- [Localization 例子](https://github.com/clusternet/clusternet/blob/main/examples/replication-scheduling/localization.yaml)
- [Globalization 例子](https://github.com/clusternet/clusternet/blob/main/examples/replication-scheduling/globalization.yaml)

请记得修改你的 `ManagedCluster` 命名空间, 比如 `clusternet-5l82l`.
