---
title: "Balance to Services Running across Child Clusters"
description: "How to visit services running across child clusters"
date: 2022-09-01
draft: false
weight: 1
---

For services in child clusters, we can use service name to visit them locally from parent cluster.

{{% alert title="Note" color="primary" %}}
Make sure parent cluster can visit child clusters pod CIDR and each cluster must use distinct pod CIDRs 
that don’t conflict or overlap with any other cluster.
{{% /alert %}}

## 1. Deploying applications to multiple clusters with various scheduling strategies

Please follow [this example](../../multi-cluster-apps/replication-scheduling-to-multiple-clusters). to deploy applications to multiple clusters.

```shell
$ kubectl clusternet apply -f examples/scheduling-with-mcs-api/scheduling
namespace/baz created
deployment.apps/my-nginx created
service/my-nginx-svc created
serviceexport.multicluster.x-k8s.io/my-nginx-svc created
subscription.apps.clusternet.io/scheduling-with-mcs-api created
```


## 2. Deploying serviceimport in parent cluster
Deploy serviceimport in parent cluster, specify which service you want to import in labels:
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
## 3. Check service and endpointslice.
Now we can check and verify the endpointslice and service auto derived by `clusternet` the service start with `derived-`:

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
And the endpointslice with label `kubernetes.io/service-name: derived-baz-tc8hmv632j` :
```shell
$ kubectl get endpointslice -l kubernetes.io/service-name=derived-baz-tc8hmv632j
NAME                                      ADDRESSTYPE   PORTS   ENDPOINTS                                         AGE
clusternet-s5cmf-baz-my-nginx-svc-4rg6x   IPv4          80      10.244.1.36,10.244.1.40,10.244.1.38 + 3 more...   10m
```