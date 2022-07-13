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
Admission webhooks could be configured in parent cluster, but please make
sure that [dry-run](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects) mode
is supported in these webhooks. At the same time, a webhook must explicitly indicate that it will not have side-effects
when running with `dryRun`. That
is [`sideEffects`](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects)
must be set to `None` or `NoneOnDryRun`.

While, these webhooks could be configured per child cluster without above limitations as well.
{{% /alert %}}

Multiple scheduling strategies are supported by now, such as replication scheduling, static dividing scheduling by
weight, dynamic dividing scheduling by cluster capacity. Please follow tutorials below to learn more.
