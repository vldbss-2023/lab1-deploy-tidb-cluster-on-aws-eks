import * as eks from '@pulumi/eks'
import * as pulumi from '@pulumi/pulumi'
import * as aws from '@pulumi/aws'

// Create an EKS cluster with the default configuration.
// This cluster uses reasonable defaults, like:
//  - Placing the cluster into your default VPC with a CNI interface
//  - Using AWS IAM Authenticator to leverage IAM for secure access to your cluster
//  - Using two t2.medium nodes.
const cluster = new eks.Cluster('my-eks', {
    createOidcProvider: true
})

// Install the EBS CSI driver on the cluster.
const clusterOidcProviderUrl = cluster.core.oidcProvider!.url // eslint-disable-line
const clusterOidcProviderArn = cluster.core.oidcProvider!.arn // eslint-disable-line
const ebsCsiDriverName = 'my-eks-ebs-csi-driver'
const role = pulumi.all([clusterOidcProviderUrl, clusterOidcProviderArn]).apply(
    ([url, arn]) =>
        new aws.iam.Role(ebsCsiDriverName, {
            assumeRolePolicy: {
                Version: '2012-10-17',
                Statement: [
                    {
                        Effect: 'Allow',
                        Principal: {
                            Federated: arn
                        },
                        Action: 'sts:AssumeRoleWithWebIdentity',
                        Condition: {
                            StringEquals: {
                                [`${url.replace('https://', '')}:aud`]:
                                    'sts.amazonaws.com',
                                [`${url.replace(
                                    'https://',
                                    ''
                                )}:sub`]: `system:serviceaccount:kube-system:ebs-csi-controller-sa`
                            }
                        }
                    }
                ]
            }
        })
)
const attachment = role.apply(
    (r) =>
        new aws.iam.RolePolicyAttachment(ebsCsiDriverName, {
            role: r,
            policyArn: aws.iam.ManagedPolicy.AmazonEBSCSIDriverPolicy
        })
)
const addon = role.apply(
    (r) =>
        new aws.eks.Addon(ebsCsiDriverName, {
            addonName: 'aws-ebs-csi-driver',
            clusterName: cluster.core.cluster.name,
            serviceAccountRoleArn: r.arn
        })
)

// Export the cluster's kubeconfig so that we can access kubeconfig outside this pulumi stack.
export const kubeconfig = cluster.kubeconfig
