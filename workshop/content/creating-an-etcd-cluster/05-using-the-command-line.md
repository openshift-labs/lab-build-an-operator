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

The watch will show the pod corresponding to each instance member of the cluster in turn being created, initialised and set running.

Once all three pods are up and running, run:

```
POD=`kubectl get pods --field-selector=status.phase=Running -o name | head -1 -`; echo $POD
```

This will grab the name of one of the running pods and save it in the `POD` environment variable.

Kill that pod by running:

```execute
kubectl delete $POD
```
