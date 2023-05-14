---
title: "父集群中直接通过服务去访问部署在子集群中的服务"
description: "如何访问部署在子集群中的服务"
date: 2022-09-01
draft: false
weight: 1
---

对于调度到子集群中的服务, 我们可以在父集群中通过服务名称或者cluster ip直接访问.

{{% alert title="Note" color="primary" %}}
1. 确保父集群可以直接访问子集群的pod网段，并且子集群间的pod网段没有冲突或者重叠。
2. 确保特性`MultiClusterService`在`clusternet-agent`和`clusternet-controller-manager`侧都是`true`，你可以直接编辑`clusternet-agent`和`clusternet-controller-manager`这
两个deployment:`--feature-gates=xxx,MultiClusterService=true`
{{% /alert %}}

## 1. 根据部署策略将应用部署到子集群中

请参考 [this example](../../multi-cluster-apps/replication-scheduling-to-multiple-clusters). 来部署应用.

```shell
$ kubectl clusternet apply -f examples/scheduling-with-mcs-api/scheduling
namespace/baz created
deployment.apps/my-nginx created
service/my-nginx-svc created
serviceexport.multicluster.x-k8s.io/my-nginx-svc created
subscription.apps.clusternet.io/scheduling-with-mcs-api created
```


## 2. 在父集群中部署serviceimport CRD资源
在父集群中部署serviceimport资源，需要在labels指明需要引出的服务名称和它在子集群中的命名空间:
```shell
apiVersion: multicluster.x-k8s.io/v1alpha1
kind: ServiceImport
metadata:
  name: my-svc
  namespace: default
  labels:
    services.clusternet.io/multi-cluster-service-name: my-nginx-svc # must be same to the service name you want to expose
    services.clusternet.io/multi-cluster-service-namespace: baz # must be same to the service namespace
spec:
  ips:
    - 42.42.42.42
  type: "ClusterSetIP"
  ports:
  - port: 80
    protocol: TCP
  sessionAffinity: None
```
```shell
$ kubectl create -f examples/scheduling-with-mcs-api/service-import.yaml
serviceimport.multicluster.x-k8s.io/my-svc created
```
## 3. 检验服务和endpointslice资源.
现在可以检验由`clusternet`自动生成的service资源和endpointslice资源， 服务名称以`derived-`开头:

```shell
root@worker-cluster1-1:~/clusternet# kubectl get svc 
NAME                     TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
derived-baz-tc8hmv632j   ClusterIP      10.11.178.229   <none>         80/TCP         1d
kubernetes               ClusterIP      10.11.0.1       <none>         443/TCP        306d
root@worker-cluster1-1:~/clusternet# kubectl get svc derived-baz-tc8hmv632j -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2022-09-01T07:42:31Z"
  name: derived-baz-tc8hmv632j
  namespace: default
  resourceVersion: "100369299"
  selfLink: /api/v1/namespaces/default/services/derived-baz-tc8hmv632j
  uid: 91c19b02-c15b-4166-9bcc-6931d0859723
spec:
  clusterIP: 10.11.178.229
  clusterIPs:
  - 10.11.178.229
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer:
    ingress:
    - ip: 42.42.42.42
```
可以看到endpointslice资源已经打上了该label： `kubernetes.io/service-name: derived-baz-tc8hmv632j`
```shell
$ kubectl get endpointslice -l kubernetes.io/service-name=derived-baz-tc8hmv632j
NAME                                      ADDRESSTYPE   PORTS   ENDPOINTS                                         AGE
clusternet-s5cmf-baz-my-nginx-svc-4rg6x   IPv4          80      10.244.1.36,10.244.1.40,10.244.1.38 + 3 more...   10m
```