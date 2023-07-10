---
title: "在K3S上安装Clusternet"
description: "如何在K3S上安装Clusternet"
date: 2023-07-10
draft: false
weight: 4
collapsible: false
---

在[K3S](https://k3s.io/)集群中安装Clusternet需要做一些额外的配置

#### 设置 anonymous-auth 为 false

- 如果是[通过Helm安装](/zh-cn/docs/installation/install-with-helm), 需要为 clusternet-hub 和clusternet-controller-manager 两个Chart的value文件设置`anonymousAuthSupported` 为`false`
- 如果是[手动安装clusternet](/zh-cn/docs/installation/install-the-hard-way), 需要为 clusternet-hub 和 clusternet-controller-manager  设置`--anonymous-auth=false` 命令行参数

#### 创建Serviceaccount Token
- `kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_serviceaccount_token.yaml`
