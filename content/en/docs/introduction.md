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
    - parent cluster can also register itself as a child cluster to run workloads
    - managing Kubernetes version skewed from v1.17.x to v1.22.x (Learn more
      about [Kubernetes Version Skew](/docs/introduction/#kubernetes-version-skew))
    - visiting any managed clusters with dynamic RBAC rules (Learn more
      from [this tuorial](/docs/tutorials/cluster-management/visiting-child-clusters-with-rbac/))
- Application Coordinations
    - Cross-Cluster Scheduling
        - replication scheduling
        - static dividing scheduling by weight
        - dynamic dividing scheduling by capacity
    - Various Resource Types
        - Kubernetes native objects, such as `Deployment`, `StatefulSet`, etc
        - CRD
        - helm charts, including [OCI-based Helm charts](https://helm.sh/docs/topics/registries/)
    - [Setting Overrides](/docs/tutorials/multi-cluster-apps/setting-overrides/)
        - two-stage priority based override strategies
        - easy to rollback
        - cross-cluster canary rollout
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

Clusternet is a lightweight addon that consists of three components, `clusternet-agent`, `clusternet-scheduler`
and `clusternet-hub`.

`clusternet-agent` is responsible for

- auto-registering current cluster to a parent cluster as a child cluster, which is also been called `ManagedCluster`;
- reporting heartbeats of current cluster, including Kubernetes version, running platform, `healthz`/`readyz`/`livez`
  status, etc;
- setting up a websocket connection that provides full-duplex communication channels over a single TCP connection to
  parent cluster;

`clusternet-scheduler` is responsible for

- scheduling resources/feeds to matched child clusters based on `SchedulingStrategy`;

`clusternet-hub` is responsible for

- approving cluster registration requests and creating dedicated resources, such as namespaces, serviceaccounts and RBAC
  rules, for each child cluster;
- serving as an **aggregated apiserver (AA)**, which is used to serve as a websocket server that maintain multiple
  active websocket connections from child clusters;
- providing Kubernstes-styled API to redirect/proxy/upgrade requests to each child cluster;
- coordinating and deploying applications to multiple clusters from a single set of APIs;

{{% alert title="Note" color="warning" %}}
Since `clusternet-hub` is running as an AA, please make sure that parent apiserver could visit the `clusternet-hub` service.
{{% /alert %}}

## Kubernetes Version Skew

`Clusternet` is compatible with multiple Kubernetes versions. For example, you could run `clusternet-hub` with
Kubernetes v1.20.8, while the versions of child Kubernetes clusters could range from v1.18.x to v1.22.x.

| Version                  | Kubernetes v1.17.x |  v1.18.x | v1.19.x ~ v1.22.x   |
| ------------------------ | ------------------ | -------- |---------------------|
| Clusternet v0.5.0        | \*                 | \*       | ✓                   |
| Clusternet v0.6.0        | \*                 | ✓        | ✓                   |
| Clusternet v0.7.0        | \*                 | ✓        | ✓                   |
| Clusternet HEAD (main)   | \*                 | ✓        | ✓                   |

Note:

* `✓` Clusternet is compatible with this Kubernetes version.
* `*` Clusternet has no guarantees to support this Kubernetes version. More compatible tests will be needed.
