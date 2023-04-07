---
title: "Introduction"
description: "Get introduced to Clusternet"
date: 2022-01-17
draft: false
weight: 1
---

----

Managing Your Clusters (including public, private, hybrid, edge, etc) as easily as Visiting the Internet.

----

![](/images/clusternet-in-a-nutshell.png)

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

## Architecture

![](/images/clusternet-arch.png)

Clusternet is a lightweight addon that consists of four components, `clusternet-agent`, `clusternet-scheduler`,
`clusternet-controller-manager` (added since v0.15.0) and `clusternet-hub`.

`clusternet-agent` is responsible for

- auto-registering current cluster to a parent cluster as a child cluster, which is also been called `ManagedCluster`;
- reporting heartbeats of current cluster, including Kubernetes version, running platform, `healthz`/`readyz`/`livez`
  status, etc;
- setting up a websocket connection that provides full-duplex communication channels over a single TCP connection to
  parent cluster;

`clusternet-scheduler` is responsible for

- scheduling resources/feeds to matched child clusters based on `SchedulingStrategy`;

`clusternet-controller` (added since v0.15.0) is responsible for
- approving cluster registration requests and creating dedicated resources, such as namespaces, serviceaccounts and RBAC
  rules, for each child cluster;
- coordinating and deploying applications to multiple clusters from a single set of APIs;

`clusternet-hub` is responsible for
- serving as an **aggregated apiserver (AA)**, which is used to provide shadow APIs and serve as a websocket server that
  maintain multiple active websocket connections from child clusters;
- providing Kubernetes-styled API to redirect/proxy/upgrade requests to each child cluster;

{{% alert title="Note" color="warning" %}}
Since `clusternet-hub` is running as an AA, please make sure that parent apiserver could visit the `clusternet-hub` service.
{{% /alert %}}

## Kubernetes Version Skew

`Clusternet` is compatible with multiple Kubernetes versions. For example, you could run `clusternet-hub` with
Kubernetes v1.20.8, while the versions of child Kubernetes clusters could range from v1.18.x to v1.23.x.

For clusters running Kubernetes with version upper than `v1.24.0`, please upgrade `Clusternet` to no less than `v0.13.0`.

| Version           | Kubernetes v1.17.x | v1.18.x | v1.19.x ~ v1.23.x | > = v1.24.x |
|-------------------| ------------------ | ------- | ----------------- | ----------- |
| Clusternet v0.5.0 | \*                 | \*      | ✓                 | \*          |
| v0.6.0 ~ v0.12.0  | \*                 | ✓       | ✓                 | \*          |
| >= v0.13.0        | \*                 | ✓       | ✓                 | ✓           |
| HEAD (main)       | \*                 | ✓       | ✓                 | ✓           |

Note:

* `✓` Clusternet is compatible with this Kubernetes version.
* `*` Clusternet has no guarantees to support this Kubernetes version. More compatible tests will be needed.

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
