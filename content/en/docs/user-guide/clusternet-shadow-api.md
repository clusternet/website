---
title: "Resources Creation in Clusternet"
description: "How Clusternet Manages Resources in a Separate View"
date: 2022-10-18
draft: false
weight: 2
collapsible: false
---

This page shows how Clusternet manages resources in a separate view inside a Kubernetes cluster.

Clusternet is designed as an add-on that can be deployed to a Kubernetes cluster. So the problem is how we differentiate
resources creations from `kube-apiserver`. For example, when we create a `Deployment` towards `kube-apiserver`, the
Kubernetes control plane gets notified and provisions pods with desired replicas. For multiple cluster management, this
behavior is not what we want, because we don't want pods created in our management cluster. What we do want is to regard
this `Deployment` as a template resource, so we can distribute it to multiple child clusters.

Thus, we need to create a separate view for these resources. In Clusternet, we create **shadow APIs** to implement this.
The component `clusternet-hub` runs as an aggregated apiserver and serves at `shadow/v1alpha1` to provide **shadow
APIs** for all registered resources, including native Kubernetes resources (`Deployment`, `Configmap`, `Namespace`, etc)
and custom resources.

Below image shows how Clusternet creates a separate view for all kinds of resources. Clusternet provides
a [client-go wrapper](/docs/tutorials/using-client-go-in-clusternet/) to automatically transform requests
to `shadow/v1alpha1` group. For example, this wrapper will transform requests
with `/apis/apps/v1/namespace/abc/deployments` to `/apis/shadow/v1alpha1/namespace/abc/deployments`. All these
transformed requests will be automatically forwarded to `clusternet-hub` by `kube-apiserver`. All CRDs defined by
Clusternet will not be shadowed. `clusternet-hub` will interpret the object and store as a `Manifest` object. In such a
way, Clusternet creates a separate view for all kinds of resources.

![](/images/clusternet-shadow-api.png)

For command line operations, we can use `kubectl clusternet` to manage these resources, such as creation, deletion,
modification, etc. This plugin brings a consistent using experience with `kubectl`. Learn more
from [kubectl clusternet plugin](/docs/kubectl-clusternet/).

Below command snippets show the magic of **shadow APIs**, where we can have a separate view for resources.

```shell
# list namespaces with kubectl clusternet plugin
# we can not see those kube namespaces
$ kubectl clusternet get ns
No resources found
# create namespace with kubectl clusternet plugin
$ kubectl clusternet create ns abc
namespace/abc created
# list namespaces with kubectl clusternet plugin
$ kubectl clusternet get ns
NAME   STATUS   AGE
abc             3s
# list namespaces natively with kubectl
# namespace abc is not in this list as well
$ kubectl get ns
NAME                  STATUS   AGE
clusternet-reserved   Active   98s
clusternet-system     Active   98s
default               Active   12m
kube-flannel          Active   2m36s
kube-node-lease       Active   12m
kube-public           Active   12m
kube-system           Active   12m
```

For client-go operations, please
follow [clusternet wrapper in client-go](/docs/tutorials/using-client-go-in-clusternet/).
