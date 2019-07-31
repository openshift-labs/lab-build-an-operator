Where an operator is installed by a cluster admin and managed by the Operator Lifecycle Manager, you can use the web console to create and manage the resources deployed using that operator.

That it can be managed through the web console doesn't prevent you from still managing it from the command line. Operators being a direct extension to Kubernetes, this can be done using either the `kubectl` or `oc` command line clients.

To create an `etcd` cluster from the command line you first need the YAML resource definition for the `EtcdCluster` resource. To generate the YAML file with the definition, run:

```execute
cat > example-cluster.yaml << EOF
apiVersion: etcd.database.coreos.com/v1beta2
kind: EtcdCluster
metadata:
  name: example
  annotations:
    etcd.database.coreos.com/scope: clusterwide
spec:
  size: 3
  version: 3.2.13
EOF
```

Verify the contents of the file by running:

```execute
cat example-cluster.yaml
```

Before creating the resource, set up a watch on the active pods in the project by running:

```execute-2
watch kubectl get pods
```

Now run:

```execute
kubectl apply -f example-cluster.yaml
```

The watch will show the pod corresponding to each instance member of the cluster in turn being created and set running.

Once all three pods are up and running, run:

```execute
POD=`kubectl get pods --field-selector=status.phase=Running -o name | head -1 -`; echo $POD
```

This will grab the name of one of the running pods and save it in the `POD` environment variable.

Kill that pod by running:

```execute
kubectl delete $POD
```

You will see the pod terminating, and then after a short wait it will be replaced with a new instance.

That the pod is replaced when terminated, is behaviour which should be familiar to you from traditional deployments of applications in a Kubernetes cluster. What is happening here though, isn't quite the same.

To understand why, run the command:

```execute
kubectl get replicationcontroller,replicaset,statefulset,daemonset
```

The output you will see is:

```
No resources found.
```

As you can see, there aren't any instances of the resource types used with traditional application deployments, for managing a set of pods, and ensuring they are kept running.

This is because it is the `etcd` operator itself which is directly managing the creation of the pods, and replacing them if they terminate unexpectedly. The operator is therefore acting as a controller, in much the same way as occurs for `replicationcontroller`, `replicaset`, `statefulset` or `daemonset`.

The reason that the `etcd` operator manages the pods directly, is that replacing a terminated pod isn't as simple as running a new one in its place. The operator needs to ensure that the new instance is correctly joined into the existing cluster, any state for the cluster copied to the new instance from an existing member, and a new leader election run.

It is the need for such special steps in managing the set of pods in the cluster, that the operator is fulfilling, and why `replicationcontroller`, `replicaset`, `statefulset` or `daemonset` cannot be used.

The get a list of resources the that `etcd` operator has created, run:

```execute
kubectl get all -l etcd_cluster=example -o name
```

You will see that the only extra resources it has created beyond the pods which is it managing directly, are the service objects which allow the cluster to be accessed by applications wishing to use it.
