Having made a set of changes it is a good idea to test them.

To make the task of testing your operator easier, the Operator SDK provides the `operator-sdk up local` command. This launches the operator on the local machine
by building the operator binary and then running it against the Kubernetes cluster you are connected to.

The command for this would have been:

```
operator-sdk up local --namespace %project_namespace%
```

Unfortunately, because the workshop environment, and the terminal you are using, is running in a container inside of the cluster, the operator thinks it to is running inside of the cluster, rather than outside. As a result, it attempts to perform leader election, which fails, because to perform leader election it needs to know the name of the pod the operator is deployed as. Because there isn't yet an instance of the operator running in the cluster, that cannot be determined and it fails.

We will therefore skip local testing and move onto deploying the operator in the cluster. You would though be able to perform local testing if you were developing the operator on your own machine.
