import * as eks from '@pulumi/eks'

// Create an EKS cluster with the default configuration.
// This cluster uses reasonable defaults, like:
//  - Placing the cluster into your default VPC with a CNI interface
//  - Using AWS IAM Authenticator to leverage IAM for secure access to your cluster
//  - Using two t2.medium nodes.
const cluster = new eks.Cluster('my-eks', {})

export const _kubeconfig = cluster.kubeconfig
