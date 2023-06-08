# Step 2: Deploy a TiDB cluster with TiDB Operator

    - Operator what and why
        - What is CRD
    - Deploy TiDB Operator on EKS
    - Deploy TiDB
        - Cluster topology and resources planning
        - Write CR yaml file
        - Apply and wait for cluster ready

1. Set up AWS CLI

    1. Install AWS CLI

       https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

    2. Config AWS credentials

       Run this command to quickly set and view your credentials, region, and output format. The following example shows
       sample values.

        ```bash
        $ aws configure
        AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
        AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
        Default region name [None]: us-west-2
        Default output format [None]: yaml
        ```

2. Set up Pulumi

    1. Install Pulumi

       https://www.pulumi.com/docs/get-started/install/

    2. Login to Pulumi

       ```bash
       $ pulumi login --local
       ```

    3. Set passphrase env to `""`

        > This passphrase is required by Pulumi and was created by Lab maintainer.

       ```bash
       $ export PULUMI_CONFIG_PASSPHRASE=""
       ```

    4. Select the `default` stack

       ```bash
       $ pulumi stack select default
       ```

3. Create the EKS cluster via Pulumi (may take more than **_10_** minutes)

    ```bash
    $ pulumi up
    Updating (dev):

         Type                       Name                            Status
    +   pulumi:pulumi:Stack        crosswalk-aws-dev               created
    +   └─ eks:index:Cluster       my-cluster                      created
        ... dozens of resources omitted ...
    ```

4. Interact with the newly created EKS cluster

    ```bash
    $ pulumi stack output kubeconfig > kubeconfig.yaml
    $ export KUBECONFIG=$PWD/kubeconfig.yaml

    $ kubectl get nodes
    NAME                                          STATUS   ROLES    AGE   VERSION
    ip-xxx-xxx-xxx-xxx.us-west-2.compute.internal   Ready    <none>   27m   v1.27.1-eks-2f008fe
    ip-xxx-xxx-xxx-xxx.us-west-2.compute.internal   Ready    <none>   27m   v1.27.1-eks-2f008fe
    ```
