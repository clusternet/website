---
title: "v0.7.0 (2021-12-23)"
description: "Clusternet Release v0.7.0"
date: 2021-12-23
draft: false
weight: -7
---

The 7th release of Clusternet ! 🦌🦌🦌🎅🎄🎄🎄

Merry Christmas!

This version mainly focuses on supporting scheduler framework, fully supporting `k3s` and improving the stability of deploying applications to child clusters.

## Changes Since [v0.6.0](https://github.com/clusternet/clusternet/releases/tag/v0.6.0)
**Full Changelog**: https://github.com/clusternet/clusternet/compare/v0.6.0...v0.7.0

## What's Changed

### New Features & Enhancements

* Adding Clusternet roadmap (#191)
* Supporting using helm charts in private repository (#193)
* Adding a new component `clusternet-scheduler`, which is base on scheduler framework (#204, #217, #221)
* Taints and tolerations based scheduling are supported as well (#203, #210)
* Supporting running `clusternet-hub` on k3s (#209)
* Configurable clusternet built namespaces, such as `clusternet-system`, `clusternet-reserved` (#205, #211, #216, #219)
* Rolling back resource changes in child clusters (#194)
* `kubectl-clusternet` plugin `v0.5.0` introduced new flags `--cluster-id` and `--child-kubeconfig`. This made it easier to visit child clusters through parent cluster using CLI, instead of constructing a complicated and dedicated kubeconfig (#214)

### Bug Fixes

* Mitigating `Manifest` name with hyphens (#83)
* Fixing cluster label parsing during registration (#197)
* Reconciling `Description` when `HelmChart` got changed (#202)
* Only register resources with the highest priority (#213)

### Security Enhancements
* Fixing dependency vulnerability `github.com/opencontainers/image-spec` (GHSA-77vh-xpmg-72qh) and `github.com/containerd/containerd` (GHSA-5j5w-g665-5m35) (#188)
* Upgrading dependency `github.com/opencontainers/runc` to `v1.0.3` to mitigate vulnerability CVE-2021-43784 (Overflow in netlink bytemsg length field allows attacker to override netlink-based container configuration) (#198)

### Deprecated APIs
* Removing deprecated field `ManagedCluster.Status.ParentAPIServerURL` (#165)

## New Contributors
* @lmxia made their first contribution in #194
* @Garrybest made their first contribution in #203, #210
