---
title: "HelmChart"
date: 2023-02-01
weight: 3
description: "配置 HelmChart"
---

## replaceCRDs

- [Helm的设计实现不支持升级或删除CRD](https://helm.sh/zh/docs/chart_best_practices/custom_resource_definitions)， 当通过clusternet 创建了`HelmRelease`之后，如果`HelmChart`更新升级， `CRD`资源发生了变更，可能会因`CR`与`CRD`不匹配而导致`HelmRelease`安装或更新失败。

- `HelmChart` spec 中的`replaceCRDs` 选项设置为`true`时（默认`false`）时clusternet会在helm install/upgrade 之前replace helm chart及所有子chart中的crd资源以解决上述问题。

- 当`skipCRDs`为`true`时 `replaceCRDs` 选项不生效。


## 其他配置
- 如 `atomic`,`createNamespace`,`disableHooks`, `force`, `replace`, `skipCRDs`, `timeoutSeconds`, `wait`, `waitForJob`等均与 helm 一致，参阅[helm 文档](https://helm.sh/zh/docs/helm/helm_install/)
