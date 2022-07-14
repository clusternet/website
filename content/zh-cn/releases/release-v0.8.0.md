---
title: "v0.8.0 (2022-03-04)"
description: "Clusternet Release v0.8.0"
date: 2022-03-04
draft: false
weight: -8
---

This version mainly introduced [OCI-based Helm charts](https://helm.sh/docs/topics/registries/). Clusternet is the ***first*** project that supports this feature in multiple cluster management. Also unexpected operations (like deleting, updating) that occurred solely inside a child cluster will be rolled back automatically unless those were made explicitly from parent cluster, which kept applications running more stable in child clusters. Kubernetes v1.23 was fully supported as well.

## Changes Since [v0.7.0](https://github.com/clusternet/clusternet/releases/tag/v0.7.0)
**Full Changelog**: https://github.com/clusternet/clusternet/compare/v0.7.0...v0.8.0

## What's Changed

### New Features & Enhancements
* Fully support [OCI-based Helm charts](https://helm.sh/docs/topics/registries/) (by [@dixudx](https://github.com/dixudx) in [#247](https://github.com/clusternet/clusternet/pull/247),[#255](https://github.com/clusternet/clusternet/pull/255), [#224](https://github.com/clusternet/clusternet/pull/224) and [@rootdeep](https://github.com/rootdeep) in [#257](https://github.com/clusternet/clusternet/pull/257)). Clusternet is the first project that support this feature in multi-cluster management.
* Golang version was bumped to 1.17 (by [@dixudx](https://github.com/dixudx) in [#247](https://github.com/clusternet/clusternet/pull/247),[#241](https://github.com/clusternet/clusternet/pull/241))
* Default timeout `5m0s` was applied to helm deployer, which stayed the same with `Helm` command line (by [@dixudx](https://github.com/dixudx) in [#225](https://github.com/clusternet/clusternet/pull/225))
* Alternative label `app.kubernetes.io/component` was added when finding kube-apiserver pod (by [@fangyuchen86](https://github.com/fangyuchen86) in [#227](https://github.com/clusternet/clusternet/pull/227))
* Collecting and reporting Nvidia GPU statics in child clusters (by [@lmxia](https://github.com/lmxia) in [#235](https://github.com/clusternet/clusternet/pull/235))
* Unexpected operations (like deleting, updating) that occurred solely inside a child cluster will be rolled back automatically unless those were made explicitly from parent cluster (by [@lmxia](https://github.com/lmxia) in [#242](https://github.com/clusternet/clusternet/pull/242)). A new feature gate named `Recovery` was added as well (by [@dixudx](https://github.com/dixudx) in [#226](https://github.com/clusternet/clusternet/pull/226)).

### Bug Fixes
* Fixing scheduler issue when cluster affinity rules matched no clusters (by [@DanielXLee](https://github.com/DanielXLee) in [#239](https://github.com/clusternet/clusternet/pull/239))
* Fixing nonresource 403 errors (by [@dixudx](https://github.com/dixudx) in [#248](https://github.com/clusternet/clusternet/pull/248))

### Security Enhancements
* Upgrading dependency `github.com/containerd/containerd` to `1.5.10` to mitigate CVE-2022-23648 (by [@dixudx](https://github.com/dixudx) in [#258](https://github.com/clusternet/clusternet/pull/258))

### Misc
* Clusternet got a logo 🎉. Thank our designer ***Zuowei Li***.
* Kubernetes v1.23 was supported as well.

## New Contributors
* [@fangyuchen86](https://github.com/fangyuchen86) made their first contribution in [#227](https://github.com/clusternet/clusternet/pull/227)
* [@rootdeep](https://github.com/rootdeep) made their first contribution in [#257](https://github.com/clusternet/clusternet/pull/257)

**Thanks all contributors in this release.**
