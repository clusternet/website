---
title: "命令行工具"
date: 2022-01-17
description: "A 'kubectl' plugin for interacting with Clusternet"
draft: false
weight: 6
---

The plugin source code can be found [here](https://github.com/clusternet/kubectl-clusternet.git).

## Installation

### Install With Krew

`kubectl-clusternet` can be installed using [Krew](https://github.com/kubernetes-sigs/krew),
please [install Krew with this guide](https://krew.sigs.k8s.io/docs/user-guide/setup/install/) first.

Then you can install `Clusternet` kubectl plugin with,

```bash
kubectl krew update
kubectl krew install clusternet
# check plugin version
kubectl clusternet version
```

or update existing `Clusternet` plugin to latest,

```bash
kubectl krew update
kubectl krew upgrade clusternet
# check plugin version
kubectl clusternet version
```

### Download Binary

Alternatively, `kubectl-clusternet` can be directly downloaded
from [released packages](https://github.com/clusternet/kubectl-clusternet/releases).

Download a tar file matching your OS/Arch, and extract `kubectl-clusternet` binary from it.

Then copy `./kubectl-clusternet` to a directory in your executable `$PATH`.

### Build on Your Own

Clone this repo and run `make bin`

```bash
git clone https://github.com/clusternet/kubectl-clusternet
make bin
```

Then copy `./dist/kubectl-clusternet` to a directory in your executable `$PATH`.

## How it works

```bash
$ kubectl clusternet -h
Usage:
  clusternet [flags]
  clusternet [command]

Available Commands:
  annotate      Update the annotations on a resource
  api-resources Print the supported API resources on the server
  apply         Apply a configuration to a resource by filename or stdin
  create        Create a resource from a file or from stdin.
  delete        Delete resources by filenames, stdin, resources and names, or by resources and label selector
  edit          Edit a resource on the server
  exec          Execute a command in a container
  get           Display one or many resources
  help          Help about any command
  label         Update the labels on a resource
  logs          Print the logs for a container in a pod
  scale         Set a new size for a Deployment, ReplicaSet or Replication Controller
  version       Print the plugin version information
```
