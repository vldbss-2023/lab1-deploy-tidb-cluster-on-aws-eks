# The Very First Step: Install Dependencies

<!-- TOC -->
* [The Very First Step: Install Dependencies](#the-very-first-step-install-dependencies)
  * [Create Your Own GitHub Repository](#create-your-own-github-repository)
  * [Install `kubectl`](#install-kubectl)
  * [Install `Node.js 16`](#install-nodejs-16)
  * [Set up AWS CLI](#set-up-aws-cli)
    * [Install AWS CLI](#install-aws-cli)
    * [Config AWS Credentials](#config-aws-credentials)
  * [Install `pulumi`](#install-pulumi)
  * [Install Helm](#install-helm)
<!-- TOC -->

## Create Your Own GitHub Repository

Create a new GitHub repository base on [this template](https://github.com/vldbss-2023/lab1-deploy-tidb-cluster-on-aws-eks).

1. Create your own lab1 repository by clicking the green button
   ![use_template](../.imgs/use_template.png)
2. Clone the newly created repository
3. In the root directory of the repository, run `make install` to install the dependencies

## Install `kubectl`

[`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/): the standard Kubernetes command line interface

## Install `Node.js 16`

Use nvm to [install Node.js 16](https://github.com/nvm-sh/nvm#installing-and-updating):

```bash
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
$ nvm install 16
```

## Set up AWS CLI

### Install AWS CLI

- https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- [`aws-iam-authenticator`](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html):
  Amazon EKS uses IAM to provide secure authentication to your Kubernetes cluster.

### Config AWS Credentials

> This step requires you to have an AWS account (access key and secret access key). If you don't have one now, just skip this step.

Run this command to quickly set and view your credentials, region, and output format. The following example shows
sample values.

```bash
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE # <-- Replace with your own access key
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY # <-- Replace with your own secret access key
Default region name [None]: ap-southeast-1
Default output format [None]: yaml
```

## Install `pulumi`

Pulumi is an open-source infrastructure as code (IaC) platform that helps developers safely and predictably create, manage, and improve infrastructure.

https://www.pulumi.com/docs/get-started/install/

## Install Helm

Helm is a tool that automates the creation, packaging, configuration, and deployment of Kubernetes applications.

> A.K.A., A lightweight alternative to Pulumi on Kubernetes.

```bash
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```
