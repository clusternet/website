---
title: "Managing Clusters Provisioned by Cluster API Providers"
description: "How to Work with Cluster API Providers"
date: 2022-11-09
draft: false
weight: 3
collapsible: false
---

The experimental
feature [ClusterResourceSet](https://cluster-api.sigs.k8s.io/tasks/experimental-features/cluster-resource-set.html)
in [Cluster API](https://github.com/kubernetes-sigs/cluster-api)
allows users to automatically install additional components onto workload clusters when the workload clusters are
provisioned. With the help of this, clusters provisioned
by [Cluster API](https://github.com/kubernetes-sigs/cluster-api)
providers can be discovered and automatically get registered starting from Clusternet v0.12.0.

At a high level, using `ClusterResourceSet` to install `clusternet-agent` automatically looks like this:

1. Make sure experimental features `ClusterResourceSet` are enabled on
   your [Cluster API](https://github.com/kubernetes-sigs/cluster-api) management cluster.
2. Create a `Secret` in your [Cluster API](https://github.com/kubernetes-sigs/cluster-api) management cluster. that
   contains all the information to configure `clusternet-agent`, such as bootstrap token, parent cluster endpoint,
   container image.
3. `clusternet-hub` connects to your [Cluster API](https://github.com/kubernetes-sigs/cluster-api) management cluster
   and watches all the clusters that are ready.
4. `clusternet-hub` creates a `ClusterResourceSet` that will match all the workload clusters in the same namespace.

The sections below describe each of these steps in more detail.

## Enabling Experimental Features

If you have not initialized the [Cluster API](https://github.com/kubernetes-sigs/cluster-api) management cluster, the
preferred way to enable experimental features is to use a setting in the `clusterctl`
configuration file or its environment variable equivalent. Specifically, putting `EXP_CLUSTER_RESOURCE_SET: "true"` in
the `clusterctl` configuration file or using `export EXP_CLUSTER_RESOURCE_SET=true` before initializing the management
cluster with `clusterctl init` will enable the ClusterResourceSet functionality.

You can also manually enable experimental features by directly modifying Deployment `capi-controller-manager` in
the `capi-system` namespace.

```yaml
- args:
    - --metrics-addr=127.0.0.1:8080
    - --enable-leader-election
    - --feature-gates=MachinePool=false,ClusterResourceSet=true
  command:
    - /manager
```

## Creating a Secret for Cluster

You have to set right parameters for `clusternet-agent`, such as where should the clusters be registered to, the
container image version and the bootstrap token for cluster registration.

```bash
$ wget https://raw.githubusercontent.com/clusternet/clusternet/main/deploy/templates/clusternet_clusterapi_secret.yaml
$ IMAGE=ghcr.io/clusternet/clusternet-agent:v0.12.0 \
  PARENTURL=https://<CHANGEME>:6443 \
  REGTOKEN=07401b.f395accd246ae52d \
  envsubst < ./clusternet_clusterapi_secret.yaml | kubectl apply -f -
```

Please remember to slightly modify the values above to yours.

You can refer
to [how to generate token for cluster registration](../../installation/install-the-hard-way/#deploying-clusternet-hub-in-parent-cluster)
when setting `REGTOKEN`.

## Configuring `clusternet-hub`

For `clusternet-hub`, it needs to know where the [Cluster API](https://github.com/kubernetes-sigs/cluster-api)
management cluster is. You can specify an accessible kubeconfig file to flag `--cluster-api-kubeconfig`.

```bash
--cluster-api-kubeconfig string                   Path to a kubeconfig file pointing at the management cluster for cluster-api.
```

You can mount this file as a volume to `clusternet-hub` pods.

## `ClusterResourceSet` Will Be Automatically Created

In your [Cluster API](https://github.com/kubernetes-sigs/cluster-api)
management cluster, you can find `ClusterResourceSets` are automatically created.

```bash
$ kubectl --kubeconfig=/etc/clusternet/capi.conf get clusters -A
NAMESPACE   NAME              PHASE         AGE     VERSION
default     capi-quickstart   Provisioned   3h21m   v1.24.0
$ kubectl --kubeconfig=/etc/clusternet/capi.conf get clusterresourceset -A
NAMESPACE   NAME                     AGE
default     clusternet-cluster-api   3h46m
```

When you list all the pods running in your provisioned workload clusters, you can find `clusternet-agent` are deployed as
well.

```bash
$ kubectl get pod --kubeconfig=capi-quickstart.config -A
NAMESPACE           NAME                                                  READY   STATUS    RESTARTS   AGE
clusternet-system   clusternet-agent-bf56c7cfb-6gvpj                      1/1     Running   0          7m11s
clusternet-system   clusternet-agent-bf56c7cfb-bfdt7                      1/1     Running   0          7m11s
clusternet-system   clusternet-agent-bf56c7cfb-bxvcn                      1/1     Running   0          7m11s
kube-system         coredns-6d4b75cb6d-89tb4                              1/1     Running   0          7m11s
kube-system         coredns-6d4b75cb6d-lpbsp                              1/1     Running   0          7m11s
kube-flannel        kube-flannel-ds-bgjv2                                 1/1     Running   0          7m11s
kube-flannel        kube-flannel-ds-7h6xp                                 1/1     Running   0          7m11s
kube-system         etcd-capi-quickstart-4sz8d-jfw9v                      1/1     Running   0          7m18s
kube-system         kube-apiserver-capi-quickstart-4sz8d-jfw9v            1/1     Running   0          7m19s
kube-system         kube-controller-manager-capi-quickstart-4sz8d-jfw9v   1/1     Running   0          7m19s
kube-system         kube-proxy-85ms9                                      1/1     Running   0          6m42s
kube-system         kube-proxy-dfb9x                                      1/1     Running   0          7m12s
kube-system         kube-scheduler-capi-quickstart-4sz8d-jfw9v            1/1     Running   0          7m18s
```
