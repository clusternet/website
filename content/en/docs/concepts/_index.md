---
title: "Concepts"
date: 2020-02-02
weight: 4
description: >
    Obtain a deeper understanding of how Clusternet works
---

## Definitions

For every Kubernetes cluster that wants to be managed, we call it **child cluster**. The cluster where child clusters
are registerring to, we call it **parent cluster**.

`clusternet-agent` runs in child cluster, while `clusternet-scheduler` and `clusternet-hub` runs in parent cluster.

- `ClusterRegistrationRequest` is an object that `clusternet-agent` creates in parent cluster for child cluster
  registration.
- `ManagedCluster` is an object that `clusternet-hub` creates in parent cluster after
  approving `ClusterRegistrationRequest`.
- `HelmChart` is an object contains a [helm chart](https://helm.sh/docs/topics/charts/) configuration.
- `Subscription` defines the resources that subscribers want to install into clusters. Various `SchedulingStrategy` are
  supported, such as `Replication`, `Rebalancing` (implementing), etc. For every matched cluster, a corresponding `Base`
  object will be created in its dedicated namespace.
- `Clusternet` provides a ***two-stage priority based*** override strategy. `Localization` and `Globalization` will
  define the overrides with priority, where lower numbers are considered lower priority. `Localization` is
  namespace-scoped resource, while `Globalization` is cluster-scoped. Refer to
  [Deploying Applications to Multiple Clusters](#deploying-applications-to-multiple-clusters) on how to use these.
- `Base` objects will be rendered to `Description` objects with `Globalization` and `Localization` settings applied.
  `Description` is the final resources to be deployed into target child clusters.

![](/images/clusternet-apps-concepts.png)
