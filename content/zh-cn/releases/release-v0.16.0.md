---
title: "v0.16.0 (2023-06-21)"
description: "Clusternet Release v0.16.0"
date: 2023-06-21
draft: false
weight: -19
---

This release introduces multiple scheduling features, such as feature
gate `FailOver` will migrate workloads from not-ready clusters to
healthy spare clusters, feature gate `FeasibleClustersToleration` could
tolerate failures on feasible clusters for dynamic scheduling with
predictors.

In this release, we also improve the performance and efficiency to
deploy applications to child clusters.

## Changes Since [v0.15.0](https://github.com/clusternet/clusternet/releases/tag/v0.15.0)

**Full Changelog**:
[v0.15.0...v0.16.0](https://github.com/clusternet/clusternet/compare/v0.15.0...v0.16.0)

## What's Changed

### New Features & Enhancements

- install controller-manager for local running by
  [@dixudx](https://github.com/dixudx) in
  [#658](https://github.com/clusternet/clusternet/pull/658)
- always show predictorDirectAccess in status by
  [@autumn0207](https://github.com/autumn0207) in
  [#660](https://github.com/clusternet/clusternet/pull/660)
- bump k8s dependencies to 1.26 by
  [@dixudx](https://github.com/dixudx) in
  [#659](https://github.com/clusternet/clusternet/pull/659)
- apply resources to child clusters with method PATCH by
  [@abstractmj](https://github.com/abstractmj) in
  [#666](https://github.com/clusternet/clusternet/pull/666)
- tighten rbac rules by
  [@dixudx](https://github.com/dixudx) in
  [#671](https://github.com/clusternet/clusternet/pull/671)
- bump clusternet images to v0.15.2 by
  [@dixudx](https://github.com/dixudx) in
  [#672](https://github.com/clusternet/clusternet/pull/672)
- bump dependency yacht to v0.4.0 by
  [@dixudx](https://github.com/dixudx) in
  [#663](https://github.com/clusternet/clusternet/pull/663)
- taint cluster with not-ready conditions by
  [@dixudx](https://github.com/dixudx) in
  [#673](https://github.com/clusternet/clusternet/pull/673)
- migrate workloads from not-ready clusters to healthy spare clusters by
  [@dixudx](https://github.com/dixudx) in
  [#674](https://github.com/clusternet/clusternet/pull/674)
- user-defined prefixes for label aggregation by
  [@yinsenyan](https://github.com/yinsenyan) in
  [#679](https://github.com/clusternet/clusternet/pull/679)
- Bump github.com/docker/distribution from 2.8.1+incompatible to
  2.8.2+incompatible by
  [@dependabot](https://github.com/dependabot) in
  [#685](https://github.com/clusternet/clusternet/pull/685)
- support different format base name by
  [@yinsenyan](https://github.com/yinsenyan) in
  [#681](https://github.com/clusternet/clusternet/pull/681)
- update github action checkout to v3 by
  [@dixudx](https://github.com/dixudx) in
  [#687](https://github.com/clusternet/clusternet/pull/687)
- configurable percentage of clusters to be scored for scheduling by
  [@yiwei-C](https://github.com/yiwei-C) in
  [#690](https://github.com/clusternet/clusternet/pull/690)
- Optimize yacht controller in mcs controllers by
  [@yiwei-C](https://github.com/yiwei-C) in
  [#691](https://github.com/clusternet/clusternet/pull/691)
- Update README.md by
  [@guoguodan](https://github.com/guoguodan) in
  [#693](https://github.com/clusternet/clusternet/pull/693)
- Update ROADMAP.md by
  [@guoguodan](https://github.com/guoguodan) in
  [#695](https://github.com/clusternet/clusternet/pull/695)
- update api doc of FeedInventory by
  [@dixudx](https://github.com/dixudx) in
  [#700](https://github.com/clusternet/clusternet/pull/700)
- add context to predictor http requests by
  [@dixudx](https://github.com/dixudx) in
  [#701](https://github.com/clusternet/clusternet/pull/701)
- Add license scan report and status by
  [@fossabot](https://github.com/fossabot) in
  [#702](https://github.com/clusternet/clusternet/pull/702)
- add action fossa by
  [@dixudx](https://github.com/dixudx) in
  [#703](https://github.com/clusternet/clusternet/pull/703)
- only run fossa for clusternet org by
  [@dixudx](https://github.com/dixudx) in
  [#704](https://github.com/clusternet/clusternet/pull/704)
- record metrics data for health checks with feature gate ComponentSLIs
  by
  [@dixudx](https://github.com/dixudx) in
  [#610](https://github.com/clusternet/clusternet/pull/610)
- tolerate predicting failures on feasible clusters by
  [@dixudx](https://github.com/dixudx) in
  [#705](https://github.com/clusternet/clusternet/pull/705)
- configurable client qps and burst to access child clusters by
  [@dixudx](https://github.com/dixudx) in
  [#707](https://github.com/clusternet/clusternet/pull/707)
- get dynamic client from cache by
  [@stpolar](https://github.com/stpolar) in
  [#708](https://github.com/clusternet/clusternet/pull/708)
- agent-side generic deployer uses configurable qps and burst by
  [@dixudx](https://github.com/dixudx) in
  [#709](https://github.com/clusternet/clusternet/pull/709)
- bump clusternet container images to v0.16.0 by
  [@dixudx](https://github.com/dixudx) in
  [#706](https://github.com/clusternet/clusternet/pull/706)

### Bug Fixes

- fix feature gate usage of MultiClusterService by
  [@dixudx](https://github.com/dixudx) in
  [#655](https://github.com/clusternet/clusternet/pull/655)
- fix error message in cluster status controller by
  [@dixudx](https://github.com/dixudx) in
  [#657](https://github.com/clusternet/clusternet/pull/657)
- fix wrong status referring in framework by
  [@autumn0207](https://github.com/autumn0207) in
  [#661](https://github.com/clusternet/clusternet/pull/661)
- fix validating serviceAccount token by
  [@xjbdjay](https://github.com/xjbdjay) in
  [#667](https://github.com/clusternet/clusternet/pull/667)
- add missing child cluster token for hub proxy by
  [@xjbdjay](https://github.com/xjbdjay) in
  [#682](https://github.com/clusternet/clusternet/pull/682)
- fix missing clusternet-hub-proxy serviceaccount token by
  [@xjbdjay](https://github.com/xjbdjay) in
  [#683](https://github.com/clusternet/clusternet/pull/683)
- fix controller manager lease name by
  [@zxbyoyoyo](https://github.com/zxbyoyoyo) in
  [#694](https://github.com/clusternet/clusternet/pull/694)
- Clean warning in pkg/agent/options/cluster_reg_options.go by
  [@yeqiugt](https://github.com/yeqiugt) in
  [#697](https://github.com/clusternet/clusternet/pull/697)
- fix nil pointer panic by
  [@willzgli](https://github.com/willzgli) in
  [#696](https://github.com/clusternet/clusternet/pull/696)
- fix pruning obsolete feeds when running in pull mode by
  [@abstractmj](https://github.com/abstractmj) in
  [#711](https://github.com/clusternet/clusternet/pull/711)
- fix the merging algorithm when the previous target cluster is empty by
  [@zhenkuang](https://github.com/zhenkuang) in
  [#713](https://github.com/clusternet/clusternet/pull/713)
- update labels created by clusternet controller manager by
  [@dixudx](https://github.com/dixudx) in
  [#714](https://github.com/clusternet/clusternet/pull/714)
- fix metadata precondition failure by
  [@dixudx](https://github.com/dixudx) in
  [#716](https://github.com/clusternet/clusternet/pull/716)

### Security

- fix
  [CVE-2023-30622](https://github.com/advisories/GHSA-833c-xh79-p429
  "CVE-2023-30622") to mitigate a potential risk which can be leveraged
  to make a cluster-level privilege escalation

## New Contributors

- [@xjbdjay](https://github.com/xjbdjay) made their first contribution
  in
  [#667](https://github.com/clusternet/clusternet/pull/667)
- [@guoguodan](https://github.com/guoguodan) made their first
  contribution in
  [#693](https://github.com/clusternet/clusternet/pull/693)
- [@fossabot](https://github.com/fossabot) made their first contribution
  in
  [#702](https://github.com/clusternet/clusternet/pull/702)
- [@stpolar](https://github.com/stpolar) made their first contribution
  in
  [#708](https://github.com/clusternet/clusternet/pull/708)

Thanks to all contributors!
