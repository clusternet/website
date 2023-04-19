---
title: "v0.12.0 (2022-09-29)"
description: "Clusternet Release v0.12.0"
date: 2022-09-29
draft: false
weight: -13
---

This release brings Clusternet to a "discovery" world. Clusters creating by [cluster-api](https://github.com/kubernetes-sigs/cluster-api) will be discovered automatically and registered to parent cluster. Auto-labelling for managed clusters is also available now. By integrating [mcs-api](https://github.com/kubernetes-sigs/mcs-api), multi-cluster services are discoverable and accessible across clusters with a virtual IP.

## Changes Since [v0.11.0](https://github.com/clusternet/clusternet/releases/tag/v0.11.0)

**Full Changelog**: https://github.com/clusternet/clusternet/compare/v0.11.0...v0.12.0

## What's Changed

### New Features & Enhancements
* addedcluster type standard (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/429)
* discovering clusters created by [cluster-api](https://github.com/kubernetes-sigs/cluster-api) (by [@dixudx]
  (https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/489, in https://github.com/clusternet/clusternet/pull/490)
* cluster auto-labelling based on [Node Feature Discovery](https://github.com/kubernetes-sigs/node-feature-discovery)
  (by [@lmxia](https://github.com/lmxia) in https://github.com/clusternet/clusternet/pull/482)
* integrated [mcs-api](https://github.com/kubernetes-sigs/mcs-api) to enable multi-cluster serivces discovery (by
  [@lmxia](https://github.com/lmxia) in https://github.com/clusternet/clusternet/pull/432,
  https://github.com/clusternet/clusternet/pull/436, https://github.com/clusternet/clusternet/pull/435,
  https://github.com/clusternet/clusternet/pull/451, https://github.com/clusternet/clusternet/pull/453,
  https://github.com/clusternet/clusternet/pull/455)
* configurable dedicated namespace when registering a child cluster (by [@DanielXLee](https://github.com/DanielXLee) in
  https://github.com/clusternet/clusternet/pull/452)
* dryrun support for child clusters (by [@yeqiugt](https://github.com/yeqiugt) in https://github.com/clusternet/clusternet/pull/463)
* added syncHandlerFunc for feedinventory controller (by [@silenceper](https://github.com/silenceper) in
  https://github.com/clusternet/clusternet/pull/472)
* used bool point for AppPusher (by [@DanielXLee](https://github.com/DanielXLee) in https://github.com/clusternet/clusternet/pull/474)
* only aggregated labels from worker nodes (by [@lmxia](https://github.com/lmxia) in https://github.com/clusternet/clusternet/pull/480)
* added more extra flags for helm install/upgrade (by [@DanielXLee](https://github.com/DanielXLee) in https://github.com/clusternet/clusternet/pull/467)
* added flag `peer-advertise-address` for `clusternet-hub` (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/443)
* supported reinstalling helm release (by [@DanielXLee](https://github.com/DanielXLee) in https://github.com/clusternet/clusternet/pull/477)
* passed down extra headers with prefix `clusternet-` (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/491)
* used patch instead of UpdateStatus to prevent conflict (by [@Garrybest](https://github.com/Garrybest) in
  https://github.com/clusternet/clusternet/pull/437)
* set max length of cluster name to 60 (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/440)
* replaced `io/ioutil` package with `io` package (by [@0xff-dev](https://github.com/0xff-dev) in https://github.com/clusternet/clusternet/pull/449)
* supported scheduler workqueue metrics (by [@silenceper](https://github.com/silenceper) in https://github.com/clusternet/clusternet/pull/450)
* supported shadowing crd itself (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/496)

### Bug Fixes
* bump helm version to `v3.8.2` to solve memory leak (by [@DanielXLee](https://github.com/DanielXLee) in
  https://github.com/clusternet/clusternet/pull/495)
* don't override empty original object for jsonpatch (by [@DanielXLee](https://github.com/DanielXLee) in https://github.com/clusternet/clusternet/pull/431)
* fixed shadow crd scheme encoding (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/433)
* re-queued Helm Release after helm repo got an update (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/438)
* added status patch rules for scheduler (by [@Garrybest](https://github.com/Garrybest) in https://github.com/clusternet/clusternet/pull/442)
* ignored custom metrics api group (by [@silenceper](https://github.com/silenceper) in https://github.com/clusternet/clusternet/pull/447)
* fixed nil assignments when collecting metrics (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/460)
* ignored apiservices self group checking (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/465, https://github.com/clusternet/clusternet/pull/466)
* added random fake uid when skipping validating objects (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/469)
* forgot workqueue key for a successful scheduling (by [@silenceper](https://github.com/silenceper) in https://github.com/clusternet/clusternet/pull/471)
* rewired `MaxHistory` for chart `Upgrade` action (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/485)
* fix merging `TargetClusters` (by [@yinsenyan](https://github.com/yinsenyan) in https://github.com/clusternet/clusternet/pull/487)
* ignored non-harmful missing parent storage errors (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/492)

### User Experiences
* added `WHAT` param to specify building targets (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/424)
* bumped build image and go version (by [@dixudx](https://github.com/dixudx) in https://github.com/clusternet/clusternet/pull/481)

## New Contributors
* [@0xff-dev](https://github.com/0xff-dev) made their first contribution in https://github.com/clusternet/clusternet/pull/449
* [@yeqiugt](https://github.com/yeqiugt) made their first contribution in https://github.com/clusternet/clusternet/pull/463

Thanks to all contributors!
