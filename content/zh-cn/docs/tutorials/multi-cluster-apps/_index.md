---
title: "多集群应用分发"
weight: 2
description: "通过多种调度策略将应用分发到多集群中"
---

Clusternet支持通过一组API将应用程序从托管集群部署到多个集群。

{{% alert title="Note" color="primary" %}}
`Deployer`的特性门控应该在 `clusternet-hub` 中启用。
{{% /alert %}}

{{% alert title="Note" color="primary" %}}
Admission webhooks可以在父集群中进行配置, 但是请确保这些webhook支持 [dry-run](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects) 模式. 同时, webhook必须明确表示其在`dryRun`模式下运行时没有副作用. 即其 [`sideEffects`](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects)参数必须设置为 `None` 或 `NoneOnDryRun`.

尽管如此，这些webhook也可以在没有上述限制的情况下按每个子集群进行配置.
{{% /alert %}}

目前支持多种调度策略，如复制调度、静态权重调度，基于集群容量动态调度。请按照下面的教程了解更多信息。
