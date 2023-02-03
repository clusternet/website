---
title: "Allowing Requests to be Redirected by clusternet-hub"
description: "Action required for Kubernetes CVE-2022-3172"
date: 2023-02-03
draft: false
weight: 3
---

> A security issue was discovered in `kube-apiserver` that allows an aggregated API server to redirect client traffic to
> any URL. This could lead to the client performing unexpected actions as well as forwarding the client's API server
> credentials to third parties.

Due to above [CVE-2022-3172](https://github.com/kubernetes/kubernetes/issues/112513), `kube-apiserver` has tightened the
security by blocking all `3XX` responses from aggregated API servers by default. As `clusternet-hub` is running as an
aggregated apiserver in the parent cluster, this change does bring in some effects. `clusternet-hub` is trustworthy and
redirect functionality is required. Please make sure the `kube-apiserver` running in the parent cluster have set the
`--aggregator-reject-forwarding-redirect` Kubernetes API server flag to `false` to restore the previous behavior.

All the affected versions are listed as below.

- kube-apiserver >= v1.26.0
- kube-apiserver >= v1.25.1
- kube-apiserver >= v1.24.5
- kube-apiserver >= v1.23.11
- kube-apiserver >= v1.22.14
- kube-apiserver >= v1.21.15

If you're using other Kubernetes distributions, please make sure that flag has been set to `false` if existed.
