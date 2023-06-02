---
title: "Localization and Globalization"
description: "How to Understand Localization and Globalization"
date: 2022-10-19
draft: false
weight: 5
collapsible: false
---

In Clusternet, `Localization` and `Globalization` can be used to set overrides for resources. One is namespaced-scoped,
the other is cluster-scoped.
Tutorial ["How to Set Overrides in Clusternet"](/docs/tutorials/multi-cluster-apps/setting-overrides/) shows some
examples on using them.

Besides the scope difference, `Globalzation` can specify `ClusterAffinity` to apply the overrides only to a couple of
clusters. If we set a `ClusterAffinity` query to match only one cluster, then `Globalzation` would work similar to a
namespace-scoped `Localization`. Thus `Globalzation` can be regarded as a superset of `Localization`.

```go
// ClusterAffinity is a label query over managed clusters by labels.
// If no labels are specified, all clusters will be selected.
//
// +optional
ClusterAffinity *metav1.LabelSelector `json:"clusterAffinity,omitempty"`
```

So why would we bother designing two kinds of override objects? There are mainly three reasons.

1. **Simplifying the duplicate override settings**

   We do need a way to avoid creating duplicate or similar override objects. Without `Globalzation`, we may need to
   create a group of `Localization` objects in each dedicated namespace, while the only difference is the namespace. And
   this will bring us too much trouble to create and maintain these objects manually when we have quite a few of managed
   clusters. Thus, it would be better to have a label selector setting to match a group of clusters, which will help
   reduce such efforts.

   And `Localization` will make it more easy to set overrides for a single cluster. We don't need to care about the
   cluster labels.

2. **RBAC Rules**

   In Clusternet, each managed cluster has its own dedicated namespace, where cluster-specific resources, credentials
   and settings can be set. And To better manage such RBAC settings, having `Globalzation` and `Localization` are more
   convenient. Users can have different privileges on these dedicated namespaces. We can allow users to
   create `Localization` objects only in some dedicated namespaces.

3. **Isolation and consistency**

   `Globalzation` can provide consistent override settings on a group of managed clusters. While `Localization` brings
   isolation, which can make sure the override settings only applied to managed cluster in current dedicated namespace.
   Changes on these `Localization` objects will not affect other managed clusters running in other dedicated namespaces.
