# Step 2: Deploy a TiDB cluster with TiDB Operator

The following steps guides you through the process of scaling TiKV instance for a TiDB Operator managed cluster. It takes about
10 minutes to complete.

> - Please make sure you have completed [Step 1: Create an EKS cluster](../1-create-an-eks-cluster/README.md) and use *
    *_the same shell session_** before proceeding.
> - If you have closed the shell session, please run `export KUBECONFIG=$PWD/../1-create-an-eks-cluster/kubeconfig.yaml`
    to load the kubeconfig env.

1. Install Helm

    1. Download

        ```bash
        $ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        $ chmod 700 get_helm.sh
        $ ./get_helm.sh
        ```

    2. Init

        ```bash
        $ helm init --client-only
        ```

2. Set up Pulumi

    1. Install Pulumi

       https://www.pulumi.com/docs/get-started/install/

    2. Initialize to Pulumi

       ```bash
       $ pulumi login --local
       $ export PULUMI_CONFIG_PASSPHRASE="" # Set passphrase env to `""`. This passphrase is required by Pulumi and was created by Lab maintainer.
       $ pulumi stack select default -c # Select the `default` stack.
       ```

3. Deploy TiDB Operator and TiDB Cluster via Pulumi

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

4. Wait for TiDB cluster ready

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
