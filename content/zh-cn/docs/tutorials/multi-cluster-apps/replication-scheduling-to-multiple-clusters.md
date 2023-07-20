---
title: "通过复制调度将应用部署到多个集群"
date: 2022-07-04
draft: false
weight: 1
description: "将应用调度到多个集群"
---
本教程将向您介绍如何使用**复制调度(replication scheduling)**(默认的调度策略)将应用程序部署到多个集群。复制调度意味着每个匹配的集群将运行一个复制且完整的应用实例。例如，如果您希望将一个包含5个副本的`Deployment`部署到2个集群，那么每个集群将分别运行一个包含5个副本的`Deployment`。

## 定义你的应用

首先，我们先看下引用示例应用的定义，在 `Subscription` "app-demo" 下面定义了要分发的目标子集群以及要部署的资源。

```yaml
# examples/replication-scheduling/subscription.yaml
apiVersion: apps.clusternet.io/v1alpha1
kind: Subscription
metadata:
  name: app-demo
  namespace: default
spec:
  subscribers: # 定义要分发到的集群
    - clusterAffinity:
        matchLabels:
          clusters.clusternet.io/cluster-id: dc91021d-2361-4f6d-a404-7c33b9e01118 # 请将此 CLUSTER-ID 更新为你的!!!
  feeds: # 定义要部署的所有资源
    - apiVersion: apps.clusternet.io/v1alpha1
      kind: HelmChart
      name: mysql
      namespace: default
    - apiVersion: v1
      kind: Namespace
      name: foo
    - apiVersion: v1
      kind: Service
      name: my-nginx-svc
      namespace: foo
    - apiVersion: apps/v1
      kind: Deployment
      name: my-nginx
      namespace: foo
```

在应用`Subscription`前，请先修改clusterID。
[examples/replication-scheduling/subscription.yaml](https://github.com/clusternet/clusternet/blob/main/examples/replication-scheduling/subscription.yaml)

{{% alert title="提示" color="primary" %}}
如果要从私有 helm 仓库安装 helm chart，请参考[这个例子](https://github.com/clusternet/clusternet/blob/main/deploy/templates/helm-chart-private-repo.yaml)设置有效的 `chartPullSecret`。
{{% /alert %}}

Clusternet 也支持在 Helm Chart 中使用[OCI标准的镜像仓库仓库](https://helm.sh/docs/topics/registries/)，
请参考[这个 OCI 类型的 Helm Chart 示例](https://github.com/clusternet/clusternet/blob/main/examples/oci/oci-chart-mysql.yaml)。

如果你想设置一些覆盖值（overrides），请参考[在 Clusternet 中如何设置 Overrides](setting-overrides.md)。
在应用这些`Localization`之前，请修改[examples/replication-scheduling/localization.yaml](https://github.com/clusternet/clusternet/blob/main/examples/replication-scheduling/localization.yaml)
使用您的`ManagedCluster`命名空间，例如`clusternet-5l82l`。

## 应用你的应用程序

安装 kubectl 插件 [kubectl-clusternet](/zh-cn/docs/kubectl-clusternet/) 后，您可以运行下面的命令将此应用程序分发到子集群。

```bash
$ kubectl clusternet apply -f examples/replication-scheduling/
helmchart.apps.clusternet.io/mysql created
namespace/foo created
deployment.apps/my-nginx created
service/my-nginx-svc created
subscription.apps.clusternet.io/app-demo created
$ # or
$ # kubectl-clusternet apply -f examples/replication-scheduling/
```

你可以查看各个子集群中[汇聚的资源状态](/zh-cn/docs/tutorials/multi-cluster-apps/aggregated-status/)。

## 检查 Subscription 状态

接下来就可以查看刚刚创建的资源了，

```bash
$ # list Subscription
$ kubectl clusternet get subs -A
NAMESPACE   NAME       AGE
default     app-demo   6m4s
$ kubectl clusternet get chart
NAME             CHART   VERSION   REPO                                 STATUS   AGE
mysql            mysql   8.6.2     https://charts.bitnami.com/bitnami   Found    71s
$ kubectl clusternet get ns
NAME   CREATED AT
foo    2021-08-07T08:50:55Z
$ kubectl clusternet get svc -n foo
NAME           CREATED AT
my-nginx-svc   2021-08-07T08:50:57Z
$ kubectl clusternet get deploy -n foo
NAME       CREATED AT
my-nginx   2021-08-07T08:50:56Z
```

`Clusternet` 将帮助部署和协调应用程序到多个集群。 您可以通过以下命令方式检查状态。

```bash
$ kubectl clusternet get mcls -A
NAMESPACE          NAME                       CLUSTER ID                             SYNC MODE   KUBERNETES   READYZ   AGE
clusternet-5l82l   clusternet-cluster-hx455   dc91021d-2361-4f6d-a404-7c33b9e01118   Dual        v1.21.0      true     5d22h
$ # list Descriptions
$ kubectl clusternet get desc -A
NAMESPACE          NAME               DEPLOYER   STATUS    AGE
clusternet-5l82l   app-demo-generic   Generic    Success   2m55s
clusternet-5l82l   app-demo-helm      Helm       Success   2m55s
$ kubectl describe desc -n clusternet-5l82l   app-demo-generic
...
Status:
  Phase:  Success
Events:
  Type    Reason                Age    From            Message
  ----    ------                ----   ----            -------
  Normal  SuccessfullyDeployed  2m55s  clusternet-hub  Description clusternet-5l82l/app-demo-generic is deployed successfully
$ # list Helm Release
$ # hr is an alias for HelmRelease
$ kubectl clusternet get hr -n clusternet-5l82l
NAME                  CHART       VERSION   REPO                                 STATUS     AGE
helm-demo-mysql       mysql       8.6.2     https://charts.bitnami.com/bitnami   deployed   2m55s
```

您还可以在子集群中使用 Helm 命令行验证安装，

```bash
$ helm ls -n abc
NAME               	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART            	APP VERSION
helm-demo-mysql    	abc      	1       	2021-07-06 14:34:44.188938 +0800 CST	deployed	mysql-8.6.2      	8.0.25
```

> :pushpin: :pushpin: Note:
>
> webhook允许可以在父集群中配置，但请确保 [dry-run](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects) 模式 这些 webhook 支持。 同时，webhook 必须明确指出在使用 `dryRun` 运行时不会产生副作用。 即 [`sideEffects`](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#side-effects) 必须设置为 `None` 或 `NoneOnDryRun`。
>
> 同时，这些 webhook也可以在没有上述限制的情况下为每个子集群配置。
