---
title: "允许clusternet-hub发送重定向请求"
description: "由于 Kubernetes CVE-2022-3172，需要进行此项配置"
date: 2023-02-03
draft: false
weight: 3
---

>  `kube-apiserver` 存在安全问题，允许聚合apiserver将客户端流量重定向到任何URL。
> 这可能会导致客户端执行意外操作，并将客户端的API服务器凭据转发给第三方。.

由于安全问题 [CVE-2022-3172](https://github.com/kubernetes/kubernetes/issues/112513), `kube-apiserver` 已经在默认情况下阻止聚合apiserver的所有3XX响应，以此来加强其安全性。由于clusternet-hub在父集群中作为聚合apiserver运行，因此这个更改会对clusternet产生一些影响。clusternet-hub是值得信赖的，需要重定向功能。请确保在父集群中运行的kube-apiserver将--aggregator-reject-forwarding-redirect 的flag设置为false，以使clusternet-hub服务可以继续转发重定向请求。

受此问题影响的k8s apiserver版本列举如下：

- kube-apiserver >= v1.26.0
- kube-apiserver >= v1.25.1
- kube-apiserver >= v1.24.5
- kube-apiserver >= v1.23.11
- kube-apiserver >= v1.22.14
- kube-apiserver >= v1.21.15

当使用其他 Kubernetes 发行版时, 如果其apiserver参数中也包含有此项flag，请确保此项flag设置为 `false`.
