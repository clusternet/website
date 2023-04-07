---
title: "Clusternet Upgrade"
description: "Provide an overview of the steps you should follow to upgrade Clusternet"
date: 2023-04-07
draft: false
collapsible: false
---

Mostly you can directly upgrade the container images or binaries of Clusternet. This depends on how you initially
deployed it and on any subsequent changes.

## Upgrading to v0.15.0

In v0.15.0, a new component `clusternet-controller-manager` was introduced. This new component inherited some 
capabilities from `clusternet-hub`. Some flags and feature gates were moving together to
`clusternet-controller-manager` as well. These changes would alter the arguments that passed to `clusternet-hub`.
Please pay attention to below changes.

- Flag `anonymous-auth-supported` was moved to `clusternet-controller-manager`. This flag would not be available for 
  `clusternet-hub` anymore.
- Flag `cluster-api-kubeconfig` was moved to `clusternet-controller-manager`. This flag would not be available for
  `clusternet-hub` anymore.
- Feature gate `Deployer` was moved to `clusternet-controller-manager`. This feature gate would not be available for
  `clusternet-hub` anymore.
- Feature gate `FeedInUseProtection` was moved to `clusternet-controller-manager`. This feature gate would not be
  available for `clusternet-hub` anymore.
- Feature gate `FeedInventory` was moved to `clusternet-controller-manager`. This feature gate would not be
  available for `clusternet-hub` anymore.
