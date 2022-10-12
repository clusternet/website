---
title: "Install Helm Charts from a Private Registry"
date: 2022-10-12
draft: false
weight: 1
collapsible: false
---

This page shows how to deploy a Helm Chart from a private registry to child clusters.
A [Secret](https://kubernetes.io/docs/concepts/configuration/secret/) is used to store the credentials.

## Create a Secret

In most shells, the easiest way to escape the password is to surround it with single quotes (`'`). For example, if your
password is `S!B\*d$zDsb=`, run the following command:

```shell
kubectl create ns my-system
kubectl create secret generic my-helm-repo -n my-system \
  --from-literal=username=devuser \
  --from-literal=password='S!B\*d$zDsb='
```

or we can apply below yaml file with command `kubectl apply`,

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-helm-repo
  namespace: my-system
type: Opaque
stringData:
  password: devuser
  username: S!B\*d$zDsb=
```

## Create a Helm Chart that uses your Secret

Here is a manifest for an example `HelmChart` that needs access to your Helm registry credentials in `my-helm-repo`:

```yaml
apiVersion: apps.clusternet.io/v1alpha1
kind: HelmChart
metadata:
  name: mysql
  namespace: default
spec:
  repo: https://my.private.repo/registry
  chartPullSecret:
    name: my-helm-repo
    namespace: my-system
  chart: mysql
  version: 9.2.0
  targetNamespace: abc
```

Then you can follow [tutorials on multi-cluster applications](../../tutorials/multi-cluster-apps) to deploy
this `HelmChart` to child clusters.
