---
title: "v0.11.0 (2022-07-14)"
description: "Clusternet Release v0.11.0"
date: 2022-07-14
draft: false
weight: -12
---

This release brings in multiple fantastic features and improves the performance. This is a big update of `Clusternet`.
Running `clusternet-hub` with high availability is possible now. And the performance of `clusternet-scheduler` is
improved as well. Dynamic replica scheduling is fully supported. Applications with multiple replicas can be divided and
scheduled to multiple clusters based on cluster dynamic capacity. Please check
out [this tutorial](https://clusternet.io/docs/tutorials/multi-cluster-apps/dynamic-scheduling-to-multiple-clusters/).
Moreover, the aggregated statuses of all deployed resources can be shown by visiting the status of `Subscription`.

## Changes Since [v0.10.0](https://github.com/clusternet/clusternet/releases/tag/v0.10.0)

**Full Changelog**: [v0.10.0...v0.11.0](https://github.com/clusternet/clusternet/compare/v0.10.0...v0.11.0)

## What's Changed

### New Features & Enhancements

* Made `clusternet-hub` high availability (by @dixudx in [#378](https://github.com/clusternet/clusternet/pull/378)
  , [#405](https://github.com/clusternet/clusternet/pull/405), [#411](https://github.com/clusternet/clusternet/pull/411)
  and by @xrmzju in [#387](https://github.com/clusternet/clusternet/pull/387))
* Aggregated resource/feed statuses from child clusters (@aven-ai
  in [#358](https://github.com/clusternet/clusternet/pull/358)
  , [#359](https://github.com/clusternet/clusternet/pull/359)
  , [#360](https://github.com/clusternet/clusternet/pull/360)). The aggregated status of all deployed resources can be
  shown by visiting the status of `Subscription`. For every feed/resource, you can check the detailed status (
  field `feedStatusDetails`) per cluster and the summarized status (
  field `feedStatusSummary`) of all clusters in `status.aggregatedStatuses`.
* Added new scheduling strategy `Dynamic` for `clusternet-scheduler`. Applications with multiple replicas now can be
  divided and scheduled to multiple clusters based on cluster dynamic capacity. (by @Garrybest
  in [#366](https://github.com/clusternet/clusternet/pull/366)
  , [#395](https://github.com/clusternet/clusternet/pull/395)
  , [#400](https://github.com/clusternet/clusternet/pull/400)
  , [#419](https://github.com/clusternet/clusternet/pull/419)). Default predictors run on every `clusternet-agent`,
  external predictors had been supported as well (by @yinsenyan
  in [#367](https://github.com/clusternet/clusternet/pull/367) and @dixudx
  in [#418](https://github.com/clusternet/clusternet/pull/418))
  . Learn more
  from [this tutorial](https://clusternet.io/docs/tutorials/multi-cluster-apps/dynamic-scheduling-to-multiple-clusters/)
  .
* Improved the performance of `clusternet-scheduler` (by @Garrybest
  in [#383](https://github.com/clusternet/clusternet/pull/383)
  , [#399](https://github.com/clusternet/clusternet/pull/399)
  , [#388](https://github.com/clusternet/clusternet/pull/388))
* Added support to override HelmChart spec (by @DanielXLee in [#385](https://github.com/clusternet/clusternet/pull/385)
  and @dixudx in [#416](https://github.com/clusternet/clusternet/pull/416)
  , [#417](https://github.com/clusternet/clusternet/pull/417))
* Aggregated common labels starting with `node.clusternet.io/` from nodes in child clusters (@lmxia
  in [#396](https://github.com/clusternet/clusternet/pull/396)
  , [#413](https://github.com/clusternet/clusternet/pull/413)). If all nodes of a child cluster have such common labels,
  then these labels will be aggregated and updated to its corresponding `ManagedCluster` object.
* Real-time cpu/mem usage and pod statistics can be collected from metrics server by enabling
  flag `--use-metrics-server=true` on `clusternet-agent` side (by @GeorgeGuo2018
  in [#362](https://github.com/clusternet/clusternet/pull/362)
  , [#365](https://github.com/clusternet/clusternet/pull/365) and @DanielXLee
  in [#421](https://github.com/clusternet/clusternet/pull/421))
* Added intermediate status for the helm chart (by @DanielXLee
  in [#382](https://github.com/clusternet/clusternet/pull/382))
* Used sepearte clientsets for election (by @xrmzju in [#389](https://github.com/clusternet/clusternet/pull/389))
* Added env for cluster-cidr and service-cidr (by @snstaberah
  in [#391](https://github.com/clusternet/clusternet/pull/391)), which would be useful when the kubernetes components
  were not running as static pods.

### Bug Fixes

* Fixed statefulset feedinventory (by @dixudx in [#398](https://github.com/clusternet/clusternet/pull/398))
* Removed go routine for storing parent cluster secret (by @DanielXLee
  in [#381](https://github.com/clusternet/clusternet/pull/381))
* Fixed WATCH events on transforming and encoding (by @dixudx
  in [#407](https://github.com/clusternet/clusternet/pull/407))
* Removed Manifest finalizer in shadow api (by @caryxychen in [#408](https://github.com/clusternet/clusternet/pull/408))
* Fixed localizations when scaling (by @Garrybest in [#406](https://github.com/clusternet/clusternet/pull/406))
* Pruned localizations when scheduling strategy was changed (by @dixudx
  in [#401](https://github.com/clusternet/clusternet/pull/401))
* Fixed clusterIP for non headless services (by @dixudx in [#404](https://github.com/clusternet/clusternet/pull/404))

### User Experiences

* Added human readable printer, which let `kubectl clusternet` plugin having consistent user experience with `kubectl` (
  by @lmxia in [#384](https://github.com/clusternet/clusternet/pull/384))
* Added linter gci (by @dixudx in [#397](https://github.com/clusternet/clusternet/pull/397))
* All the docs were migratee to https://clusternet.io (by @dixudx
  in [#409](https://github.com/clusternet/clusternet/pull/409))

### Security

* Fixed containerd [CVE-2022-31030](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-31030): A bug was found in
  containerd's CRI implementation where programs inside a container can cause the containerd daemon to consume memory
  without bound during invocation of the `ExecSync` API. This can cause containerd to consume all available memory on
  the computer, denying service to other legitimate workloads. Kubernetes and crictl can both be configured to use
  containerd's CRI implementation; `ExecSync` may be used when running probes or when executing processes via an "exec"
  facility. (by @dixudx in [#364](https://github.com/clusternet/clusternet/pull/364))

## New Contributors

* @aven-ai made their first contribution in [#358](https://github.com/clusternet/clusternet/pull/358)
* @GeorgeGuo2018 made their first contribution in [#362](https://github.com/clusternet/clusternet/pull/362)
* @xrmzju made their first contribution in [#387](https://github.com/clusternet/clusternet/pull/387)
* @snstaberah made their first contribution in [#391](https://github.com/clusternet/clusternet/pull/391)
* @caryxychen made their first contribution in [#408](https://github.com/clusternet/clusternet/pull/408)

Thanks to all contributors!
