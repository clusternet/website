---
title: "HelmChart"
date: 2023-02-01
weight: 3
description: "HelmChart Configuration"
---

## replaceCRDs

- [There is no support for upgrading or deleting CRDs using Helm](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/#some-caveats-and-explanations), after clusternet created `HelmRelease`，it may install or upgrade failed when `CRD` resources updated in `HelmChart` since `CR` conflict with old `CRD`

- clusternet will replace crds in helm charts and subcharts when `replaceCRDs` in  `HelmChart` spec set `true`（default`false`） 
- when `skipCRDs` set `true`, `replaceCRDs` is ignored.


## other flags
- flags such as `atomic`,`createNamespace`,`disableHooks`, `force`, `replace`, `skipCRDs`, `timeoutSeconds`, `wait`, `waitForJob` same as [helm](https://helm.sh/docs/helm/helm_install/)
