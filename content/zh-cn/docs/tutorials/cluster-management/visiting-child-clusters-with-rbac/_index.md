---
title: "通过RBAC权限来访问子集群"
description: "了解如何从父集群使用RBAC访问子集群"
date: 2022-01-17
weight: 2
---

***Clusternet支持直接从父集群使用RBAC访问所有托管集群.***

这里我们假设在父集群中运行的`kube-apiserver`允许**匿名请求**。 那是
标志`--anonymous-auth`（默认为`true`）未明确设置为`false`。

如果没有，则需要来自父集群的额外令牌.
