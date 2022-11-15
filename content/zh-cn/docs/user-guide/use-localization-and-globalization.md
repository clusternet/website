---
title: "Localization 和 Globalization"
description: 如何理解 Localization 和 Globalization
date: 2022-11-15
draft: false
collapsible: false
---

在 Clusternet 中, `Localization` and `Globalzation` 可以用来为资源设置覆盖值. 一个是命名空间范围的。
另一个是集群范围的。
教程 ["如何在Clusternet中设置重写功能"](/docs/tutorials/multi-cluster-apps/setting-overrides/) 里涵盖了一些使用它们的例子。

除了范围的不同，`Globalzation` 可以指定 `ClusterAffinity`，以便只对几个集群应用覆盖。

如果我们将 `ClusterAffinity` 查询设置为只匹配一个集群，那么 `Globalzation` 的工作就类似于一个
命名空间范围的 `Localization`。因此，`Globalzation` 可以被看作是 `Localization` 的超集。


```go
// ClusterAffinity is a label query over managed clusters by labels.
// If no labels are specified, all clusters will be selected.
//
// +optional
ClusterAffinity *metav1.LabelSelector `json:"clusterAffinity,omitempty"`
```

那么，为什么我们要费心设计两种覆盖对象呢？主要有以下三点。

1. **简化重复覆盖的设置**

   我们的确需要一种方法来避免创建重复的或类似的覆盖对象。如果没有 `Globalzation`，我们可能需要
   在每个专用命名空间中创建一组 `Localization` 对象，而唯一的区别是命名空间。而
   这将给我们带来太多的麻烦，当我们有相当多的集群需要管理时，需要手动创建和维护这些对象。
   此时，手动创建和维护这些对象会带来很多麻烦。因此，最好有一个标签选择器设置来匹配一组集群，这可以减少很多操作。

   而 `Localization` 将使我们更容易为单个集群设置重写。我们不需要去关心
   集群标签。


2. **RBAC规则**

   在 Clusternet 中，每个被管理的集群都有它自己的专属命名空间，命名空间里可以设置集群的特定资源、凭证
   和设置。为了更好地管理这些 RBAC设置，有 `Globalzation` 和 `Localization` 是比较方便的。
   用户可以在这些专用命名空间上拥有不同的权限。我们允许用户
   创建只在某些专用命名空间的 `Localization` 对象。

3. **隔离性和一致性**

   `Globalzation` 可以在一组被管理的集群上提供一致的覆盖设置。而 `Localization` 拥有的
   隔离性可以确保覆盖设置只应用于当前专用命名空间中的托管集群。
   对这些 `Localization` 对象的改变不会影响到在其他专用命名空间运行的其他托管集群。

