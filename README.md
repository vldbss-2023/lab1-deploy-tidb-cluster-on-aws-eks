# lab1-deploy-tidb-cluster-on-aws-eks

This lab deploys a TiDB cluster on an AWS EKS. The deployment process is automated with Pulumi, which is a popular
infrastructure as code (IaC) framework.

## Introduction

> Why cloud platform?

Cloud computing is the delivery of computing services—including servers, storage, databases, networking, software,
analytics, and intelligence—over the internet ("the cloud") to offer faster innovation, flexible resources, and
economies of scale, as your business needs change.

> Why Kubernetes (EKS)?

Amazon EKS is a managed Kubernetes service that makes it easy for you to run Kubernetes on AWS. Kubernetes offers
automating deployment, scaling, and management of containerized applications. Adopting Kubernetes ultimately accelerates
business and saves costs under relatively high application workload.

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

- Understand basic usage of TiDB and AWS EKS
- Deploy TiDB clusters on Kubernetes with TiDB Operator
- Query TiDB statements history via TiDB Dashboard
- Automate deployment process with Pulumi

## Pre-requisites

- An AWS account
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/): the standard Kubernetes command line interface
- Node.js 16. Use nvm to [install Node.js 16](https://github.com/nvm-sh/nvm#installing-and-updating):

  ```bash
  $ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  $ nvm install 16
  ```

- Basic knowledge of AWS, Kubernetes, RDBMS
- VPN for connecting to AWS API and GitHub

## Syllabus

1. Create a new GitHub repository base on [this template](https://github.com/vldbss-2023/lab1-deploy-tidb-cluster-on-aws-eks)
   1. Clone the newly created repository
   2. In the root directory of the repository, run `make install` to install the dependencies
2. (30 min) Create an EKS cluster [`1-create-an-eks-cluster`](./1-create-an-eks-cluster/README.md)
3. (10 min) Deploy TiDB with TiDB
   Operator [`2-deploy-tidb-with-tidb-operator`](./2-deploy-tidb-with-tidb-operator/README.md)
4. (10 min) Explore TiDB basic usage [`3-explore-tidb-basic-usage`](./3-explore-tidb-basic-usage/README.md)
5. (10 min) Scale up TiDB cluster with TiDB
   Operator [`4-scale-up-tidb-cluster-with-tidb-operator`](./4-scale-up-tidb-cluster-with-tidb-operator/README.md)
6. Bonus: Config the [TiDB slowlog threshold](https://docs.pingcap.com/tidb/dev/tidb-configuration-file#slow-threshold) in cluster config and update the cluster with Pulumi code

---

## AWS billing price

This lab will incur charges under the aws account, described in detail at: 

- New EKS cluster control plane, **_1_** cluster x **_0.10_** USD per hour
- Two EKS worker EC2 `t2.medium` instances, **_2_** instances * **_0.0464_** USD per hour
- 4 EBS of size 1 GiB, with negligible cost

Total **_0.1928_** USD per hour.
