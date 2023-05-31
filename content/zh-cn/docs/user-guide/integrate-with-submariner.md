---
title: "与Submariner集成"
description: "将`submariner`和`clusternet`集成可以对跨集群的工作负载进行安全地访问"
date: 2023-3-25
draft: false
weight: 6
collapsible: false
---

> Submariner connects multiple Kubernetes clusters in a way that is secure and performant. Submariner flattens the
> networks between the connected clusters, and enables IP reachability between Pods and Services. Submariner also provides,
> via Lighthouse, service discovery capabilities. The service discovery model is built using the proposed
> Kubernetes Multi Cluster Services.

本文档描述了如何集成 `submariner` 和 `clusternet`.

## 部署`Clusternet`

根据该文件部署 [Installation](/docs/installation). 确保我们在父集群之下，有至少两个子集群.

在这个例子里我们有两个子集群，如下所示:
```shell
root@parent-cluster-1:~# kubectl get managedclusters.clusters.clusternet.io -A
NAMESPACE          NAME                       CLUSTER ID                             SYNC MODE   KUBERNETES   STATUS   AGE
clusternet-84jcj   clusternet-cluster-n6s2d   28f1a2fa-6bf0-4bd9-81ca-1c404088de36   Dual        v1.21.1      True     5d2h
clusternet-tp6nb   clusternet-cluster-dd87p   bcb23eca-9945-4faa-a026-bb38ef66b818   Dual        v1.26.3      True     4d19h
```

## 部署 `Submariner`
根据 [submariner官方部署文档](https://submariner.io/operations/deployment/) 使用`subctl` 部署`submariner`是被推荐的方法。
### 把父集群当作 `broker`
```shell
root@parent-cluster-1:~# subctl deploy-broker --kubeconfig ~/.kube/config
```
### 把 `cluster1` 和 `cluster2` 加入 `broker`
```shell
root@cluster1-1:~# subctl join --kubeconfig ~/.kube/config broker-info.subm --clusterid cluster1
```
```shell
root@cluster2-1:~# subctl join --kubeconfig ~/.kube/config broker-info.subm --clusterid cluster2
```
### 状态检查
```shell
root@parent-cluster-1:~# kubectl get clusters.submariner.io -n submariner-k8s-broker
NAME       AGE
cluster1   4d19h
cluster2   4d19h
root@parent-cluster-1:~# kubectl get endpoints.submariner.io -n submariner-k8s-broker
NAME                                              AGE
cluster1-submariner-cable-cluster1-192-168-1-73   4d19h
cluster2-submariner-cable-cluster2-192-168-1-36   4d19h
```
## 把应用部署下去
根据文档[Deploying Applications to Multiple Clusters with Replication Scheduling](/docs/tutorials/multi-cluster-apps/replication-scheduling-to-multiple-clusters)来部署应用.
为了进行跨集群的服务发现测试，我们这里把应用部署在`cluster1`上.

## 在`Cluster1`上把服务暴露出去
```shell
root@cluster1-1:~# subctl export service --namespace foo my-nginx-svc
```
## 在`Cluster2`上进行服务请求的测试
```shell
root@cluster2-1:~# kubectl run -n nginx-test tmp-shell --rm -i --tty --image quay.io/submariner/nettest -- /bin/bash
If you don't see a command prompt, try pressing enter.
bash-5.0# curl my-nginx-svc.foo.svc.clusterset.local
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```



