---
title: "Balance to Services Running across Child Clusters With Fleetboard"
description: "How to make cross-cluster access to services as simple as in local cluster."
date: 2024-09-23
draft: false
weight: 1
---

For services in child clusters, we can use service name to visit them locally from any child cluster.

{{% alert title="Note" color="primary" %}}
1. [Fleetboard](https://github.com/fleetboard-io/fleetboard) requires no public IP for child clusters and
has no pre-limits of cluster IP CIDR or CNI types of kubernetes clusters.
2. Please install ``FleetBoard`` first follow the [Fleetboard Helm Docs](https://fleetboard-io.github.io/fleetboard-charts/) you
 should install ``fleetboard`` in `Hub` cluster and install ``fleetboard-agent`` in `Child` clusters.
3. After the installation, add cross cluster DNS config segment in coredns configmap, and restart coredns pods. 
The cluster-ip of crossdns is a static cluster IP, usually 10.96.0.11 , check before setting.
```shell
  fleetboard.local:53 {
      forward . 10.96.0.11
   }
```
{{% /alert %}}

## 1. Deploying applications to multiple clusters with various scheduling strategies

Please follow [this example](../../multi-cluster-apps/replication-scheduling-to-multiple-clusters). to deploy demo
applications to at least two child clusters.

```shell
$ kubectl clusternet apply -f examples/scheduling-with-mcs-api/scheduling
namespace/baz created
deployment.apps/nginx-app created
service/nginx-svc created
serviceexport.multicluster.x-k8s.io/nginx-svc created
subscription.apps.clusternet.io/scheduling-with-mcs-api created
```

## 2. Testing service availability
Now you can check and verify the endpointslices synced by ```Fleetboard``` and  the service deployed by ``clusternet`` before.

```shell
$ kubectl get endpointslice -n syncer-operator
NAME                               ADDRESSTYPE   PORTS   ENDPOINTS                          AGE
cluster1-baz-nginx-svc-v5vw6   IPv4          80      20.112.0.3,20.112.1.5,20.112.1.4   36h
$ kubectl exec -it nginx-app-9fb9fffdd-dsjxm -n baz -c alpine -- sh
/ # curl nginx-svc.baz.svc.fleetboard.local
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