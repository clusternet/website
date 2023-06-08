---
title: "Feature Gates"
date: 2023-06-09
weight: 4
description: "An overview of the various feature gates an administrator can specify on different Clusternet components."
---

This page contains an overview of the various feature gates an
administrator can specify on different Clusternet components.

See feature stages for an explanation of the stages for a feature.

## Overview

Feature gates are a set of key=value pairs that describe Clusternet
features. You can turn these features on or off using the
`--feature-gates` command line flag on each Clusternet component.

Each Clusternet component lets you enable or disable a set of feature
gates that are relevant to that component. Use `-h` flag to see a full
set of feature gates for all components. To set feature gates for a
component, such as `clusternet-hub`, use the `--feature-gates` flag
assigned to a list of feature pairs:

```bash
--feature-gates=...,ShadowAPI=true
```

Since Clusternet is built on top of some Kubernetes modules, some
feature gates are inherited from them as well. The following tables are
a summary of the feature gates that you can set on different Clusternet
components:

- The "Since" column contains the Clusternet release when a feature is
  introduced or its release stage is changed.
- The "Until" column, if not empty, contains the last Clusternet release
  in which you can still use a feature gate.

| Feature                             | Default | Stage | Since   | Until | Inherited from Kubernetes |
|:------------------------------------|:--------|:------|:--------|:------|:--------------------------|
| APIListChunking                     | true    | BETA  | v0.1.0  |       | true                      |
| APIPriorityAndFairness              | true    | BETA  | v0.1.0  |       | true                      |
| APIResponseCompression              | true    | BETA  | v0.1.0  |       | true                      |
| APIServerIdentity                   | true    | BETA  | v0.1.0  |       | true                      |
| APIServerTracing                    | false   | ALPHA | v0.1.0  |       | true                      |
| AggregatedDiscoveryEndpoint         | false   | ALPHA | v0.1.0  |       | true                      |
| AllAlpha                            | false   | ALPHA | v0.1.0  |       | true                      |
| AllBeta                             | true    | BETA  | v0.1.0  |       | true                      |
| AppPusher                           | false   | ALPHA | v0.2.0  |       | false                     |
| ComponentSLIs                       | false   | ALPHA | v0.16.0 |       | true                      |
| ContextualLogging                   | false   | ALPHA | v0.1.0  |       | true                      |
| CustomResourceValidationExpressions | true    | BETA  | v0.1.0  |       | true                      |
| Deployer                            | false   | ALPHA | v0.2.0  |       | false                     |
| FailOver                            | false   | ALPHA | v0.15.0 |       | false                     |
| FeedInUseProtection                 | false   | ALPHA | v0.4.0  |       | false                     |
| FeedInventory                       | false   | ALPHA | v0.9.0  |       | false                     |
| KMSv2                               | false   | ALPHA | v0.1.0  |       | true                      |
| LoggingAlphaOptions                 | false   | ALPHA | v0.1.0  |       | true                      |
| LoggingBetaOptions                  | true    | BETA  | v0.1.0  |       | true                      |
| MultiClusterService                 | false   | ALPHA | v0.15.0 |       | false                     |
| OpenAPIEnums                        | true    | BETA  | v0.1.0  |       | true                      |
| OpenAPIV3                           | true    | BETA  | v0.1.0  |       | true                      |
| Predictor                           | false   | ALPHA | v0.10.0 |       | false                     |
| Recovery                            | false   | ALPHA | v0.8.0  |       | false                     |
| RemainingItemCount                  | true    | BETA  | v0.1.0  |       | true                      |
| ServerSideFieldValidation           | true    | BETA  | v0.1.0  |       | true                      |
| ShadowAPI                           | false   | ALPHA | v0.3.0  |       | false                     |
| SocketConnection                    | false   | ALPHA | v0.1.0  |       | false                     |
| StorageVersionAPI                   | false   | ALPHA | v0.1.0  |       | true                      |
| StorageVersionHash                  | true    | BETA  | v0.1.0  |       | true                      |
| ValidatingAdmissionPolicy           | false   | ALPHA | v0.1.0  |       | true                      |

## Using a feature

### Feature stages

A feature can be in *Alpha*, *Beta* or *GA* stage. An *Alpha* feature
means:

* Disabled by default.
* Might be buggy. Enabling the feature may expose bugs.
* Support for feature may be dropped at any time without notice.
* The API may change in incompatible ways in a later software release
  without notice.
* Recommended for use only in short-lived testing clusters, due to
  increased risk of bugs and lack of long-term support.

A *Beta* feature means:

* Enabled by default.
* The feature is well tested. Enabling the feature is considered safe.
* Support for the overall feature will not be dropped, though details
  may change.
* The schema and/or semantics of objects may change in incompatible ways
  in a subsequent beta or stable release. When this happens, we will
  provide instructions for migrating to the next version. This may
  require deleting, editing, and re-creating API objects. The editing
  process may require some thought. This may require downtime for
  applications that rely on the feature.
* Recommended for only non-business-critical uses because of potential
  for incompatible changes in subsequent releases. If you have multiple
  clusters that can be upgraded independently, you may be able to relax
  this restriction.

{{% alert title="Note" color="primary" %}}  
Please do try *Beta* features and give feedback on them! After they exit
beta, it may not be practical for us to make more changes.  
{{% /alert %}}

A *General Availability* (GA) feature is also referred to as a *stable*
feature. It means:

* The feature is always enabled; you cannot disable it.
* The corresponding feature gate is no longer needed.
* Stable versions of features will appear in released software for many
  subsequent versions.

## List of feature gates

Each feature gate is designed for enabling/disabling a specific feature:

- `APIListChunking`: Enable the API clients to retrieve (LIST or GET)
  resources from API server in chunks.

- `APIPriorityAndFairness`: Enable managing request concurrency with
  prioritization and fairness at each server. (Renamed from
  RequestManagement)

- `APIResponseCompression`: Compress the API responses for LIST or GET
  requests.

- `APIServerIdentity`: Assign each API server an ID in a cluster, using
  a Lease.

- `APIServerTracing`: Add support for distributed tracing in the API
  server. See Traces for Kubernetes System Components for more details.

- `AggregatedDiscoveryEndpoint`: Enable a single HTTP endpoint
  /discovery/<version> which supports native HTTP caching with ETags
  containing all APIResources known to the API server.

- `AppPusher`: Allows deploying applications directly from parent
  cluster. In case of security concerns for a child cluster, this
  feature gate could be disabled on agent side. When disabled,
  `clusternet-agent` (works in Dual or Pull mode) is responsible to
  deploy resources to current self cluster. Setting on
  `clusternet-agent` side.

- `ComponentSLIs`: Enable the /metrics/slis endpoint on Clusternet
  components like `clusternet-hub`, `clusternet-scheduler`,
  `clusternet-controller-manager` allowing you to scrape health check
  metrics.

- `ContextualLogging`: When you enable this feature gate, Clusternet
  components that support contextual logging add extra detail to log
  output.

- `CustomResourceValidationExpressions`: Enable expression language
  validation in CRD which will validate customer resource based on
  validation rules written in the x-kubernetes-validations extension.

- `Deployer`: Indicates whether `clusternet-controller-manager` works
  for application managements. The scheduling parts are handled by
  `clusternet-scheduler`. Setting on `clusternet-controller-manager`
  side since v0.15.0. (Setting on `clusternet-hub` side prior to
  v0.15.0.)

- `FailOver`: Migrates workloads from not-ready clusters to healthy
  spare clusters. Setting on `clusternet-scheduler` side.

- `FeedInUseProtection`: Postpones deletion of an object that is being
  referred as a feed in Subscriptions. Setting on
  `clusternet-controller-manager` side since v0.15.0. (Setting on
  `clusternet-hub side` prior to v0.15.0.)

- `FeedInventory`: Runs default in-tree registry to parse the schema of
  a resource, such as `Deployment`, `Statefulset`, etc. This feature
  gate should be closed when external `FeedInventory` controller is
  used. Setting on `clusternet-controller-manager` side since v0.15.0.
  (Setting on `clusternet-hub side` prior to v0.15.0.)

- `KMSv2`: Enables KMS v2 API for encryption at rest. See Using a KMS
  Provider for data encryption for more details.

- `LoggingAlphaOptions`: Allow fine-tuing of experimental, alpha-quality
  logging options.

- `LoggingBetaOptions`: Allow fine-tuing of experimental, beta-quality
  logging options.

- `MultiClusterService`: Indicates whether we allow service export and
  service import related controllers to run. In some cases like
  integrating with submariner, this feature should be disabled. Setting
  on `clusternet-controller-manager` and `clusternet-agent` side.

- `OpenAPIEnums`: Enables populating "enum" fields of OpenAPI schemas in
  the spec returned from the API server.

- `OpenAPIV3`: Enables the API server to publish OpenAPI v3.

- `Predictor`: Predicts child cluster resource before scheduling. This
  feature gate needs a running predictor, either build-in or external.
  Setting on `clusternet-agent` side.

- `Recovery`: Ensures the resources deployed by Clusternet exist
  persistently in a child cluster. This helps rollback unexpected
  operations (like deleting, updating) that occurred solely inside a
  child cluster, unless those are made explicitly from parent cluster.
  Setting on `clusternet-agent` side.

- `RemainingItemCount`: Allow the API servers to show a count of
  remaining items in the response to a chunking list request.

- `ServerSideFieldValidation`: Enables server-side field validation.
  This means the validation of resource schema is performed at the API
  server side rather than the client side (for example, the kubectl
  create or kubectl apply command line).

- `ShadowAPI`: Provides an apiserver to shadow all the Kubernetes
  objects, including CRDs. Setting on `clusternet-hub` side.

- `SocketConnection`: Setups and serves a WebSocket connection. Setting
  on `clusternet-hub` and `clusternet-agent` side. Also works on
  `clusternet-controller-manager` side to indicate whether to add rule
  "sockets/proxy" to every dedicated ClusterRole object for child
  clusters. Setting on `clusternet-hub` and `clusternet-agent` side.
  Also works on `clusternet-controller-manager` side to indicate whether
  to add rule "sockets/proxy" to every dedicated ClusterRole object for
  child clusters.

- `StorageVersionAPI`: Enable the storage version API.

- `StorageVersionHash`: Allow API servers to expose the storage version
  hash in the discovery.

- `ValidatingAdmissionPolicy`: Enable `ValidatingAdmissionPolicy`
  support for CEL validations be used in Admission Control.
