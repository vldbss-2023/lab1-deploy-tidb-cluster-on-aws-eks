# Step 4: Scale up TiDB cluster with TiDB Operator

The following steps guides you the basic usage of a newly deployed TiDB cluster. It takes about 10 minutes to complete.

> - Please make sure you have completed [Step 1: Create an EKS cluster](../1-create-an-eks-cluster/README.md) and use *
    *_the same shell session_** before proceeding.
> - If you have closed the shell session, please run `export KUBECONFIG=$PWD/../1-create-an-eks-cluster/kubeconfig.yaml`
    to load the kubeconfig env.

1. Just return to the code of Step 2 [`2-deploy-tidb-with-tidb-operator`](../2-deploy-tidb-with-tidb-operator/README.md)

2. Edit the TiDB manifest file in Step
   2 [`2-deploy-tidb-with-tidb-operator`](../2-deploy-tidb-with-tidb-operator/README.md)

   [`tidb-cluster.yaml`](../2-deploy-tidb-with-tidb-operator/tidb-cluster-manifests/tidb-cluster.yaml)

   ```diff
     tikv:
       baseImage: pingcap/tikv
       maxFailoverCount: 0
       evictLeaderTimeout: 1m
   -   replicas: 1
   +   replicas: 2
       requests:
         storage: "1Gi"
       config:
         storage:
           reserve-space: "0MB"
         rocksdb:
           max-open-files: 256
         raftdb:
           max-open-files: 256
   ```

3. Follow the Step 2 instructions and apply the manifest file

   **_CD to the `../2-deploy-tidb-with-tidb-operator/` directory._**

   ```bash
   $ cd ../2-deploy-tidb-with-tidb-operator/
   $ export PULUMI_CONFIG_PASSPHRASE=""
   $ pulumi stack select default
   $ pulumi up
   ```

4. Wait for TiDB cluster ready

   ```bash
   $ kubectl get po
   NAME                                       READY   STATUS    RESTARTS   AGE
   basic-discovery-cff6d579c-npzmv            1/1     Running   0          141m
   basic-monitor-0                            4/4     Running   0          141m
   basic-pd-0                                 1/1     Running   0          110m
   basic-tidb-0                               2/2     Running   0          108m
   basic-tidb-dashboard-0                     1/1     Running   0          110m
   basic-tikv-0                               1/1     Running   0          109m
   basic-tikv-1                               1/1     Running   0          105s
   tidb-controller-manager-75959db68d-gdbv6   1/1     Running   0          141m
   tidb-scheduler-55d58fdd7f-kch9g            2/2     Running   0          141m
   ```

   You can see the newly created `basic-tikv-1` pod.
