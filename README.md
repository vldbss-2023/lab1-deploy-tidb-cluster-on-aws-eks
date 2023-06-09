# lab1-deploy-tidb-cluster-on-aws-eks

This lab deploys a TiDB cluster on an AWS EKS. The deployment process is automated with Pulumi, which is a popular infrastructure as code (IaC) framework.

## Introduction

> Why cloud platform?

Cloud computing is the delivery of computing services—including servers, storage, databases, networking, software, analytics, and intelligence—over the internet ("the cloud") to offer faster innovation, flexible resources, and economies of scale, as your business needs change.

> Why Kubernetes (EKS)?

Amazon EKS is a managed Kubernetes service that makes it easy for you to run Kubernetes on AWS. Kubernetes offers automating deployment, scaling, and management of containerized applications. Adopting Kubernetes ultimately accelerates business and saves costs under relatively high application workload.

> Why TiDB?

TiDB is an open-source distributed SQL database that supports HTAP workloads. It provides users with a one-stop database solution, and helps improve scalability, availability and reliability for users' data storage systems.

> Why TiDB on EKS?

When deploying TiDB clusters on AWS EKS, users can gain all features provided by TiDB, while leverage the benefits of operating TiDB clusters on managed Kubernetes services.

> Why IaC (Pulumi)

Infrastructure as code (IaC) means using code to define and manage modern cloud infrastructure. IaC has many benefits, such as:

- Version control
- Testing
- Use of IDEs
- DevOps

## Learning Objectives

- Understand basic usage of TiDB and AWS EKS
- Deploy TiDB clusters on Kubernetes with TiDB Operator
- Query TiDB statements history via TiDB Dashboard
- Automate deployment process with GitHub Actions and Pulumi

## Pre-requisites

- An AWS account with permissions to manage EKS service
- `[aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)`: Amazon EKS uses IAM to provide secure authentication to your Kubernetes cluster.
- `[kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)`: the standard Kubernetes command line interface.
- Basic knowledge of Kubernetes, RDBMS
- VPN for connecting to AWS API

## Syllabus

1. Create an EKS cluster `./1-create-an-eks-cluster/README.md`
2. Deploy TiDB with TiDB Operator `./2-deploy-tidb-with-tidb-operator/README.md`
3. TiDB basic usage
    - Access cluster on local laptop (port forward)
    - Insert records with MySQL CLI
    - Access TiDB dashboard
4. Scale up TiDB cluster with TiDB Operator
    - Check current topology
    - Edit CR yaml
    - Wait for cluster ready
