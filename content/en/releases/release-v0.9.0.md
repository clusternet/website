---
title: "v0.9.0 (2022-04-13)"
description: "Clusternet Release v0.9.0"
date: 2022-04-13
draft: false
weight: -9
---

This version introduced static diving scheduling which would help splitting workloads into multiple clusters. For example, if you want to deploy a `Deployment` with a total of 6 replicas to 2 clusters ("cluster-01" with weight 1, "cluster-02" with weight 2), then "cluster-01" will run such a `Deployment` with 2 replicas, "cluster-02" runs the other 4 replicas. Please learn more from [this tutorial](https://github.com/clusternet/clusternet/blob/main/docs/tutorials/static-weight-scheduling-to-multiple-clusters.md).  Several new fields `spec.overrides` and `spec.releaseName` were introduced for `HelmRelease`. Multiple bugs were fixed as well, such as crd storage race condition, in-deleting `Description` rolling back, etc.

***Please use patch version [v0.9.1](https://github.com/clusternet/clusternet/releases/tag/v0.9.1) instead!!!***

## Changes Since [v0.8.0](https://github.com/clusternet/clusternet/releases/tag/v0.8.0)
**Full Changelog**: https://github.com/clusternet/clusternet/compare/v0.8.0...v0.9.0

## What's Changed

### New Features & Enhancements
* Adding a local script that helps establish a local environment with one parent cluster and 3 child clusters. (by [@Garrybest](https://github.com/Garrybest) in [#251](https://github.com/clusternet/clusternet/pull/251))
* Adding tests against golang 1.18.  (by [@dixudx](https://github.com/dixudx) in [#270](https://github.com/clusternet/clusternet/pull/270))
* Introducing new field `spec.overrides` for `HelmRelease`. (by [@dixudx](https://github.com/dixudx) in [#272](https://github.com/clusternet/clusternet/pull/272))
* Introducing new field `spec.releaseName` (default to the same value as `HelmChart` name) in `HelmRelease`, which is backwards compatible. (by [@dixudx](https://github.com/dixudx) in [#269](https://github.com/clusternet/clusternet/pull/269))
* Using `/healthz` to report the status of managed clusters whose Kubernetes versions are under v1.16. (by [@DanielXLee](https://github.com/rootdeep) in [#291](https://github.com/clusternet/clusternet/pull/291))
* Introducing static dividing scheduling based on cluster weights. (by [@Garrybest](https://github.com/Garrybest) in [#265](https://github.com/clusternet/clusternet/pull/265), [#283](https://github.com/clusternet/clusternet/pull/283), [#292](https://github.com/clusternet/clusternet/pull/292), [#296](https://github.com/clusternet/clusternet/pull/296) and [@dixudx](https://github.com/dixudx) in [#285](https://github.com/clusternet/clusternet/pull/285), [#289](https://github.com/clusternet/clusternet/pull/289), [#286](https://github.com/clusternet/clusternet/pull/286), [#295](https://github.com/clusternet/clusternet/pull/295), [#297](https://github.com/clusternet/clusternet/pull/297)). A new CRD `FeedInventory` was introduced as well.

### Bug Fixes
* Fixing crd storage race condition (by [@dixudx](https://github.com/dixudx) in [#260](https://github.com/clusternet/clusternet/pull/260))
* Fix resource updates syncing issue (by [@DanielXLee](https://github.com/DanielXLee) in [#263](https://github.com/clusternet/clusternet/pull/263))
* Do not rollback in-deleting `Description` (by [@dixudx](https://github.com/dixudx) in [#301](https://github.com/clusternet/clusternet/pull/301))
* Fix apiversion assignments with groupversion (by [@dixudx](https://github.com/dixudx) in [#290](https://github.com/clusternet/clusternet/pull/290))

### Misc
* Optimizing `ownerReferences` with `NewControllerRef`. (by [@dixudx](https://github.com/dixudx) in [#294](https://github.com/clusternet/clusternet/pull/294))
