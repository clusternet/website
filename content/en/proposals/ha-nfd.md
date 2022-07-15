# Proposal-NNNN: Hardware Awareness scheduler based on NFD 

## Authors

Le, Huifeng
Xu, Stephen

## Summary

NFD (Node Feature Discovery: https://github.com/kubernetes-sigs/node-feature-discovery) enables node feature discovery for Kubernetes. It detects hardware features available on each node in a Kubernetes cluster, and advertises those features using node labels. The NodeFeatureRule objects provide an easy way to create vendor or application specific labels. This PR targets to enable Hardware Awareness (e.g. cluster features) based application scheduler in clusternet.

## Motivation

Enable Hardware Awareness (e.g. cluster features) based application scheduler allows clusternet administrator to better utilize cluster hardware resource for applications.

### Goals

Calculate cluster features in NFD enabled child clusters
Filter cluster based on cluster feature

### Non-Goals
Install NFD in child cluster

## Proposal

### User Stories (Optional)

#### Story 1: As clusternet administrator, I want to define cluster feature as combination of child cluster node's hardware feature, such as CPU, FPGA etc.

#### Story 2: As clusternet administrator, I want to deploy my application to child clusters with required hardware features

### Notes/Constraints/Caveats (Optional)

### Risks and Mitigations

Add-on scheduling mechanism on existing clusternet scheduler. 

## Design Details

1. API Definition:
N/A

2. Agent
status manager: calculate ClusterFeatures based on node label combination (e.g. "or" for node label with prefix like "clusternet.io/cluster-feature/") and report to hub in ManagerCluster's labels

3. Scheduler:
ClusterFeatureFilter: filter cluster according to subscription’s clusterAffinity and ManagerCluster.labels
Flow update: 
  if subscription includes resource NodeFeatureRule, (1) add NodeFeatureRule CRD resource (2) append prefix such as "clusternet.io/cluster-feature/" in resource's labels

NodeFeatureRule Sample: https://github.com/kubernetes-sigs/node-feature-discovery/blob/master/deployment/base/nfd-crds/cr-sample.yaml
apiVersion: nfd.k8s-sigs.io/v1alpha1
kind: NodeFeatureRule
metadata:
  name: my-sample-rule-object
spec:
  rules:
    - name: "my sample rule"
      labels:
        "my-sample-feature": "true"
      matchFeatures:
        - feature: kernel.loadedmodule
          matchExpressions:
            dummy: {op: Exists}
        - feature: kernel.config
          matchExpressions:
            X86: {op: In, value: ["y"]}

4. Sequence flow:
<img src="./ha-nfd.png" height="400" />

### Test Plan

### Version Skew Strategy

### Feature Enablement and Rollback

### Dependencies

### Scalability

### Drawbacks

### Alternatives