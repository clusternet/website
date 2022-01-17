---
title: "clusternet-hub"
date: 2022-01-17
description: clusternet Hub
draft: true
weight: 1
---

# Clusternet Hub

## TL;DR

```console
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-hub -n clusternet-system --create-namespace clusternet/clusternet-hub
kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_bootstrap_token.yaml
```

## Introduction

`clusternet-hub` is responsible for

- approving cluster registration requests and creating dedicated resources, such as namespaces, serviceaccounts and RBAC
  rules, for each child cluster;
- serving as an **aggregated apiserver (AA)**, which is used to serve as a websocket server that maintain multiple
  active websocket connections from child clusters;
- providing Kubernstes-styled API to redirect/proxy/upgrade requests to each child cluster;
- coordinating and deploying applications to multiple clusters from a single set of APIs;

> :pushpin: :pushpin: Note:
>
> Since `clusternet-hub` is running as an AA, please make sure that parent apiserver could visit the
> `clusternet-hub` service.

## Prerequisites

- Kubernetes 1.18+
- Helm 3.1.0

## Installing the Chart

> Note:
> The images are synced to [dockerhub](https://hub.docker.com/u/clusternet) as well,
> you could set `image.registry` to empty or `docker.io` if needed.

To install the chart with the release name `clusternet-hub`:

```console
helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-hub -n clusternet-system --create-namespace clusternet/clusternet-hub
kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_bootstrap_token.yaml
```

These commands deploy `clusternet-hub` on the Kubernetes cluster in the default configuration.
The [Parameters](/docs/components/clusternet-hub/#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list -A`

## Uninstalling the Chart

To uninstall/delete the `clusternet-hub` deployment:

```console
helm delete clusternet-hub -n clusternet-system
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

| Name                        | Description                                                                               | Value                                                                                                   |
| --------------------------- | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `replicaCount`              | Specify number of clusternet-hub replicas                                                 | `1`                                                                                                     |
| `serviceAccount.name`       | The name of the ServiceAccount to create                                                  | `"clusternet-hub"`                                                                                      |
| `securePort`                | Port where clusternet-hub will be running                                                 | `443`                                                                                                   |
| `image.registry`            | clusternet-hub image registry                                                             | `ghcr.io`                                                                                               |
| `image.repository`          | clusternet-hub image repository                                                           | `clusternet/clusternet-hub`                                                                             |
| `image.tag`                 | clusternet-hub image tag (immutable tags are recommended)                                 | `v0.7.0`                                                                                                |
| `image.pullPolicy`          | clusternet-hub image pull policy                                                          | `IfNotPresent`                                                                                          |
| `image.pullSecrets`         | Specify docker-registry secret names as an array                                          | `[]`                                                                                                    |
| `reservedNamespace`         | Reserved namespace used for creating Manifest by clusternet-hub                           | `clusternet-reserved`                                                                                   |
| `anonymousAuthSupported`    | Whether the anonymous access is allowed by the 'core' kubernetes server                   | `true`                                                                                                  |
| `extraArgs`                 | Additional command line arguments to pass to clusternet-hub                               | `{"v":4,"feature-gates":"SocketConnection=true,Deployer=true,ShadowAPI=true,FeedInUseProtection=true"}` |
| `resources.limits`          | The resources limits for the container                                                    | `{}`                                                                                                    |
| `resources.requests`        | The requested resources for the container                                                 | `{}`                                                                                                    |
| `nodeSelector`              | Node labels for pod assignment                                                            | `{}`                                                                                                    |
| `priorityClassName`         | Set Priority Class Name to allow priority control over other pods                         | `""`                                                                                                    |
| `tolerations`               | Tolerations for pod assignment                                                            | `[]`                                                                                                    |
| `podAffinityPreset`         | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`                                                                                                    |
| `podAntiAffinityPreset`     | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`                                                                                                  |
| `nodeAffinityPreset.type`   | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`                                                                                                    |
| `nodeAffinityPreset.key`    | Node label key to match. Ignored if `affinity` is set.                                    | `""`                                                                                                    |
| `nodeAffinityPreset.values` | Node label values to match. Ignored if `affinity` is set.                                 | `[]`                                                                                                    |
| `affinity`                  | Affinity for pod assignment                                                               | `{}`                                                                                                    |
