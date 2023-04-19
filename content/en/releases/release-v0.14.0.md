---
title: "v0.14.0 (2023-02-13)"
description: "Clusternet Release v0.14.0"
date: 2023-02-13
draft: false
weight: -15
---

This release improved the stability and introduced metrics for `clusternet-hub`. A critical bug, which led to unexpected
feed deletions when `clusternet-agent` and `clusternet-hub` were running in the same cluster, was fixed as well. A new
option `ReplaceCRDs` was introduced for `HelmChart`, which may help mitigate the annoying CRDs updating issues in the
Helm community.

## Changes Since [v0.13.0](https://github.com/clusternet/clusternet/releases/tag/v0.13.0)

**Full Changelog**: [v0.13.0...v0.14.0](https://github.com/clusternet/clusternet/compare/v0.13.0...v0.14.0)

## What's Changed

### New Features & Enhancements

- add subGroup unit test by [@Sad-polar-bear](https://github.com/Sad-polar-bear)
  in [#546](https://github.com/clusternet/clusternet/pull/546)
- add dependabot by [@yiwei-C](https://github.com/yiwei-C) in [#553](https://github.com/clusternet/clusternet/pull/553)
- Updated metrics for clusternet-hub by [@yiwei-C](https://github.com/yiwei-C)
  in [#566](https://github.com/clusternet/clusternet/pull/566)
- add MAINTAINERS file by [@dixudx](https://github.com/dixudx)
  in [#567](https://github.com/clusternet/clusternet/pull/567)
- add chart option to replace crds before install or upgrade by [@jasine](https://github.com/jasine)
  in [#576](https://github.com/clusternet/clusternet/pull/576)
- bump go version to 1.18 by [@dixudx](https://github.com/dixudx)
  in [#577](https://github.com/clusternet/clusternet/pull/577)
- update clusternet deployment image to v0.14.0 by [@dixudx](https://github.com/dixudx)
  in [#583](https://github.com/clusternet/clusternet/pull/583)

### Bug Fixes

- fix con not get the correct status of the old subscription object by [@zhenkuang](https://github.com/zhenkuang)
  in [#550](https://github.com/clusternet/clusternet/pull/550)
- fix incorrect comments by [@dixudx](https://github.com/dixudx)
  in [#552](https://github.com/clusternet/clusternet/pull/552)
- fix merging TargetClusters by [@yinsenyan](https://github.com/yinsenyan)
  in [#560](https://github.com/clusternet/clusternet/pull/560)
- no need enqueue when FeedInventory feature disable by [@silenceper](https://github.com/silenceper)
  in [#570](https://github.com/clusternet/clusternet/pull/570)
- when request is not set, it needs to be filled by limits by [@silenceper](https://github.com/silenceper)
  in [#573](https://github.com/clusternet/clusternet/pull/573)
- fix unexpected manifest deletion when delete ns in parent-child cluster by [@lmxia](https://github.com/lmxia)
  in [#574](https://github.com/clusternet/clusternet/pull/574)

### Workflow

- Bump goreleaser/goreleaser-action from 2 to 3 by [@dependabot](https://github.com/dependabot)
  in [#557](https://github.com/clusternet/clusternet/pull/557)
- Bump actions/cache from 2.1.5 to 3.0.11 by [@dependabot](https://github.com/dependabot)
  in [#554](https://github.com/clusternet/clusternet/pull/554)
- Bump actions/setup-go from 2 to 3 by [@dependabot](https://github.com/dependabot)
  in [#555](https://github.com/clusternet/clusternet/pull/555)
- Bump actions/checkout from 2 to 3 by [@dependabot](https://github.com/dependabot)
  in [#556](https://github.com/clusternet/clusternet/pull/556)
- Bump peter-evans/repository-dispatch from 1.1.3 to 2.1.1 by [@dependabot](https://github.com/dependabot)
  in [#558](https://github.com/clusternet/clusternet/pull/558)
- Bump goreleaser/goreleaser-action from 3 to 4 by [@dependabot](https://github.com/dependabot)
  in [#561](https://github.com/clusternet/clusternet/pull/561)
- Bump actions/cache from 3.0.11 to 3.2.1 by [@dependabot](https://github.com/dependabot)
  in [#562](https://github.com/clusternet/clusternet/pull/562)
- Bump actions/cache from 3.2.1 to 3.2.2 by [@dependabot](https://github.com/dependabot)
  in [#565](https://github.com/clusternet/clusternet/pull/565)
- Bump github.com/containerd/containerd from 1.6.6 to 1.6.12 by [@dependabot](https://github.com/dependabot)
  in [#568](https://github.com/clusternet/clusternet/pull/568)
- Bump actions/cache from 3.2.2 to 3.2.3 by [@dependabot](https://github.com/dependabot)
  in [#575](https://github.com/clusternet/clusternet/pull/575)
- Bump actions/cache from 3.2.3 to 3.2.4 by [@dependabot](https://github.com/dependabot)
  in [#578](https://github.com/clusternet/clusternet/pull/578)
- Bump github.com/emicklei/go-restful from 2.9.5+incompatible to 2.16.0+incompatible
  by [@dependabot](https://github.com/dependabot) in [#580](https://github.com/clusternet/clusternet/pull/580)
- Bump actions/cache from 3.2.4 to 3.2.5 by [@dependabot](https://github.com/dependabot)
  in [#582](https://github.com/clusternet/clusternet/pull/582)

## New Contributors

- [@zhenkuang](https://github.com/zhenkuang) made their first contribution
  in [#550](https://github.com/clusternet/clusternet/pull/550)
- [@dependabot](https://github.com/dependabot) made their first contribution
  in [#557](https://github.com/clusternet/clusternet/pull/557)

Thanks to all contributors!
