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

- [Helm](https://helm.sh/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectl plugin "clusternet"](/docs/kubectl-clusternet)
- [kind](https://kind.sigs.k8s.io/)
- [Docker](https://docs.docker.com/)

### Some Known Issues

#### Pod errors due to "too many open files"

You may encounter that some pods fail to get running and the logs of these pods complain "too many open files".

This may be caused by running out of [inotify](https://linux.die.net/man/7/inotify) resources.
Resource limits are defined by `fs.inotify.max_user_watches` and `fs.inotify.max_user_instances` system variables. For 
example, in Ubuntu these default to `8192` and `128` respectively, which is not enough to create multiple kind 
clusters with many pods.

To increase these limits temporarily run the following commands on the host:

```bash
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512
```

To make the changes persistent, edit the file `/etc/sysctl.conf` and add these lines:

```
fs.inotify.max_user_watches = 524288
fs.inotify.max_user_instances = 512
```

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
NAME                                            READY   STATUS    RESTARTS   AGE
clusternet-controller-manager-5b54d5f95-bnq8l   1/1     Running   0          2m
clusternet-controller-manager-5b54d5f95-kn6mw   1/1     Running   0          2m
clusternet-controller-manager-5b54d5f95-pkmc6   1/1     Running   0          2m
clusternet-hub-6c7bbcbd68-flbwm                 1/1     Running   0          2m3s
clusternet-hub-6c7bbcbd68-m4rkx                 1/1     Running   0          2m3s
clusternet-hub-6c7bbcbd68-rkw5c                 1/1     Running   0          2m3s
clusternet-scheduler-8675d64884-4r8rx           1/1     Running   0          2m1s
clusternet-scheduler-8675d64884-7nx5d           1/1     Running   0          2m1s
clusternet-scheduler-8675d64884-8c8f5           1/1     Running   0          2m1s
```

## Checking Cluster Registration

Please follow this tutorial
on [checking cluster registration status](/docs/tutorials/cluster-management/checking-cluster-registration/).

## Deploying Applications to Child Clusters

Please follow our [interactive tutorials](/docs/tutorials/multi-cluster-apps/) to deploy applications to above three
child clusters from parent cluster. And the parent cluster can register itself as a child cluster as well, if you
install `clusternet-agent` on it.
