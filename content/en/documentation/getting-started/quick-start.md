---
title: "Quick Start"
description: "How to install Clusternet"
date: 2022-01-17
draft: false
weight: 1
---

# Getting started to use Clusternet

## Installing Clusternet

You can try below ways to

- [install `Clusternet` with Helm](/docs/getting-started/install-with-helm/)
- [install `Clusternet` the Hard Way](/docs/getting-started/install-the-hard-way/)

> :whale: :whale: :whale: Note:
>
> The container images are hosted on both [ghcr.io](https://github.com/orgs/clusternet/packages) and [dockerhub](https://hub.docker.com/u/clusternet).
> Please choose the fastest image registry to use.

## Checking Cluster Registration

After `clusternet-hub` is successfully installed. You can try to install `clusternet-agent` to any Kubernetes clusters
you want to manage.

Please follow [this guide](./docs/tutorials/checking-cluster-registration.md) to check cluster registrations.

## Visiting Managed Clusters With RBAC

:white_check_mark: ***Clusternet supports visiting all your managed clusters with RBAC directly from parent cluster.***

Please follow [this guide](./docs/tutorials/visiting-child-clusters-with-rbac.md) to visit your managed clusters.

## How to Interact with Clusternet

Clusternet has provided two ways to help interact with Clusternet.

- kubectl plugin [kubectl-clusternet](https://github.com/clusternet/kubectl-clusternet)
- [using client-go to interact with Clusternet](/docs/tutorials/using-client-go-in-clusternet/)

## Deploying Applications to Multiple Clusters

Clusternet supports deploying applications to multiple clusters from a single set of APIs in a hosting cluster.

Please follow [this guide](/docs/tutorials/deploy-to-multiple-clusters/) to deploy your applications
to multiple clusters.
