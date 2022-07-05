---
title: "Visiting Child Clusters via kubectl-clusternet plugin"
description: "The easiest and most recommended way to visit child clusters"
date: 2022-01-17
draft: false
weight: 1
---

First,
please [install/upgrade `kubectl-clusternet` plugin](https://github.com/clusternet/kubectl-clusternet#installation) with
a minimum required version `v0.5.0`.

```bash
$ kubectl clusternet version
{
  "gitVersion": "0.5.0",
  "platform": "darwin/amd64"
}
```

```bash
$ kubectl get mcls -A
NAMESPACE          NAME       CLUSTER ID                             SYNC MODE   KUBERNETES                   READYZ   AGE
clusternet-ml6wg   aws-cd     6c085c18-3baf-443c-abff-459751f5e3d3   Dual        v1.18.4                      true     4d6h
clusternet-z5vqv   azure-cd   7dc5966e-6736-48dd-9a82-2e4d74d30443   Dual        v1.20.4                      true     43h
$ kubectl clusternet --cluster-id=7dc5966e-6736-48dd-9a82-2e4d74d30443 --child-kubeconfig=./azure-cd-kubeconfig get ns
NAME                STATUS   AGE
clusternet-system   Active   4d20h
default             Active   24d
kube-node-lease     Active   24d
kube-public         Active   24d
kube-system         Active   24d
test-nginx          Active   11d
test-systemd        Active   11d
```

Here the apiserver in above kubeconfig file `azure-cd-kubeconfig` could be with an inner address. Now you can easily
check any objects status in child clusters.
