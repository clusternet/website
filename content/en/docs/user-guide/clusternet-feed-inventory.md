---
title: "Scheduling Requirement Insights"
description: "Obtain the scheduling requirements with FeedInventory"
date: 2023-05-31
draft: false
weight: 3
collapsible: false
---

In Clusternet, we use a CRD called `Subscription` to represent an
application, where multiple resources (aka `Feed` in Clusternet) are
declared, such as well-known Kubernetes native objects `Deployment`,
`StatefulSet`, Helm Charts, CRDs, etc. You can follow
[tutorials on deploying applications to multiple clusters with various scheduling strategies](/docs/tutorials/multi-cluster-apps/)
to learn more.

When scheduling these applications to child clusters with
`SchedulingStrategy` set to `DynamicDividing`, we need to precisely know
the scheduling requirements (such as replicas, node selectors,
tolerations, affinity rules, resource requirements, etc.) of each
`Feed`.

For some well-known Kubernetes native workload objects like
`Deployment`, `ReplicaSet`, and `StatefulSet`, we can easily obtain the
exact scheduling requirements from their standard APIs, such as
`.spec.replicas`, `.spec.nodeSelector`, etc. But what for CRDs? We've no
idea where we can get those values even if we can retrieve the schemas.

Clusternet adopts a consistent and extensible way to better handle the
scheduling requirements for both Kubernetes native objects and
user-defined CRDs.

## FeedInventory Mechanism

`FeedInventory` was firstly introduced in v0.9.0. It is used to track
and record the scheduling requirements (such as replicas, node
selectors, tolerations, affinity rules, resource requirements, etc.) for
each feed in the `Subscription` object with the same namespace and name.
This `FeedInventory` object is only applicable when `SchedulingStrategy`
is set to `DynamicDividing`. For other scheduling strategies,
`FeedInventory` makes no sense.

`FeedInventory` controllers follow the well-known Kubernetes operator
patterns. It is not designed as a webhook, which may bring in extra
overhead such as performance, webhook configurations, security issues,
developing difficulties, etc.

Below is the struct of `FeedInventory` object.

```go
// FeedInventory defines a group of feeds which correspond to a subscription.
type FeedInventory struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec FeedInventorySpec `json:"spec"`
}

// FeedInventorySpec defines the desired state of FeedInventory
type FeedInventorySpec struct {
	Feeds []FeedOrder `json:"feeds"`
}

// FeedOrder defines the scheduling requirements of a Feed.
type FeedOrder struct {
	Feed `json:",inline"`

	// DesiredReplicas specifies the number of desired replica. This is a pointer to distinguish between explicit
	// zero and not specified.
	//
	// +optional
	DesiredReplicas *int32 `json:"desiredReplicas,omitempty"`

	// ReplicaRequirements describes the scheduling requirements for a new replica.
	//
	// +optional
	ReplicaRequirements ReplicaRequirements `json:"replicaRequirements,omitempty"`

	// ReplicaJsonPath specifies the JSONPath for replica settings,
	// such as `/spec/replicas` for Deployment/StatefulSet/ReplicaSet.
	// Should not be empty when DesiredReplicas is non-nil.
	//
	// +optional
	ReplicaJsonPath string `json:"replicaJsonPath,omitempty"`
}

// ReplicaRequirements describes the scheduling requirements for a new replica.
type ReplicaRequirements struct {
	// NodeSelector specifies hard node constraints that must be met for a new replica to fit on a node.
	// Selector which must match a node's labels for a new replica to be scheduled on that node.
	// +optional
	// +mapType=atomic
	NodeSelector map[string]string `json:"nodeSelector,omitempty"`

	// Tolerations specifies the tolerations of a new replica.
	// +optional
	Tolerations []corev1.Toleration `json:"tolerations,omitempty"`

	// Affinity specifies the scheduling constraints of a new replica.
	// +optional
	Affinity *corev1.Affinity `json:"affinity,omitempty"`

	// Resources describes the compute resource requirements.
	// +optional
	Resources corev1.ResourceRequirements `json:"resources,omitempty"`
}
```

For every `Subscription` object whose `SchedulingStrategy` is set to
`DynamicDividing`, there will be a controller to help analysis its feeds
and record the scheduling requirements to the `FeedInventory` object
with the same name in the same namespace.

{{% alert title="Note" color="primary" %}}  
The `FeedInventory` controller could be either built-in or external.  
{{% /alert %}}

By default, Clusternet has been equipped with a built-in `FeedInventory`
controller to deal with Kubernetes native workload objects `Deployment`,
`ReplicaSet`, and `StatefulSet`. This built-in `FeedInventory`
controller is enabled by setting feature gate `FeedInventory` to `true`
when starting `clusternet-controller-manager`.

Also, an external `FeedInventory` controller can be used to interpret
custom resources or override the built-in handlers for Kubernetes native
workload objects. When using external `FeedInventory` controllers,
feature gate `FeedInventory` should be set to `false` on
`clusternet-controller-manager` side.

## Implement an external `FeedInventory` controller

The Clusternet team has shipped a
[sample external `FeedInventory` controller](https://github.com/clusternet/sample-controllers/tree/main/cmd/external-feedinventory),
which can be used to add your own business logic to interpret custom
resources. It is implemented in Go language.

In the `FeedInventory` controller, we may register and plumb multiple
handlers. For each handler, we only need to implement below interfaces.

```go
// PluginFactory is an interface that must be implemented for each plugin.
type PluginFactory interface {
	// Parser parses the raw data to get the replicas, resource requirements, replica jsonpath, etc.
	Parser(rawData []byte) (*int32, appsapi.ReplicaRequirements, string, error)
	// Name returns name of the plugin. It is used in logs, etc.
	Name() string
	// Kind returns the resource kind.
	Kind() string
}
```
