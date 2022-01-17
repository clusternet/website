---
title: "Introduction"
description: "Clusternet introduction."
date: 2022-01-17
draft: false
weight: 1
---

# Introduction

----

Managing Your Clusters (including public, private, hybrid, edge, etc) as easily as Visiting the Internet.

----

<div align="center"><img src="https://raw.githubusercontent.com/clusternet/clusternet/main/docs/images/clusternet-in-a-nutshell.png" style="width:900px;" /></div>



Clusternet (**Cluster** Inter**net**) is an open source ***add-on*** that helps you manage thousands of millions of
Kubernetes clusters as easily as visiting the Internet. No matter the clusters are running on public cloud, private
cloud, hybrid cloud, or at the edge, Clusternet lets you manage/visit them all as if they were running locally. This
also help eliminate the need to juggle different management tools for each cluster.

**Clusternet can also help deploy and coordinate applications to multiple clusters from a single set of APIs in a
hosting cluster.**

Clusternet will help setup network tunnels in a configurable way, when your clusters are running in a VPC network, at
the edge, or behind a firewall.

Clusternet also provides a Kubernetes-styled API, where you can continue using the Kubernetes way, such as KubeConfig,
to visit a certain Managed Kubernetes cluster, or a Kubernetes service.

Clusternet is multiple platforms supported now, including `linux/amd64`, `linux/arm64`, `linux/ppc64le`, `linux/s390x`
, `linux/386` and `linux/arm`;

## Architecture

<div align="center"><img src="https://raw.githubusercontent.com/clusternet/clusternet/main/docs/images/clusternet-arch.png" style="width:600px;" /></div>

Clusternet is a lightweight addon that consists of three components, `clusternet-agent`, `clusternet-scheduler`
and `clusternet-hub`.

`clusternet-agent` is responsible for

- auto-registering current cluster to a parent cluster as a child cluster, which is also been called `ManagedCluster`;
- reporting heartbeats of current cluster, including Kubernetes version, running platform, `healthz`/`readyz`/`livez`
  status, etc;
- setting up a websocket connection that provides full-duplex communication channels over a single TCP connection to
  parent cluster;

`clusternet-scheduelr` is responsible for

- scheduling resources/feeds to matched child clusters based on `SchedulingStrategy`;

`clusternet-hub` is responsible for

- approving cluster registration requests and creating dedicated resources, such as namespaces, serviceaccounts and RBAC
  rules, for each child cluster;
- serving as an **aggregated apiserver (AA)**, which is used to serve as a websocket server that maintain multiple
  active websocket connections from child clusters;
- providing Kubernstes-styled API to redirect/proxy/upgrade requests to each child cluster;
- coordinating and deploying applications to multiple clusters from a single set of APIs;

> :pushpin: :pushpin: Note:
>
> Since `clusternet-hub` is running as an AA, please make sure that parent apiserver could visit the
> `clusternet-hub` service.

## Concepts

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

<div align="center"><img src="https://raw.githubusercontent.com/clusternet/clusternet/main/docs/images/clusternet-apps-concepts.png" style="width:900px;"/></div>

## Kubernetes Version Skew

`Clusternet` is compatible with multiple Kubernetes versions. For example, you could run `clusternet-hub` with
Kubernetes v1.20.8, while the versions of child Kubernetes clusters could range from v1.18.x to v1.22.x.

| Version                  | Kubernetes v1.17.x | Kubernetes v1.18.x | Kubernetes v1.19.x | Kubernetes v1.20.x | Kubernetes v1.21.x | Kubernetes v1.22.x |
| ------------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| Clusternet v0.5.0        | \*                 | \*                 | ✓                  | ✓                  | ✓                  | ✓                  |
| Clusternet v0.6.0        | \*                 | ✓                  | ✓                  | ✓                  | ✓                  | ✓                  |
| Clusternet v0.7.0        | \*                 | ✓                  | ✓                  | ✓                  | ✓                  | ✓                  |
| Clusternet HEAD (main)   | \*                 | ✓                  | ✓                  | ✓                  | ✓                  | ✓                  |

Note:

* `✓` Clusternet is compatible with this Kubernetes version.
* `*` Clusternet has no guarantees to support this Kubernetes version. More compatible tests will be needed.
