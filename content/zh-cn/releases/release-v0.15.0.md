---
title: "v0.15.0 (2023-04-07)"
description: "Clusternet Release v0.15.0"
date: 2023-04-07
draft: false
weight: -16
---

On Mar 4th, Clusternet was approved to join CNCF as a Sandbox project. 🎉🎉🎉 Thanks for the endeavour of the whole
community. It was a HUGE milestone. ⛳⛳⛳

This release introduces a new component `clusternet-controller-manager`, which inherits the capabilities
from `clusternet-hub`. With this new component, `clusternet-hub` will focus on serving as an apiserver to provide shadow
APIs and peer connections.

In this release, we also add new features and make multiple enhancements, such as simplifying cobra commands with common
boilerplate codes and use named flagsets, migrating legacy self-cluster lease, adding metrics for Clusternet components,
etc.

## Changes Since [v0.14.0](https://github.com/clusternet/clusternet/releases/tag/v0.14.0)

**Full Changelog**: https://github.com/clusternet/clusternet/compare/v0.14.0...v0.15.0

## What's Changed

### New Features & Enhancements

- introduce new component clusternet-controller-manager (by [@zxbyoyoyo](https://github.com/zxbyoyoyo)
  in https://github.com/clusternet/clusternet/pull/638,https://github.com/clusternet/clusternet/pull/646,
  https://github.com/clusternet/clusternet/pull/646, https://github.com/clusternet/clusternet/pull/650
  and by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/647, https://github.com/clusternet/clusternet/pull/648,
  https://github.com/clusternet/clusternet/pull/649, https://github.com/clusternet/clusternet/pull/654)
- bump k8s dependencies to 1.25.6 (by [@lmxia](https://github.com/lmxia) in https://github.
  com/clusternet/clusternet/pull/597, by [@yiwei-C](https://github.com/yiwei-C)
  in https://github.com/clusternet/clusternet/pull/581)
- bump golang version to 1.19 (by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/584)
- migrate legacy self-cluster lease by [@xieydd](https://github.com/xieydd)
  in https://github.com/clusternet/clusternet/pull/586
- validate bootstrap token for cluster registration by [@xieydd](https://github.com/xieydd)
  in https://github.com/clusternet/clusternet/pull/593
- format the function name of tests (by [@autumn0207](https://github.com/autumn0207)
  in https://github.com/clusternet/clusternet/pull/594)
- optimize the validations of ClusterRegistrationOptions (by [@autumn0207](https://github.com/autumn0207)
  in https://github.com/clusternet/clusternet/pull/595)
- replace deprecated func ioutil.ReadFile (by [@yiwei-C](https://github.com/yiwei-C)
  in https://github.com/clusternet/clusternet/pull/599)
- simplify cobra commands with common boilerplate codes and use named flagsets (
  by [@yiwei-C](https://github.com/yiwei-C)
  in https://github.com/clusternet/clusternet/pull/600, https://github.com/clusternet/clusternet/pull/601,
  https://github.com/clusternet/clusternet/pull/602
  and https://github.com/clusternet/clusternet/pull/603)
- add scheduler profile validate testcase (by [@lmxia](https://github.com/lmxia)
  in https://github.com/clusternet/clusternet/pull/604)
- format clusternet-agent options (by [@xieydd](https://github.com/xieydd)
  in https://github.com/clusternet/clusternet/pull/607)
- serve metrics in clusternet-scheduler (by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/606)
- serve metrics in clusternet-agent (by [@xieydd](https://github.com/xieydd)
  in https://github.com/clusternet/clusternet/pull/608)
- bump helm to v3.10.3 (by [@xieydd](https://github.com/xieydd) in https://github.com/clusternet/clusternet/pull/615)
- bump golangci-lint to 1.51.2 (by [@lmxia](https://github.com/lmxia)
  in https://github.com/clusternet/clusternet/pull/616)
- add mcs featuregate (by [@lmxia](https://github.com/lmxia) in https://github.com/clusternet/clusternet/pull/621)
- pass down cluster ID to replicas predictor (by [@yiwei-C](https://github.com/yiwei-C)
  in https://github.com/clusternet/clusternet/pull/622)
- bump controller-gen to v0.10.0 (by [@abstractmj](https://github.com/abstractmj)
  in https://github.com/clusternet/clusternet/pull/623)
- add wait parameter on helm uninstall (by [@jasine](https://github.com/jasine)
  in https://github.com/clusternet/clusternet/pull/628)
- validate name when creating shadow namespace by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/636
- add helm options upgradeAtomic parameter (by [@wl-chen](https://github.com/wl-chen)
  in https://github.com/clusternet/clusternet/pull/635, by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/637)
- bump github.com/containerd/containerd from 1.6.12 to 1.6.18 by [@dependabot](https://github.com/dependabot)
  in https://github.com/clusternet/clusternet/pull/585
- bump actions/cache from 3.2.5 to 3.3.1 (by [@dependabot](https://github.com/dependabot)
  in https://github.com/clusternet/clusternet/pull/612, https://github.com/clusternet/clusternet/pull/626,
  https://github.com/clusternet/clusternet/pull/629)
- Clusternet joins CNCF by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/624
- bump actions/setup-go from 3 to 4 by [@dependabot](https://github.com/dependabot)
  in https://github.com/clusternet/clusternet/pull/630
- simplify the algorithm for merging feed replicas by [@yinsenyan](https://github.com/yinsenyan)
  in https://github.com/clusternet/clusternet/pull/632
- add gci linter back by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/640
- bump github.com/docker/docker from 20.10.17+incompatible to 20.10.24+incompatible
  by [@dependabot](https://github.com/dependabot)
  in https://github.com/clusternet/clusternet/pull/652
- bump clusternet v0.15.0 container images by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/589

### Bug Fixes

- fix bugs in TestGenerateClusterName (by [@autumn0207](https://github.com/autumn0207)
  in https://github.com/clusternet/clusternet/pull/596)
- use namespaced name of Subscription for new Bases (by [@yinsenyan](https://github.com/yinsenyan)
  in https://github.com/clusternet/clusternet/pull/642)
- use codecov token in CI pipeline to avoid occasionally 404 errors (by [@autumn0207](https://github.com/autumn0207)
  in https://github.com/clusternet/clusternet/pull/587)
- do deepcopy before add finalizer to avoid mis-updating (by [@abstractmj](https://github.com/abstractmj)
  in https://github.com/clusternet/clusternet/pull/644)
- triggering merge group checks in pipelines (by [@yiwei-C](https://github.com/yiwei-C)
  in https://github.com/clusternet/clusternet/pull/598)

### Security

- fix CVE-2022-41723 on maliciously crafted HTTP/2 stream causing DoS for small requests (
  by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/591)

### Roadmap

- add openssf badge and update 2023 H1 roadmap (by [@dixudx](https://github.com/dixudx)
  in https://github.com/clusternet/clusternet/pull/617, https://github.com/clusternet/clusternet/pull/618,
  https://github.com/clusternet/clusternet/pull/651)

## New Contributors

- [@autumn0207](https://github.com/autumn0207) made their first contribution
  in https://github.com/clusternet/clusternet/pull/587
- [@xieydd](https://github.com/xieydd) made their first contribution
  in https://github.com/clusternet/clusternet/pull/586
- [@abstractmj](https://github.com/abstractmj) made their first contribution
  in https://github.com/clusternet/clusternet/pull/623
- [@wl-chen](https://github.com/wl-chen) made their first contribution
  in https://github.com/clusternet/clusternet/pull/635
- [@zxbyoyoyo](https://github.com/zxbyoyoyo) made their first contribution
  in https://github.com/clusternet/clusternet/pull/638

Thanks to all contributors!
