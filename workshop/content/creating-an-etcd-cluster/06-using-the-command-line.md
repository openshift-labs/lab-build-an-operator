Up till this point we have done everything using the web console. Operators being a direct extension to Kubernetes, they can also be used from the command line. This can be done using either the `kubectl` or `oc` command line clients. In this workshop we will use `oc`.

To create an etcd cluster from the command line you first need the YAML resource definition for the `EtcdCluster` resource. To generate the YAML file with the definition, run:

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
watch oc get pods
```

Now run:

```execute
oc apply -f example-cluster.yaml
```

You can perform operations on the resource created by referring to it as `etcdcluster/example`:

```execute
oc get etcdcluster/example
```

The watch you started above will show the pod corresponding to each instance member of the cluster in turn being created and set running.

Once all three pods are up and running, run:

```execute
POD=`oc get pods --field-selector=status.phase=Running -o name | head -1 -`; echo $POD
```

This will grab the name of one of the running pods and save it in the `POD` environment variable.

Kill that pod by running:

```execute
oc delete $POD
```

You will see the pod terminating, and then after a short wait it will be replaced with a new instance.

That the pod is replaced when terminated is behaviour which should be familiar to you from traditional deployments of applications in a Kubernetes cluster. What is happening here though, isn't quite the same.

To understand why, run the command:

```execute
oc get replicationcontroller,replicaset,statefulset,daemonset
```

The output you will see is:

```
No resources found.
```

As you can see, there aren't any instances of the resource types used with traditional application deployments, for managing a set of pods, and ensuring they are kept running.

This is because it is the etcd Operator itself which is directly managing the creation of the pods, and replacing them if they terminate unexpectedly. The operator is therefore acting as a controller, in much the same way as occurs for `ReplicationController`, `ReplicaSet`, `StatefulSet` or `DaemonSet`.

The reason that the etcd Operator manages the pods directly is that replacing a terminated pod isn't as simple as running a new one in its place. The Operator needs to ensure that the new instance is correctly joined into the existing cluster, any state for the cluster copied to the new instance from an existing member, and a new leader election run.

It is the need for such special steps in managing the set of pods in the cluster, that the operator is fulfilling, and why `ReplicationController`, `ReplicaSet`, `StatefulSet` or `DaemonSet` cannot be used.

To get a list of the resources that the etcd Operator has created, run:

```execute
oc get all -l etcd_cluster=example -o name
```

You will see that the only extra resources it has created beyond the pods which it is managing directly are the service objects which allow the cluster to be accessed by applications wishing to use it.

That the etcd Operator manages the pods directly doesn't mean all Operators need to manage everything themselves. An Operator can still use the existing resource types for managing a set of pods. The etcd Operator only does it because of the extra requirements it has of ensuring members of the cluster interact with each other in a particular way when a new pod is started up and needs to be joined to the cluster.

Either way, any changes you need to make to the managed set of resources would be done by making changes to the original custom resource. You would not make changes directly to the managed resources. In fact, changes made directly to the managed resources would often be reverted by the Operator to ensure that what is deployed matches what the custom resource defines.

For our current example, to modify from the command line the number of instance members in the cluster, you can patch the original custom resource.

```execute
oc patch etcdcluster/example --type=merge -p '{"spec":{"size":1}}'
```

This will reduce the number of instance members in the cluster from 3 down to 1.

You could also use `oc edit` or other methods for updating in place the existing custom resource definition.

We are done with the etcd cluster, so you can now delete the cluster, by deleting the custom resource.

```execute
oc delete etcdcluster/example
```

When all the pods have been terminated and the cluster shutdown, kill the watch command:

```execute-2
<ctrl+c>
```
