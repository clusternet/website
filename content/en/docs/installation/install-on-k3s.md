---
title: "Installing Clusternet on k3s"
description: "How is the installation different on k3s"
date: 2023-07-10
draft: false
weight: 4
collapsible: false
---

Installing Clusternet in a [K3S](https://k3s.io/) cluster requires some additional configurations.

#### Set anonymous-auth to false

- If [installed via Helm](/docs/installation/install-with-helm), you need to set `anonymousAuthSupported` to `false` in the value files for both clusternet-hub and clusternet-controller-manager Charts.
- If [manually installing clusternet](/docs/installation/install-the-hard-way), you need to set command line argument `--anonymous-auth=false` for clusternet-hub and clusternet-controller-manager.

#### Create Serviceaccount Token
- `kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_serviceaccount_token.yaml`
