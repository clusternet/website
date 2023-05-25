---
title: "管理由 Cluster API Providers所创建的集群"
description: "如何与 Cluster API Providers协同工作"
date: 2022-11-09
draft: false
weight: 3
collapsible: false
---

实验性的功能 [ClusterResourceSet](https://cluster-api.sigs.k8s.io/tasks/experimental-features/cluster-resource-set.html)
在[Cluster API](https://github.com/kubernetes-sigs/cluster-api)项目中
允许用户在工作集群创建完成之后，自动化的在工作集群中安装额外组件. 借助于此, 由 [Cluster API](https://github.com/kubernetes-sigs/cluster-api)
providers 所创建的工作集群在Clusternet v0.12.0版本之后可以实现自动化的发现和注册.

概括来讲, 使用 `ClusterResourceSet` 自动化的安装 `clusternet-agent` 大致包括以下步骤:

1. 请确保 `ClusterResourceSet` 在您的 [Cluster API](https://github.com/kubernetes-sigs/cluster-api) 管理集群中被启用.
2. 在您的 [Cluster API](https://github.com/kubernetes-sigs/cluster-api) 管理集群中创建 `Secret` . 该`Secret`
   包括配置`clusternet-agent`所需的全部信息, 例如 bootstrap token,  父集群的endpoint,
   container 的image等.
3. `clusternet-hub` 连接到您的 [Cluster API](https://github.com/kubernetes-sigs/cluster-api) 管理集群中，
   watch所有处于 ready状态的cluster对象.
4. `clusternet-hub` 创建一个 `ClusterResourceSet` ，匹配同一namespace之下的所有工作集群.

以下各节更详细地描述了每一个步骤.

## 启用实验功能

如果您还没有完成 [Cluster API](https://github.com/kubernetes-sigs/cluster-api) 管理集群的初始化, 那么启用实验功能的推荐方式是 使用 `clusterctl`
的配置文件或环境变量. 具体来说, 需要将  `clusterctl` 配置文件中设置为`EXP_CLUSTER_RESOURCE_SET: "true"` 
或者在使用 `clusterctl init`初始化管理集群前设置环境变量 `export EXP_CLUSTER_RESOURCE_SET=true`，这将会启用 ClusterResourceSet 功能.

您也可以通过直接修改`capi-system` namespace中的Deployment `capi-controller-manager` 来启用实验功能.

```yaml
- args:
    - --metrics-addr=127.0.0.1:8080
    - --enable-leader-election
    - --feature-gates=MachinePool=false,ClusterResourceSet=true
  command:
    - /manager
```

## 为集群创建 Secret

You have to set right parameters for `clusternet-agent`, such as where should the clusters be registered to, the
container image version and the bootstrap token for cluster registration.

```bash
$ wget https://raw.githubusercontent.com/clusternet/clusternet/main/deploy/templates/clusternet_clusterapi_secret.yaml
$ IMAGE=ghcr.io/clusternet/clusternet-agent:v0.12.0 \
  PARENTURL=https://<CHANGEME>:6443 \
  REGTOKEN=07401b.f395accd246ae52d \
  envsubst < ./clusternet_clusterapi_secret.yaml | kubectl apply -f -
```

请注意将上述命令中的变量更新为您环境中的实际值.

您可以参考 [how to generate token for cluster registration](../../installation/install-the-hard-way/#deploying-clusternet-hub-in-parent-cluster)
来设置 `REGTOKEN`.

## 设置 `clusternet-hub`

对于 `clusternet-hub`来说, 他需要知道 [Cluster API](https://github.com/kubernetes-sigs/cluster-api)
管理集群的连接方式. 您可以将一个可用的kubeconfig文件设置到flag `--cluster-api-kubeconfig`之中.

```bash
--cluster-api-kubeconfig string                   Path to a kubeconfig file pointing at the management cluster for cluster-api.
```

您可以将这个文件作为一个 volume 挂载到 `clusternet-hub` pods中.

## `ClusterResourceSet` 将被自动创建

在您的 [Cluster API](https://github.com/kubernetes-sigs/cluster-api)
管理集群中, 您可以看到 `ClusterResourceSets` 被自动化的创建了.

```bash
$ kubectl --kubeconfig=/etc/clusternet/capi.conf get clusters -A
NAMESPACE   NAME              PHASE         AGE     VERSION
default     capi-quickstart   Provisioned   3h21m   v1.24.0
$ kubectl --kubeconfig=/etc/clusternet/capi.conf get clusterresourceset -A
NAMESPACE   NAME                     AGE
default     clusternet-cluster-api   3h46m
```

当您查询工作集群中运行的所有pod时, 您可以发现 `clusternet-agent` 已经被正常部署了.

```bash
$ kubectl get pod --kubeconfig=capi-quickstart.config -A
NAMESPACE           NAME                                                  READY   STATUS    RESTARTS   AGE
clusternet-system   clusternet-agent-bf56c7cfb-6gvpj                      1/1     Running   0          7m11s
clusternet-system   clusternet-agent-bf56c7cfb-bfdt7                      1/1     Running   0          7m11s
clusternet-system   clusternet-agent-bf56c7cfb-bxvcn                      1/1     Running   0          7m11s
kube-system         coredns-6d4b75cb6d-89tb4                              1/1     Running   0          7m11s
kube-system         coredns-6d4b75cb6d-lpbsp                              1/1     Running   0          7m11s
kube-flannel        kube-flannel-ds-bgjv2                                 1/1     Running   0          7m11s
kube-flannel        kube-flannel-ds-7h6xp                                 1/1     Running   0          7m11s
kube-system         etcd-capi-quickstart-4sz8d-jfw9v                      1/1     Running   0          7m18s
kube-system         kube-apiserver-capi-quickstart-4sz8d-jfw9v            1/1     Running   0          7m19s
kube-system         kube-controller-manager-capi-quickstart-4sz8d-jfw9v   1/1     Running   0          7m19s
kube-system         kube-proxy-85ms9                                      1/1     Running   0          6m42s
kube-system         kube-proxy-dfb9x                                      1/1     Running   0          7m12s
kube-system         kube-scheduler-capi-quickstart-4sz8d-jfw9v            1/1     Running   0          7m18s
```
