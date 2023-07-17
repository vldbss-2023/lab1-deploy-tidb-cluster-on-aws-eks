# Lab 1: Deploy TiDB Cluster on AWS EKS

This lab deploys a TiDB cluster on an AWS EKS. The deployment process is automated with Pulumi, which is a popular
infrastructure as code (IaC) framework.

## Introduction

> Why using cloud platform (AWS)?

Cloud computing is the delivery of computing services—including servers, storage, databases, networking, software,
analytics, and intelligence—over the internet ("the cloud") to offer **faster innovation**, **flexible resources**, and
**economies of scale**, as **your business needs change**.

> Why Kubernetes (EKS)?

Kubernetes offers automating deployment, scaling, and management of containerized applications.
Adopting Kubernetes ultimately **accelerates business** and **saves costs** under relatively high application workload.

Amazon EKS is a managed Kubernetes service that makes it easy for you to run Kubernetes on AWS.

> Why Operator?

Operators are software extensions to Kubernetes that use custom resources to manage applications and their components.

At first, there is Kubernetes, which is capable of scaling and being usable in extremely diverse contexts and applications.
To **do more complex things**, capability of Kubernetes must be extended and more sophisticated automations must be created,
suited to individual applications and their specific domain of action.
This is where the Operators come in.

> Why TiDB?

TiDB is an open-source distributed SQL database that supports HTAP workloads. It provides users with a one-stop database
solution, and helps improve scalability, availability and reliability for users' data storage systems.

> Why TiDB on EKS?

When deploying TiDB clusters on AWS EKS, users can gain all features provided by TiDB, while leverage the benefits of
operating TiDB clusters on managed Kubernetes services.

> Why IaC (Pulumi)

Infrastructure as code (IaC) means using code to define and manage modern cloud infrastructure. IaC has many benefits,
such as:

- Version control
- Testing
- Use of IDEs
- DevOps

## Learning Objectives

- Understand basic usage of Kubernetes
- Understand basic usage of AWS Kubernetes service (EKS)
- Understand the fundamentals of operator pattern
- Learn to deploy TiDB clusters on Kubernetes with TiDB Operator
- Understand basic usage of TiDB cluster
- Automate deployment process with Pulumi IaC framework

## Pre-Requisites

- An AWS account
- VPN for connecting to AWS API and GitHub
- Linux or MacOS or WSL2 environments

## Syllabus

- Step 0: Install Dependencies [`0-install-dependencies`](./0-install-dependencies/README.md)

1. (25 points) Create an EKS cluster [`1-create-an-eks-cluster`](./1-create-an-eks-cluster/README.md)
2. (25 points) Deploy TiDB with TiDB
   Operator [`2-deploy-tidb-with-tidb-operator`](./2-deploy-tidb-with-tidb-operator/README.md)
3. (25 points) Explore TiDB basic usage [`3-explore-tidb-basic-usage`](./3-explore-tidb-basic-usage/README.md)
4. (25 points) Scale up TiDB cluster with TiDB
   Operator [`4-scale-up-tidb-cluster-with-tidb-operator`](./4-scale-up-tidb-cluster-with-tidb-operator/README.md)
5. (20 bonus points) Bonus: Config the TiDB slow-log threshold and update the cluster with Pulumi code [[bonus]config-slow-log-threshold](./[bonus]config-slow-log-threshold/README.md)
6. Cleanup: Destroy the EKS cluster [`finished-destroy-the-eks-cluster-via-pulumi`](./1-create-an-eks-cluster/README.md#do-not-execute-this-step-until-lab-1-finished-destroy-the-eks-cluster-via-pulumi)

---

## AWS billing price

This lab will incur charges under the aws account, described in detail at:

- New EKS cluster control plane, **_1_** cluster x **_0.10_** USD per hour
- Two EKS worker EC2 `t2.medium` instances, **_2_** instances * **_0.0464_** USD per hour
- 4 EBS of size 1 GiB, with negligible cost

Total **_0.1928_** USD per hour.
