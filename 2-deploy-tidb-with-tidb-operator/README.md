# Step 2: Deploy a TiDB Cluster with TiDB Operator

The following steps guides you through the process of scaling TiKV instance for a TiDB Operator managed cluster. It takes about
10 minutes to complete.

> - Please make sure you have completed [Step 1: Create an EKS cluster](../1-create-an-eks-cluster/README.md) and use *
    *_the same shell session_** before proceeding.
> - If you have closed the shell session, please run `export KUBECONFIG=$PWD/../1-create-an-eks-cluster/kubeconfig.yaml`
    to load the kubeconfig env.

<!-- TOC -->
* [Step 2: Deploy a TiDB Cluster with TiDB Operator](#step-2-deploy-a-tidb-cluster-with-tidb-operator)
  * [Install Helm](#install-helm)
    * [Download](#download)
    * [Init](#init)
  * [Set up Pulumi](#set-up-pulumi)
    * [Install Pulumi](#install-pulumi)
    * [Initialize to Pulumi](#initialize-to-pulumi)
  * [Deploy TiDB Operator and TiDB Cluster via Pulumi](#deploy-tidb-operator-and-tidb-cluster-via-pulumi)
    * [What is CRD?](#what-is-crd)
    * [How TiDB Operator Works?](#how-tidb-operator-works)
    * [Do It](#do-it)
  * [[Scoring Point] Wait for TiDB Cluster Ready](#scoring-point-wait-for-tidb-cluster-ready)
<!-- TOC -->

## Install Helm

Helm is a tool that automates the creation, packaging, configuration, and deployment of Kubernetes applications.

> A.K.A., A lightweight alternative to Pulumi.

### Download

```bash
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

### Init

```bash
$ helm init --client-only
```

## Set up Pulumi

### Install Pulumi

   https://www.pulumi.com/docs/get-started/install/

### Initialize to Pulumi

```bash
$ pulumi login --local
$ export PULUMI_CONFIG_PASSPHRASE="" # Set passphrase env to `""`. This passphrase is required by Pulumi and was created by Lab maintainer.
$ pulumi stack select default -c # Select the `default` stack.
```

## Deploy TiDB Operator and TiDB Cluster via Pulumi

### What is CRD?

![kubernetes_resource_definition](../.imgs/kubernetes_resource_definition.png)

In Kubernetes, a Custom Resource Definition (CRD) is a Kubernetes object that defines the schema for a custom resource. The schema defines the name, type, and properties of the custom resource.
Once a CRD is created, custom resources of that type can be created, updated, and deleted using the Kubernetes API. Custom resources can be used to represent any type of object, such as a database, a service, or a virtual machine.
Custom resources are a powerful way to extend the capabilities of Kubernetes. They can be used to manage any type of object that is not natively supported by Kubernetes.

### How TiDB Operator Works?

![kubernetes_control](../.imgs/kubernetes_control.png)

- User install TiDB Operator and TiDB Cluster CRD to Kubernetes.
- User creates a TiDB Cluster Custom Resource (CR) to Kubernetes.
- The operator watches for changes to the CR.
- If the operator detects that the database is not in the desired state, it will take action to reconcile the state.
- This may involve creating new database pods, updating existing database pods, or deleting database pods.
- The operator continues to monitor the database and take action as needed to ensure that the database is always in the desired state.

### Do It

```bash
$ pulumi up
Updating (default):
     Type                                                                  Name                                      Status
     pulumi:pulumi:Stack                                                   2-deploy-tidb-with-tidb-operator-default
 +-  ├─ kubernetes:helm.sh/v3:Release                                      tidb-operator                             craeted (22s)
     ├─ kubernetes:yaml:ConfigGroup                                        tidb-operator-crds
     │  └─ kubernetes:yaml:ConfigFile                                      crds/tidb-operator-v1.4.4.yaml
 +-  │     ├─ kubernetes:apiextensions.k8s.io/v1:CustomResourceDefinition  tidbinitializers.pingcap.com              craeted (2s)
     ... dozens of resources omitted ...
```

## [Scoring Point] Wait for TiDB Cluster Ready

```bash
$ kubectl get po
NAME                                       READY   STATUS    RESTARTS   AGE
basic-discovery-cff6d579c-npzmv            1/1     Running   0          60m
basic-monitor-0                            4/4     Running   0          60m
basic-pd-0                                 1/1     Running   0          29m
basic-tidb-0                               2/2     Running   0          27m
basic-tidb-dashboard-0                     1/1     Running   0          29m
basic-tikv-0                               1/1     Running   0          28m
tidb-controller-manager-75959db68d-gdbv6   1/1     Running   0          61m
tidb-scheduler-55d58fdd7f-kch9g            2/2     Running   0          61m
```
