Before you can start creating instances of your custom resource and run an operator which relies on it, you need to load the CRD for the custom resource into the cluster.

To load the CRD, run:

```execute
kubectl apply -f deploy/crds/app_v1alpha1_podset_crd.yaml
```

To verify that the CRD has been loaded run:

```execute
kubectl describe crd/podsets.app.example.com
```

This will display the schema for the custom resource described by the CRD. To perform queries against the schema, you can use `kubectl explain`.

To see the custom attributes added to the `spec` for the custom resource, run:

```execute
kubectl explain podset.spec
```

and for the `status`, run:

```execute
kubectl explain podset.status
```

At the moment no descriptions have been provided for the custom attributes, so only information about the type of the attributes will be shown.

To check that you can now create instances of the `podset` resource, run:

```execute
kubectl auth can-i create podset
```

It should respond with `yes`.
