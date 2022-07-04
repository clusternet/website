---
title: "Visiting Child Clusters with RBAC"
description: "Learn how to visit child clusters with RBAC from parent cluster"
date: 2022-01-17
weight: 2
---

***Clusternet supports visiting all your managed clusters with RBAC directly from parent cluster.***

Here we assume the `kube-apiserver` running in parent cluster allows **anonymous requests**. That is
flag `--anonymous-auth` (default to be `true`) is not set to `false` explicitly.

If not, an extra token from parent cluster is required.
