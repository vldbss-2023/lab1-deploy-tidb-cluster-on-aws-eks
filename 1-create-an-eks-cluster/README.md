# Step 1: Create an EKS cluster

The following steps guide you through the process of creating an EKS cluster on AWS, with the help of Pulumi IaC
framework. It takes about **_30_** minutes to complete.

1. Set up AWS CLI

    1. Install AWS CLI

        - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
        - `[aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)`:
          Amazon EKS uses IAM to provide secure authentication to your Kubernetes cluster.

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
    Updating (default):

         Type                      Name                            Status
    +   pulumi:pulumi:Stack        1-create-an-eks-cluster-default created
    +   └─ eks:index:Cluster       my-eks                          created
        ... dozens of resources omitted ...
    ```

4. Interact with the newly created EKS cluster

    ```bash
    $ pulumi stack output kubeconfig > kubeconfig.yaml
    $ export KUBECONFIG=$PWD/kubeconfig.yaml

    $ kubectl get nodes
    NAME                                            STATUS   ROLES    AGE   VERSION
    ip-xxx-xxx-xxx-xxx.us-west-2.compute.internal   Ready    <none>   27m   v1.27.1-eks-2f008fe
    ip-xxx-xxx-xxx-xxx.us-west-2.compute.internal   Ready    <none>   27m   v1.27.1-eks-2f008fe
    ```
