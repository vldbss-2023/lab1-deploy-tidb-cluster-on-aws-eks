import * as pulumi from '@pulumi/pulumi'
import * as k8s from '@pulumi/kubernetes'

// Use the EKS cluster from the previous step.
const eksCluster = new pulumi.StackReference(
    'organization/1-create-an-eks-cluster/default'
)
const eksProvider = new k8s.Provider('eks-provider', {
    kubeconfig: eksCluster.getOutput('kubeconfig'),
    enableServerSideApply: true
})

// Install the TiDB Operator CRDs.
const tidbOperatorCRDs = new k8s.yaml.ConfigGroup(
    'tidb-operator-crds',
    { files: 'crds/*.yaml' },
    { provider: eksProvider }
)

// Deploy the TiDB Operator.
const tidbOperator = new k8s.helm.v3.Release(
    'tidb-operator',
    {
        repositoryOpts: {
            repo: 'https://charts.pingcap.org/'
        },
        chart: 'tidb-operator',
        version: 'v1.4.4',
        values: {
            scheduler: {
                kubeSchedulerImageName: 'registry.k8s.io/kube-scheduler'
            }
        }
    },
    { provider: eksProvider, dependsOn: [tidbOperatorCRDs] }
)

// Install the TiDB cluster.
const tidbCluster = new k8s.yaml.ConfigGroup(
    'tidb-cluster',
    {
        files: 'tidb-cluster-manifests/*.yaml',
        transformations: [
            // Put every resource in the created namespace.
            (obj: any) => {                                               // eslint-disable-line
                if (obj.metadata !== undefined) {                               // eslint-disable-line
                    obj.metadata.annotations = {                                // eslint-disable-line
                        'pulumi.com/patchForce': 'true'
                    }
                } else {
                    obj.metadata = {                                            // eslint-disable-line
                        annotations: { 'pulumi.com/patchForce': 'true' }
                    }
                }
            }
        ]
    },
    { provider: eksProvider, dependsOn: [tidbOperator] }
)
