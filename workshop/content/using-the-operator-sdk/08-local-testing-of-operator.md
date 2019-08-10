Having made the changes we need to test them.

To make the task of testing your operator easier, the Operator SDK provides the `operator-sdk up local` command. This launches the operator on the local machine
by building the operator binary and then running it against the Kubernetes cluster you are connected to.

Before running this command, we first need to ensure that vendor modules are updated.

```execute
go mod vendor
```

Now run:

```execute
operator-sdk up local --namespace %project_namespace% --verbose
```

This will take some time to get started the first time it is run, as it is compiling the Go code for the operator.
