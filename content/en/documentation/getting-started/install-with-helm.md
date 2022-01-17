---
title: "Install via Helm"
description: "How to install Clusternet via Helm"
date: 2022-01-17
draft: false
weight: 2
collapsible: false
---

# Installing Clusternet via Helm

You need to deploy `clusternet-agent` in child clusters, `clusternet-hub` and `clusternet-scheduler` in parent cluster.

:white_check_mark: You can also try to [install `Clusternet` manually](/docs/getting-started/install-the-hard-way/).

> [Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add clusternet https://clusternet.github.io/charts
```

You can then run `helm search repo clusternet` to see the charts.

- [installing `clusternet-hub` to parent cluster](/docs/components/clusternet-hub/)
- [installing `clusternet-scheduler` to parent cluster](/docs/components/clusternet-scheduler/)
- [installing `clusternet-agent` to child clusters](/docs/components/clusternet-agent/)
