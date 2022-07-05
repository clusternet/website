---
title: "Multi-Cluster Applications"
weight: 2
description: ""
---

Clusternet supports deploying applications to multiple clusters from a single set of APIs in a hosting cluster.

{{% alert title="Note" color="primary" %}}
Feature gate `Deployer` should be enabled by `clusternet-hub`.
{{% /alert %}}

{{% alert title="Note" color="primary" %}}
Admission webhooks could be configured in parent cluster, but please make sure that
[dry-run](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects) mode
is supported in these webhooks. At the same time, a webhook must explicitly indicate that it will not have side-effects
when running with `dryRun`.
That is [`sideEffects`](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects)
must be set to `None` or `NoneOnDryRun`.

While, these webhooks could be configured per child cluster without above limitations as well.
{{% /alert %}}

Multiple scheduling strategies (such as replication scheduling, static weight scheduling) are supported by now. Please
follow tutorials below to learn more.
