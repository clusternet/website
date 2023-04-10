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

- [Helm](https://helm.sh/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectl 插件 "clusternet"](/docs/kubectl-clusternet)
- [kind](https://kind.sigs.k8s.io/)
- [Docker](https://docs.docker.com/)

### Some Known Issues

#### Pod errors due to "too many open files"

You may encounter that some pods fail to get running and the logs of these pods complain "too many open files".

This may be caused by running out of [inotify](https://linux.die.net/man/7/inotify) resources.
Resource limits are defined by `fs.inotify.max_user_watches` and `fs.inotify.max_user_instances` system variables. For
example, in Ubuntu these default to `8192` and `128` respectively, which is not enough to create multiple kind
clusters with many pods.

To increase these limits temporarily run the following commands on the host:

```bash
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512
```

To make the changes persistent, edit the file `/etc/sysctl.conf` and add these lines:

```
fs.inotify.max_user_watches = 524288
fs.inotify.max_user_instances = 512
```

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
NAME                                            READY   STATUS    RESTARTS   AGE
clusternet-controller-manager-5b54d5f95-bnq8l   1/1     Running   0          2m
clusternet-controller-manager-5b54d5f95-kn6mw   1/1     Running   0          2m
clusternet-controller-manager-5b54d5f95-pkmc6   1/1     Running   0          2m
clusternet-hub-6c7bbcbd68-flbwm                 1/1     Running   0          2m3s
clusternet-hub-6c7bbcbd68-m4rkx                 1/1     Running   0          2m3s
clusternet-hub-6c7bbcbd68-rkw5c                 1/1     Running   0          2m3s
clusternet-scheduler-8675d64884-4r8rx           1/1     Running   0          2m1s
clusternet-scheduler-8675d64884-7nx5d           1/1     Running   0          2m1s
clusternet-scheduler-8675d64884-8c8f5           1/1     Running   0          2m1s
```

## 检查集群注册

请按照该教程[检查集群注册状态](/docs/tutorials/cluster-management/checking-cluster-registration/)。

## 将应用程序部署到子集群

请按照我们的[交互式教程](/docs/tutorials/multi-cluster-apps/)从父集群中将应用程序部署到上述三个子集群中。
如果你在父集群中安装了 `clusternet-agent`，那么它也可以将自己注册为子集群。
