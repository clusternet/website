---
title: "快速开始"
description: "Clusternet 快速入门"
date: 2022-07-09
draft: false
weight: 2
---

本教程将引导您：

- 将`Clusternet`安装到本地通过 [kind](https://kind.sigs.k8s.io/) 创建的1个父集群和3个子集群中。
- 检查子集群注册状态
- 将应用程序部署到多个集群


## 准备工作

- [Helm](https://helm.sh/) 版本 v3.8.0
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 版本 v1.23.4
- [kind](https://kind.sigs.k8s.io/) 版本 v0.11.1
- [Docker](https://docs.docker.com/) 版本 v20.10.2

## 项目准备

拉取项目到本地

```bash
mkdir -p $GOPATH/src/github.com/clusternet/
cd $GOPATH/src/github.com/clusternet/
git clone https://github.com/clusternet/clusternet
cd clusternet
```

## 安装 Clusternet

执行下面脚本,

```bash
hack/local-running.sh
```

如果一切顺利，您将看到如下信息提示:

```
Local clusternet is running now.
To start using clusternet, please run:
  export KUBECONFIG="${HOME}/.kube/clusternet.config"
  kubectl config get-contexts
```

当你执行 `kubectl config get-contexts`命令时, 你会看到1个父集群和3个子集群，并且 `Clusternet`也被自动部署。

```bash
# kubectl config get-contexts
CURRENT   NAME     CLUSTER       AUTHINFO      NAMESPACE
          child1   kind-child1   kind-child1   
          child2   kind-child2   kind-child2   
          child3   kind-child3   kind-child3   
*         parent   kind-parent   kind-parent
# kubectl get pod -n clusternet-system 
NAME                                    READY   STATUS    RESTARTS   AGE
clusternet-hub-7d4bf55fbd-9lv9h         1/1     Running   0          3m2s
clusternet-scheduler-8645f9d85b-cdlr5   1/1     Running   0          2m59s
clusternet-scheduler-8645f9d85b-fmfln   1/1     Running   0          2m59s
clusternet-scheduler-8645f9d85b-vkw8r   1/1     Running   0          2m59s
```

## 检查集群注册

请按照该教程[检查集群注册状态]((/docs/tutorials/cluster-management/checking-cluster-registration/))。

## 将应用程序部署到子集群

请按照我们的[交互式教程](/docs/tutorials/multi-cluster-apps/)从父集群中将应用程序部署到上述三个子集群中。如果你在父集群中安装了 `clusternet-agent`，那么它也可以将自己注册为子集群。
