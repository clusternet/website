---
title: "Clusternet 升级"
description: "概述升级Clusternet应遵循的步骤"
date: 2023-04-07
draft: false
weight: 4
collapsible: false
---

大多数情况下，您可以直接升级Clusternet的容器映像或二进制文件。 这取决于您最初是如何部署clusternet的。

## 升级到 v0.15.0

在 v0.15.0, 介绍了一种新的组件 `clusternet-controller-manager` . 这个新组件 继承了`clusternet-hub`中的一些能力. 一些 flags 和 feature gates 也一起移动到
`clusternet-controller-manager` 之中. 这些改动将影响`clusternet-hub`的启动参数.
请关注以下改变.

- Flag `anonymous-auth-supported` 被移动到 `clusternet-controller-manager`.  
  `clusternet-hub` 中的此参数将不再可用.
- Flag `cluster-api-kubeconfig` 被移动到 `clusternet-controller-manager`. 
  `clusternet-hub` 中的此参数将不再可用.
- Feature gate `Deployer` 被移动到 `clusternet-controller-manager`. 
  `clusternet-hub` 中的此参数将不再可用.
- Feature gate `FeedInUseProtection` 被移动到 `clusternet-controller-manager`. 
  `clusternet-hub` 中的此参数将不再可用.
- Feature gate `FeedInventory` 被移动到 `clusternet-controller-manager`. 
   `clusternet-hub` 中的此参数将不再可用.
