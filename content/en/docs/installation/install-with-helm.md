---
title: "Installing Clusternet via Helm"
description: "How to install Clusternet via Helm"
date: 2022-01-17
draft: false
weight: 2
collapsible: false
---

You need to deploy `clusternet-agent` in child clusters, `clusternet-hub` and `clusternet-scheduler` in parent cluster.
You can also try to [install `Clusternet` manually](/docs/getting-started/install-the-hard-way/).

> [Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```bash
helm repo add clusternet https://clusternet.github.io/charts
```

{{% alert title="Note 🐳🐳🐳" color="primary" %}}
The container images are hosted on both [ghcr.io](https://github.com/orgs/clusternet/packages) and [dockerhub](https://hub.docker.com/u/clusternet).
Please choose the fastest image registry to use.
{{% /alert %}}

{{% alert title="Note on kube-apiserver" color="primary" %}}
Please refer to [Kubernetes Version Skew](../../introduction/#kubernetes-version-skew) to see whether the Kubernetes
versions are supported.
Please also note that whether the kube-apiserver running in the parent cluster should be configured with flag
`--aggregator-reject-forwarding-redirect=false`.
{{% /alert %}}

You can then run `helm search repo clusternet` to see the charts.

- [installing `clusternet-hub` to parent cluster](https://github.com/clusternet/charts/tree/main/charts/clusternet-hub)
- [installing `clusternet-scheduler` to parent cluster](https://github.com/clusternet/charts/tree/main/charts/clusternet-scheduler)
- [installing `clusternet-agent` to child clusters](https://github.com/clusternet/charts/tree/main/charts/clusternet-agent)

Please follow [this guide](/docs/tutorials/cluster-management/checking-cluster-registration/) to check cluster registrations.
