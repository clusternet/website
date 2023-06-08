---
title: "覆盖子集群中的所有变化"
description: "本配置可以将子集群中的所有修改，比如删除、更新，覆盖掉。"
date: 2023-03-21
draft: false
weight: 1
---

> Clusternet-agent 提供了一个特性开关`Recovery`它允许把子集群中的全部变化悉数回滚，这个特性默认是`关闭`的。

你可以通过这个链接 [Deploying Applications to Multiple Clusters with Replication Scheduling](../../tutorials/multi-cluster-apps/replication-scheduling-to-multiple-clusters/),
把负载部署在子集群`child-1`中,并把foo命名空间中的deployment `nginx-deploy` 中的副本数量从3修改为1，这个数量，将一直保持下去:
```shell
root@child-1:~# kubectl  scale deploy my-nginx -n foo --replicas=1
root@child-1:~# kubectl  get po -n foo -w
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-9dpxt   1/1     Running   0          58s
```
由于这个特性开关默认是关闭状态, 如果你想要将子集群的资源与`clusternet-hub`长期的保持一致, 你需要在`clusternet-agent`打开这个特性开关:`--feature-gates=Recovery=true`

再试一次，你会发现任何在子集群中的变更，都将恢复成`clusternet-hub`的配置！

```shell
root@child-1:~# kubectl  get po -n foo
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-6vqtx   1/1     Running   0          13s
my-nginx-66b6c48dd5-9dpxt   1/1     Running   0          2m40s
my-nginx-66b6c48dd5-jw9kr   1/1     Running   0          13s
root@child-1:~#  kubectl  scale deploy my-nginx -n foo --replicas=1
deployment.apps/my-nginx scaled
root@child-1:~# kubectl  get po -n foo
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-9dpxt   1/1     Running   0          3m9s
root@child-1:~# kubectl  get po -n foo -w
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-9dpxt   1/1     Running   0          2m25s
my-nginx-66b6c48dd5-jw9kr   0/1     Pending   0          0s
my-nginx-66b6c48dd5-jw9kr   0/1     Pending   0          0s
my-nginx-66b6c48dd5-6vqtx   0/1     Pending   0          0s
my-nginx-66b6c48dd5-6vqtx   0/1     Pending   0          0s
my-nginx-66b6c48dd5-jw9kr   0/1     ContainerCreating   0          0s
my-nginx-66b6c48dd5-6vqtx   0/1     ContainerCreating   0          0s
my-nginx-66b6c48dd5-jw9kr   1/1     Running             0          1s
my-nginx-66b6c48dd5-6vqtx   1/1     Running             0          1s
```