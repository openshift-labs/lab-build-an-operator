When you defined the name for your custom resource a Go code file was generated corresponding to the resource type. This code is used to specify what custom attributes your resource type will have. Initially the code file does not define any attributes.

To see the initial code file generated, and the structures it contains corresponding to the custom resource type, run:

```execute
cat pkg/apis/app/v1alpha1/podset_types.go
```

The key structures are:

```
type PodSetSpec struct {
        // INSERT ADDITIONAL SPEC FIELDS
}

type PodSetStatus struct {
        // INSERT ADDITIONAL STATUS FIELD
}

type PodSet struct {
        metav1.TypeMeta   `json:",inline"`
        metav1.ObjectMeta `json:"metadata,omitempty"`

        Spec   PodSetSpec   `json:"spec,omitempty"`
        Status PodSetStatus `json:"status,omitempty"`
}
```

For this example operator, we want to add a `replicas` attribute to the `spec` portion of the custom resource. This will specify how many instances of the application we want. The `PodSetSpec` structure therefore needs to be updated to:

```
type PodSetSpec struct {
        Replicas int32 `json:"replicas"`
}
```


To record the names of the pods corresponding to those instances, we also add a `podNames` attribute to the `status` portion of the custom resource. The `status` portion is where the operator keeps any attributes to report the status of the deployment based on the custom resource.

```
type PodSetStatus struct {
        PodNames []string `json:"podNames"`
}
```

To patch the `podset_types.go` file with these changes, run:

```execute
patch -p0 < $HOME/patches/podset_types.go.diff
```

After making any changes to the Go code files containing the custom resource definitions, you need to run:

```execute
operator-sdk generate k8s
```

This will re-generate code files which depend on the definition of the custom resource.

Also run:

```execute
operator-sdk generate openapi
```

This will re-generate the CRD file, updating the OpenAPI schema definition which describes the attributes. The schema is used for validating that a custom resource when created is valid, and is also used when running `oc explain` on a custom resource type to generate information about it.

For more information on the schema, see the Kubernetes documentation on [specifying a structural schema](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/#specifying-a-structural-schema).

To see the updated version of the CRD file run:

```execute
cat deploy/crds/app_v1alpha1_podset_crd.yaml
```

The schema definition for the custom resource can be found under the `spec.validation.openAPIV3Schema` field.
