The `Reconcile()` function is what performs resource state reconciliation for your Operator. That is, ensure that the current state of resources created by the Operator match what the custom resource has specified they need to be.

For our Operator, as previously described, we need to update the Operator code to handle a set of pods, the number of which is dictated by `spec.replicas`.

To apply the required changes, run:

```execute
patch -p0 < $HOME/patches/podset_controller.go.diff
```

To view the changes to the `Reconcile()` function run:

```execute
grep -A90 "^func.* Reconcile.*"  pkg/controller/podset/podset_controller.go
```

We will not be delving further into how to write the code for the operator than we have. For further information see the [Operator SDK user guide](https://github.com/operator-framework/operator-sdk/blob/master/doc/user-guide.md).
