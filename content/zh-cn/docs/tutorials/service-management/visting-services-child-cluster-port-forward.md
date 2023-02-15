---
title: "本地访问子集群中运行的服务"
description: "如何以本地方式访问子集群中运行的服务"
date: 2022-08-22
draft: false
weight: 1
---

For services/pods running in child clusters, we can use `port-forward` to visit them locally.

First please make sure `kubectl clusternet` must be at or later than version v0.7.0. Please
follow [how to upgrade clusternet plugin with krew](../../kubectl-clusternet.md).

```bash
$ kubectl clusternet version
{
  "gitVersion": "0.7.0",
  "gitCommit": "42ce8b65d04d838563a411a61706a21349431b8b",
  "buildDate": "2022-08-22T03:27:19Z",
  "platform": "darwin/arm64"
}
```

## 1. Get the cluster ID

We list all the `ManagedClusters` to get the cluster id we want.

```shell
$ kubectl get mcls -A
NAMESPACE          NAME                       CLUSTER ID                             SYNC MODE   KUBERNETES   STATUS   AGE
clusternet-jjz75   clusternet-cluster-9gc5d   c1a5e75c-9e38-4279-b1c9-2345e612b9e5   Dual        v1.23.8      True     11m
```

## 2. View the services running in child cluster

Now we list services in default namespace of managed cluster with ID `c1a5e75c-9e38-4279-b1c9-2345e612b9e5`.

```shell
$ kubectl clusternet get svc --cluster-id=c1a5e75c-9e38-4279-b1c9-2345e612b9e5 --child-kubeconfig=./child-kubeconfig
NAME            TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.96.0.1    <none>        443/TCP   27m
my-nginx-test   ClusterIP   10.96.8.0    <none>        80/TCP    4m46s
```

## 3. Forward a local port to a port on the service

`kubectl clusternet port-forward` allows using resource name, such as a service name, to select a matching service to
port forward to. It follows the same usage as `kubectl port-forward`, but appending two extra arguments `--cluster-id`
and `--child-kubeconfig`.

```shell
$ kubectl clusternet port-forward --namespace default \
  --cluster-id=c1a5e75c-9e38-4279-b1c9-2345e612b9e5 \
  --child-kubeconfig=./child-kubeconfig \
  svc/my-nginx-test 8080:80
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
Handling connection for 8080
```

Now in another terminal, we can locally visit the services running in child cluster (cluster ID:
c1a5e75c-9e38-4279-b1c9-2345e612b9e5) now. The output is similar to:

```shell
$ curl http://localhost:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
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
