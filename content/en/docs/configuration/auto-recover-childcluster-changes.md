---
title: "Recover All Changes Happens in Child Clusters."
description: "This helps rollback unexpected operations (like deleting, updating) that occurred solely inside a child cluster."
date: 2023-03-21
draft: false
weight: 3
---

> Clusternet-agent provide a feature gate `Recovery` which allows to rollback any changes inside a child cluster.
> It's `false` by default.

So after you try [Deploying Applications to Multiple Clusters with Replication Scheduling](../../tutorials/multi-cluster-apps/replication-scheduling-to-multiple-clusters/),
in child cluster `child-1`, and scale the replicas of `nginx-deploy` from 3 to 1, the replicas remains at 1:
```shell
root@child-1:~# kubectl  scale deploy my-nginx -n foo --replicas=1
root@child-1:~# kubectl  get po -n foo -w
NAME                        READY   STATUS    RESTARTS   AGE
my-nginx-66b6c48dd5-9dpxt   1/1     Running   0          58s
```
As has described the feature gate `Recovery` is `false` by default in clusternet-agent, so if you want to ensure the resources deployed 
by clusternet exist persistently in a child cluster, you should set this feature gate to `true` in clusternet-agent:`--feature-gates=Recovery=true`

Then try again! It will work like below, any changes in child clusters will be recovered.

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