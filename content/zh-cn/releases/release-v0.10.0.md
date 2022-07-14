---
title: "v0.10.0 (2022-06-01)"
description: "Clusternet Release v0.10.0"
date: 2022-06-01
draft: false
weight: -11
---

This release introduced a new concept `predictor`. It is a on-going feature, which will be fully available in next release (v0.11.0). With `predictor`, we could dynamically schedule replicas to child clusters that have the capacity to hold them. Also in this release, we optimized the scheduler framework, making it more adaptable to multiple cluster scenarios. A new feature on cluster-aware Globalization was introduced as well. Meantime, we improved user experience on trying Clusternet with `kind` and Docker Desktop.

## Changes Since [v0.9.1](https://github.com/clusternet/clusternet/releases/tag/v0.9.1)

**Full Changelog**: https://github.com/clusternet/clusternet/compare/v0.9.1...v0.10.0

## What's Changed

### New Features & Enhancements

* Introduced new concept `predictor`, which can be used to predict containable replicas in each matching child clusters. This is a on-going feature, which will be fully available in next release (v0.11.0). In this release, following tasks were finished,
    * Added replica predictor interface, which can be implemented by external customized predictors. (by [@dixudx](https://github.com/dixudx) in [#274](https://github.com/clusternet/clusternet/pull/274))
    * Added a extensible framework for predictor server, and a built-in predictor. (by [@qianjun1993](https://github.com/qianjun1993) in [#346](https://github.com/clusternet/clusternet/pull/346), [#336](https://github.com/clusternet/clusternet/pull/336))
    * Added a new scheduling plugin `predictor`. (by [@yinsenyan](https://github.com/yinsenyan) in [#354](https://github.com/clusternet/clusternet/pull/354))
    * Bumped default predictor server into `clusternet-agent`. (by [@yinsenyan](https://github.com/yinsenyan) in [#344](https://github.com/clusternet/clusternet/pull/344), by [@qianjun1993](https://github.com/qianjun1993) in [#355](https://github.com/clusternet/clusternet/pull/355))
* Added extra arg `--threadiness` for hub. (by [@DanielXLee](https://github.com/DanielXLee) in [#314](https://github.com/clusternet/clusternet/pull/314))
* Added annotation to support skipping validation. (by [@dixudx](https://github.com/dixudx) in [#317](https://github.com/clusternet/clusternet/pull/317))
* Optimized scheduler framework for multi-cluster. (by [@Garrybest](https://github.com/Garrybest) in [#322](https://github.com/clusternet/clusternet/pull/322))
* Cluster-aware overrides from Globalization can be applied now. (by [@jasine](https://github.com/jasine) in [#334](https://github.com/clusternet/clusternet/pull/334))
* Rescheduled subscriptions when binding clusters got a change on labels. (by [@DanielXLee](https://github.com/DanielXLee) in [#339](https://github.com/clusternet/clusternet/pull/339), [#341](https://github.com/clusternet/clusternet/pull/341))
* Optimized context usage and shared informer factory in clusternet-agent. (by [@dixudx](https://github.com/dixudx) in [#356](https://github.com/clusternet/clusternet/pull/356), [#357](https://github.com/clusternet/clusternet/pull/357))

### Bug Fixes

* Fixed inconsistent helm release name. (by [@jasine](https://github.com/jasine) in [#309](https://github.com/clusternet/clusternet/pull/309))
* Fixed incorrect cluster and service ip range in `ManagedCluster` status. (by [@jasine](https://github.com/jasine) in [#311](https://github.com/clusternet/clusternet/pull/311))
* Removing duplicate module import. (by [@yinsenyan](https://github.com/yinsenyan) in [#313](https://github.com/clusternet/clusternet/pull/313))
* Fixed resource `AlreadyExists` error for shadow apis (by [@dixudx](https://github.com/dixudx) in [#316](https://github.com/clusternet/clusternet/pull/316), [#330](https://github.com/clusternet/clusternet/pull/330))
* Fixed empty overrides deserialization. (by [@dixudx](https://github.com/dixudx) in [#323](https://github.com/clusternet/clusternet/pull/323))
* Fixed issue on deploying helm charts to target namespace. (by [@dixudx](https://github.com/dixudx) in [#326](https://github.com/clusternet/clusternet/pull/326))
* Label `apps.clusternet.io/owned-by-description` was changed to annotation to avoid label length limit. (by [@silenceper](https://github.com/silenceper) in [#327](https://github.com/clusternet/clusternet/pull/327))
* Fixed updating feedInventory with missing resource version. (by [@dixudx](https://github.com/dixudx) in [#332](https://github.com/clusternet/clusternet/pull/332))
* Fixed resource controller running more than one. (by [@lmxia](https://github.com/lmxia) in [#352](https://github.com/clusternet/clusternet/pull/352))
* Converged resync conditions from upper updates and rolling back. (by [@lmxia](https://github.com/lmxia) in [#343](https://github.com/clusternet/clusternet/pull/343))
* Fixed enqueue issue in feedinventory. (by [@Garrybest](https://github.com/Garrybest) in [#340](https://github.com/clusternet/clusternet/pull/340))

### User Experiences

* Images can be built faster and better. (by [@dixudx](https://github.com/dixudx) in [#319](https://github.com/clusternet/clusternet/pull/319))
* Removed default log level (used to be `-v 4`) to avoid log flooded. (by [@dixudx](https://github.com/dixudx) in [#320](https://github.com/clusternet/clusternet/pull/320))
* Added cluster register name for local kind clusters. (by [@Garrybest](https://github.com/Garrybest) in [#321](https://github.com/clusternet/clusternet/pull/321))
* Used port-mapping endpoints for kind clusters on Docker Desktop Mac. (by [@bartdong](https://github.com/bartdong) in [#328](https://github.com/clusternet/clusternet/pull/328))

### Security

* Fixed CVE GHSA-hp87-p4gw-j4gq: An issue in the `Unmarshal` function in Go-Yaml v3 causes the program to crash when attempting to deserialize invalid input. (by [@dixudx](https://github.com/dixudx) in [#348](https://github.com/clusternet/clusternet/pull/348))

## New Contributors

* [@jasine](https://github.com/jasine) made their first contribution in [#309](https://github.com/clusternet/clusternet/pull/309)
* [@yinsenyan](https://github.com/yinsenyan) made their first contribution in [#313](https://github.com/clusternet/clusternet/pull/313)
* [@bartdong](https://github.com/bartdong) made their first contribution in [#328](https://github.com/clusternet/clusternet/pull/328)
* [@qianjun1993](https://github.com/qianjun1993) made their first contribution in [#336](https://github.com/clusternet/clusternet/pull/336)

Thanks to all contributors!
