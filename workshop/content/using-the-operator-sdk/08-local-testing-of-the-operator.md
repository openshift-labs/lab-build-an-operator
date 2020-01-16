Having made a set of changes, the next step is to test them.

To make the task of testing your Operator easier, the Operator SDK provides the `operator-sdk up local` command. This launches the Operator on the local machine
by building the Operator binary and then running it against the Kubernetes cluster you are connected to.

The command for this would have been:

```
operator-sdk up local --namespace %project_namespace%
```

Unfortunately, because the workshop environment, and the terminal you are using, is running in a container inside of the cluster, the Operator thinks it to is running inside of the cluster, rather than outside. As a result, it attempts to perform leader election, which fails, because to perform leader election it needs to know the name of the pod the Operator is deployed as. Because there isn't yet an instance of the Operator running in the cluster, that cannot be determined and it fails.

We will therefore skip local testing and move onto deploying the Operator in the cluster. If you were developing the Operator on your local machine, you would be able to use the local testing as described above.
