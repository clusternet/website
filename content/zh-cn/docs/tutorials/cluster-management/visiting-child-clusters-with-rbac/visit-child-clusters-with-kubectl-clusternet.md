---
title: "通过 kubectl-clusternet 插件访问子集群"
description: "访问子集群的最简单和最推荐的方式"
date: 2022-01-17
draft: false
weight: 1
---

Before moving forward, please follow [this guide](/docs/configuration/aggregator-forwarding-redirect/) to make sure
that redirecting requests by `clusternet-hub` are supported in your parent cluster.

首先,
请 [安装/升级 `kubectl-clusternet` 插件](https://github.com/clusternet/kubectl-clusternet#installation) 最低要求的版本 `v0.5.0`.

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

这里上面的 kubeconfig 文件 `azure-cd-kubeconfig` 中的 apiserver 可能带有一个内部地址。 现在您可以轻松
检查子集群中的任何对象状态。
