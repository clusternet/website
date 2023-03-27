---
title: "Integration with Submariner"
description: "Combinations of `submariner` and `clusternet` will securely connect workloads across member clusters"
date: 2023-3-25
draft: false
weight: 3
collapsible: false
---

> Submariner connects multiple Kubernetes clusters in a way that is secure and performant. Submariner flattens the
> networks between the connected clusters, and enables IP reachability between Pods and Services. Submariner also provides,
> via Lighthouse, service discovery capabilities. The service discovery model is built using the proposed 
> Kubernetes Multi Cluster Services.

This page shows how to integrate `submariner` with `clusternet`.

## Deploy `Clusternet`

Just follow [Installation](/docs/installation). Ensure that at least two member clusters are joined to parent cluster.

In this example, we have joined two member clusters:
```shell
root@parent-cluster-1:~# kubectl get managedclusters.clusters.clusternet.io -A
NAMESPACE          NAME                       CLUSTER ID                             SYNC MODE   KUBERNETES   STATUS   AGE
clusternet-84jcj   clusternet-cluster-n6s2d   28f1a2fa-6bf0-4bd9-81ca-1c404088de36   Dual        v1.21.1      True     5d2h
clusternet-tp6nb   clusternet-cluster-dd87p   bcb23eca-9945-4faa-a026-bb38ef66b818   Dual        v1.26.3      True     4d19h
```

## Deploy `Submariner`
The recommended deployment method is `subctl` according to [submariner official deployment documentation](https://submariner.io/operations/deployment/).
### use parent-cluster as `broker`
```shell
root@parent-cluster-1:~# subctl deploy-broker --kubeconfig ~/.kube/config
```
### join `cluster1` and `cluster2` to `broker`
```shell
root@cluster1-1:~# subctl join --kubeconfig ~/.kube/config broker-info.subm --clusterid cluster1
```
```shell
root@cluster2-1:~# subctl join --kubeconfig ~/.kube/config broker-info.subm --clusterid cluster2
```
### status check
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
## Deploying Applications to Multiple Clusters
Just follow [Deploying Applications to Multiple Clusters with Replication Scheduling](/docs/tutorials/multi-cluster-apps/replication-scheduling-to-multiple-clusters).
We need to deploy the application on `cluster1` for discovery.

## Export Service in `Cluster1`
```shell
root@cluster1-1:~# subctl export service --namespace foo my-nginx-svc
```
## Network Connect Test from `Cluster2`
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



