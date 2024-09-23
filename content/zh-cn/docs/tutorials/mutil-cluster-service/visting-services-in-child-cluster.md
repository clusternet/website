---
title: "从一个子集群通过服务名称访问其他子集群的service"
description: "如何访问部署在子集群中的服务"
date: 2024-09-23
draft: false
weight: 1
---

对于调度到子集群中的服务, 我们可以从其他子集群中通过服务名称直接访问.

{{% alert title="Note" color="primary" %}}
1. [Fleetboard](https://github.com/fleetboard-io/fleetboard) 是一个非常新颖的多集群服务打通方案，不再要求集群提供公网IP，
也不在限制集群的Pod CIDR是否重叠，也不再约束集群的CNI类型.
2. 请先安装``FleetBoard``安装过程参照：[Fleetboard Helm Docs](https://fleetboard-io.github.io/fleetboard-charts/)，
在 `Hub` 集群安装``fleetboard`` ， 在`Child` 集群中安装``fleetboard-agent``。
3. 安装完成后，需要袖coredns的configmap，补充跨集群的DNS配置段，并重启coredns pod。 crossdns的cluster-ip 
是一个静态static cluster IP，一般是 `10.96.0.11`,请在设置前检查一下。
```shell
  fleetboard.local:53 {
      forward . 10.96.0.11
   }
```
{{% /alert %}}

## 1. 根据部署策略将应用部署到子集群中

请参考 [this example](../../multi-cluster-apps/replication-scheduling-to-multiple-clusters). 来部署应用.

```shell
$ kubectl clusternet apply -f examples/scheduling-with-mcs-api/scheduling
namespace/baz created
deployment.apps/nginx-app created
service/nginx-svc created
serviceexport.multicluster.x-k8s.io/nginx-svc created
subscription.apps.clusternet.io/scheduling-with-mcs-api created
```

## 2. 测试服务的可用性
``Fleetboard``会帮我们把endpointslices 同步在所有子集群中，现在你可以在子集群中检查下这些endpointslice和``clusternet``部署的service。

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