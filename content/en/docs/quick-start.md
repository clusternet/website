---
title: "Quick Start"
description: "A quick start to know Clusternet"
date: 2022-03-08
draft: false
weight: 2
---

This tutorial walks you through,

- setting up `Clusternet` locally with 1 parent cluster and 3 child clusters by using
  [kind](https://kind.sigs.k8s.io/)
- checking child clusters registration status
- deploying applications to multiple clusters

## Prerequisites

- [Helm](https://helm.sh/) version v3.8.0
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) version v1.23.4
- [kind](https://kind.sigs.k8s.io/) version v0.11.1
- [Docker](https://docs.docker.com/) version v20.10.2

## Clone Clusternet

Clone the repository,

```bash
mkdir -p $GOPATH/src/github.com/clusternet/
cd $GOPATH/src/github.com/clusternet/
git clone https://github.com/clusternet/clusternet
cd clusternet
```

## Install Clusternet

Run the following script,

```bash
cd hack
./local-running.sh
```

If everything goes well, you will see the messages as follows:

```
Local clusternet is running now.
To start using clusternet, please run:
  export KUBECONFIG="${HOME}/.kube/clusternet.config"
  kubectl config get-contexts
```

When you run `kubectl config get-contexts`, you will see 1 parent cluster and 3 child clusters and the clusternet has
been deployed automatically.

```bash
$ kubectl config get-contexts
CURRENT   NAME     CLUSTER       AUTHINFO      NAMESPACE
          child1   kind-child1   kind-child1   
          child2   kind-child2   kind-child2   
          child3   kind-child3   kind-child3   
*         parent   kind-parent   kind-parent
$ kubectl get pod -n clusternet-system
NAME                                    READY   STATUS    RESTARTS   AGE
clusternet-hub-7d4bf55fbd-9lv9h         1/1     Running   0          3m2s
clusternet-scheduler-8645f9d85b-cdlr5   1/1     Running   0          2m59s
clusternet-scheduler-8645f9d85b-fmfln   1/1     Running   0          2m59s
clusternet-scheduler-8645f9d85b-vkw8r   1/1     Running   0          2m59s
```

## Checking Cluster Registration

Please follow this tutorial
on [checking cluster registration status](/docs/tutorials/cluster-management/checking-cluster-registration/).

## Deploying Applications to Child Clusters

Please follow our [interactive tutorials](/docs/tutorials/multi-cluster-apps/) to deploy applications to above three
child clusters from parent cluster. And the parent cluster can register itself as a child cluster as well, if you
install `clusternet-agent` on it.
