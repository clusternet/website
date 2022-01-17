---
title: "clusternet-scheduler"
date: 2022-01-17
description: clusternet Scheduler
draft: true
weight: 2
---

# Clusternet Scheduler

## TL;DR

```console
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-scheduler -n clusternet-system --create-namespace \
  clusternet/clusternet-scheduler
```

## Introduction

`clusternet-scheduler` is responsible for

- scheduling resources/feeds to matched child clusters based on `SchedulingStrategy`;

## Prerequisites

- Kubernetes 1.18+
- Helm 3.1.0

## Installing the Chart

> Note:
> The images are synced to [dockerhub](https://hub.docker.com/u/clusternet) as well,
> you could set `image.registry` to empty or `docker.io` if needed.

To install the chart with the release name `clusternet-scheduler` and release namespace `clusternet-system`:

```console
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-scheduler -n clusternet-system --create-namespace \
  clusternet/clusternet-scheduler
```

These commands deploy `clusternet-scheduler` on the Kubernetes cluster in the default configuration.
The [Parameters](/docs/components/clusternet-scheduler/#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list -A`

## Uninstalling the Chart

To uninstall/delete the `clusternet-scheduler` deployment:

```console
helm delete clusternet-scheduler -n clusternet-system
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Common parameters

| Name                | Description                                        | Value |
| ------------------- | -------------------------------------------------- | ----- |
| `kubeVersion`       | Override Kubernetes version                        | `""`  |
| `nameOverride`      | String to partially override common.names.fullname | `""`  |
| `fullnameOverride`  | String to fully override common.names.fullname     | `""`  |
| `commonLabels`      | Labels to add to all deployed objects              | `{}`  |
| `commonAnnotations` | Annotations to add to all deployed objects         | `{}`  |

### Exposure parameters

| Name                        | Description                                                                               | Value                             |
| --------------------------- | ----------------------------------------------------------------------------------------- | --------------------------------- |
| `replicaCount`              | Specify number of clusternet-scheduler replicas                                           | `3`                               |
| `serviceAccount.name`       | The name of the ServiceAccount to create                                                  | `"clusternet-scheduler"`          |
| `image.registry`            | clusternet-scheduler image registry                                                       | `ghcr.io`                         |
| `image.repository`          | clusternet-scheduler image repository                                                     | `clusternet/clusternet-scheduler` |
| `image.tag`                 | clusternet-scheduler image tag (immutable tags are recommended)                           | `v0.7.0`                          |
| `image.pullPolicy`          | clusternet-scheduler image pull policy                                                    | `IfNotPresent`                    |
| `image.pullSecrets`         | Specify docker-registry secret names as an array                                          | `[]`                              |
| `extraArgs`                 | Additional command line arguments to pass to clusternet-scheduler                         | `{"v":4}`                         |
| `resources.limits`          | The resources limits for the container                                                    | `{}`                              |
| `resources.requests`        | The requested resources for the container                                                 | `{}`                              |
| `nodeSelector`              | Node labels for pod assignment                                                            | `{}`                              |
| `priorityClassName`         | Set Priority Class Name to allow priority control over other pods                         | `""`                              |
| `tolerations`               | Tolerations for pod assignment                                                            | `[]`                              |
| `podAffinityPreset`         | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`                              |
| `podAntiAffinityPreset`     | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`                            |
| `nodeAffinityPreset.type`   | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`                              |
| `nodeAffinityPreset.key`    | Node label key to match. Ignored if `affinity` is set.                                    | `""`                              |
| `nodeAffinityPreset.values` | Node label values to match. Ignored if `affinity` is set.                                 | `[]`                              |
| `affinity`                  | Affinity for pod assignment                                                               | `{}`                              |
