The `Reconcile()` function is what needs to perform state reconciliation for your operator. That is, ensure that the current state of resources created by the operator, match what the custom resource has specified they need to be.

For our operator, as previously described, we need to update the operator code to handle a set of pods, the number of which is dictated by `spec.replicas`.

To apply the required changes, run:

```execute
patch -p0 < $HOME/patches/podset_controller.go.diff
```

To view the changes to the `Reconcile()` function run:

```execute
cat pkg/controller/podset/podset_controller.go
```
