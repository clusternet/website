---
title: "Glossary"
date: 2020-02-02
weight: 4
description: "Some concepts and definitions in Clusternet"
---

## Definitions

For every Kubernetes cluster that wants to be managed, we call it
**child cluster**. The cluster where child clusters are registerring to,
we call it **parent cluster**.

`clusternet-agent` runs in child cluster, while `clusternet-scheduler`
and `clusternet-hub` runs in parent cluster.

## CRDs

- `ClusterRegistrationRequest` is an object that `clusternet-agent`
  creates in parent cluster for child cluster registration.
- `ManagedCluster` is an object that `clusternet-hub` creates in parent
  cluster after approving `ClusterRegistrationRequest`.
- `HelmChart` is an object contains a
  [helm chart](https://helm.sh/docs/topics/charts/) configuration.
- `Subscription` defines the resources (we call them as a group of
  `Feeds`) that subscribers want to install into clusters. Various
  `SchedulingStrategy` are supported, such as `Replication`,
  `StaticDividing` and `DynamicDividing`. For every matched cluster, a
  corresponding `Base` object will be created in its dedicated
  namespace.
- `Clusternet` provides a ***two-stage priority based*** override
  strategy. `Localization` and `Globalization` will define the overrides
  with priority, where lower numbers are considered lower priority.
  `Localization` is namespace-scoped resource, while `Globalization` is
  cluster-scoped. Refer to tutorial on
  [how to set overrides in Clusternet](/docs/tutorials/multi-cluster-apps/setting-overrides/).
- `Base` objects will be rendered to `Description` objects with
  `Globalization` and `Localization` settings applied. `Description` is
  the final resources to be deployed into target child clusters.
- `FeedInventory` objects are used to track and record the scheduling
  requirements (such as replicas, node selectors, tolerations, affinity
  rules, resource requirements, etc.) for each feed in the
  `Subscription` object of the same name. This `FeedInventory` object is
  only applicable when `SchedulingStrategy` is set to `DynamicDividing`.
  For other scheduling strategies, `FeedInventory` makes no sense.

![](/images/clusternet-apps-concepts.png)
