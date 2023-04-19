---
title: "v0.13.0 (2022-11-14)"
description: "Clusternet Release v0.13.0"
date: 2022-11-14
draft: false
weight: -14
---

## What's Changed

- ignore rescheduler when no available cluster by [@silenceper](https://github.com/silenceper)
  in [#501](https://github.com/clusternet/clusternet/pull/501)
- update codecov to v3 by [@dixudx](https://github.com/dixudx)
  in [#502](https://github.com/clusternet/clusternet/pull/502)
- add mcs related cluster roles by [@lmxia](https://github.com/lmxia)
  in [#506](https://github.com/clusternet/clusternet/pull/506)
- Fix non-nil pointer error about ClusterRoleBindingList by [@xieyanker](https://github.com/xieyanker)
  in [#507](https://github.com/clusternet/clusternet/pull/507)
- populate legacy secret-based sa token by [@dixudx](https://github.com/dixudx)
  in [#503](https://github.com/clusternet/clusternet/pull/503)
- fix rollback-with-no-crd-error by [@lmxia](https://github.com/lmxia)
  in [#510](https://github.com/clusternet/clusternet/pull/510)
- Add routes from parent cluster to child cluster pod by [@Airren](https://github.com/Airren)
  in [#512](https://github.com/clusternet/clusternet/pull/512)
- fix unmateched serviceimport port name in mcs-api example by [@Airren](https://github.com/Airren)
  in [#513](https://github.com/clusternet/clusternet/pull/513)
- add list verb to clusternet:hub clusterRole by [@metang326](https://github.com/metang326)
  in [#514](https://github.com/clusternet/clusternet/pull/514)
- add scheduler config and support out-of-tree scheduler plugin by [@silenceper](https://github.com/silenceper)
  in [#498](https://github.com/clusternet/clusternet/pull/498)
- use discovery v1beta1 by [@metang326](https://github.com/metang326)
  in [#518](https://github.com/clusternet/clusternet/pull/518)
- aggregate work nodes labels with threshold by [@lmxia](https://github.com/lmxia)
  in [#520](https://github.com/clusternet/clusternet/pull/520)
- fix helm description cannot delete by [@DanielXLee](https://github.com/DanielXLee)
  in [#525](https://github.com/clusternet/clusternet/pull/525)
- bugfix: fix the improper usage of `version` package by [@mars1024](https://github.com/mars1024)
  in [#523](https://github.com/clusternet/clusternet/pull/523)
- only enable service import/export controllers after EndpointSlice v1beta1 promoted
  by [@mars1024](https://github.com/mars1024) in [#529](https://github.com/clusternet/clusternet/pull/529)
- only discovery endpointslice for k8s upper than 1.21.0 by [@yiwei-C](https://github.com/yiwei-C)
  in [#532](https://github.com/clusternet/clusternet/pull/532)
- support scheduling by cluster subgroup by [@Sad-polar-bear](https://github.com/Sad-polar-bear)
  in [#524](https://github.com/clusternet/clusternet/pull/524)
- fix missing status update of description by [@Sad-polar-bear](https://github.com/Sad-polar-bear)
  in [#534](https://github.com/clusternet/clusternet/pull/534)
- update subGroup example fields by [@Sad-polar-bear](https://github.com/Sad-polar-bear)
  in [#535](https://github.com/clusternet/clusternet/pull/535)
- sort the clusters by descending order of decimal part in dynamicDivideReplicas
  by [@Garrybest](https://github.com/Garrybest) in [#533](https://github.com/clusternet/clusternet/pull/533)
- update RBAC rules for clusternet-agent running in capi by [@dixudx](https://github.com/dixudx)
  in [#537](https://github.com/clusternet/clusternet/pull/537)
- fix bindingClusters not update and generic description cannot delete by [@DanielXLee](https://github.com/DanielXLee)
  in [#539](https://github.com/clusternet/clusternet/pull/539)
- non blocking callback handler for feature gate Recovery by [@silenceper](https://github.com/silenceper)
  in [#542](https://github.com/clusternet/clusternet/pull/542)
- bump container images to v0.13.0 by [@dixudx](https://github.com/dixudx)
  in [#540](https://github.com/clusternet/clusternet/pull/540)

## New Contributors

- [@xieyanker](https://github.com/xieyanker) made their first contribution
  in [#507](https://github.com/clusternet/clusternet/pull/507)
- [@Airren](https://github.com/Airren) made their first contribution
  in [#512](https://github.com/clusternet/clusternet/pull/512)
- [@metang326](https://github.com/metang326) made their first contribution
  in [#514](https://github.com/clusternet/clusternet/pull/514)
- [@mars1024](https://github.com/mars1024) made their first contribution
  in [#523](https://github.com/clusternet/clusternet/pull/523)

**Full Changelog**: [v0.12.0...v0.13.0](https://github.com/clusternet/clusternet/compare/v0.12.0...v0.13.0)
