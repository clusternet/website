---
title: "Workloads FailOver"
description: "Migrate workloads from not-ready clusters to healthy spare clusters"
date: 2023-11-08
draft: false
weight: 4
---

The `FailOver` feature gate is a new addition to our scheduler system
since v0.16.0, designed to enhance the resilience and reliability of
workloads running across multiple clusters. Once enabled, this feature
gate allows for automatic migration of workloads from unhealthy clusters
to healthy spare clusters.

The need for this feature arises from the inherent unpredictability of
distributed systems. Clusters can become unhealthy due to a variety of
reasons such as hardware failures, network issues, or software bugs. In
such scenarios, it is crucial to ensure that the workloads are not
affected and continue to run seamlessly. The `FailOver` feature gate
addresses this need by providing an automated failover mechanism.

## Use Scenarios

The `FailOver` feature gate is particularly useful in the following
scenarios:

- High Availability Applications: For applications where high
  availability is a critical requirement, the FailOver feature gate
  ensures that the application continues to run even if the underlying
  cluster becomes unhealthy.

- Disaster Recovery: In the event of a disaster that renders a cluster
  unusable, the FailOver feature gate can automatically migrate the
  workloads to a healthy spare cluster, minimizing downtime.

- Maintenance and Upgrades: During planned maintenance or upgrades,
  workloads can be automatically moved to spare clusters, allowing for
  seamless operations without any service disruption.

## Identifying Unhealthy Clusters

An essential part of the `FailOver` feature gate's functionality is the
ability to accurately identify when a cluster becomes unhealthy. This is
crucial for the feature to work effectively, as it triggers the
automatic migration of workloads to a healthy spare cluster.

A cluster is identified as unhealthy if it stops reporting its heartbeat
more than three times its heartbeat frequency (setting by
`--cluster-status-update-frequency` in `clusternet-agent`). The
heartbeat is a periodic signal sent by `clusternet-agent` to indicate
that the child cluster is functioning correctly. If this heartbeat is
not received for a duration that is more than three times the frequency
of the heartbeat, the cluster is considered unhealthy by the lifecycle
controller in `clusternet-controller-manager`. This cluster will be
tainted with `clusters.clusternet.io/unschedulable:NoSchedule`.

## How to Enable Feature Gate `FailOver`

Currently, the `FailOver` feature gate is still in alpha stage. To use
this failover feature, you have to manually set the `FailOver` feature
gate to `true` for `clusternet-scheduler`, such as below:

```bash
--feature-gates=...,FailOver=true
```

## Conclusion

The `FailOver` feature gate is a powerful tool that enhances the
resilience of your workloads. By automatically migrating workloads from
unhealthy clusters to healthy spare clusters, it ensures high
availability and seamless operations. However, it is important to manage
and monitor your spare clusters to ensure they have enough resources to
handle the additional workloads in case of a failover.
