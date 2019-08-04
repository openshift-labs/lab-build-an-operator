When you defined the name for your custom resource a Go code file was generated corresponding to the resource type. This code is used to specify what custom attributes your resource type will have. Initially the code file does not define any attributes.

To see the initial code file generated, and the structures it contains corresponding to the custom resource type, run:

```execute
cat pkg/apis/app/v1alpha1/podset_types.go
```

The key structures are:

```
type PodSetSpec struct {
        // Need to add attributes here.
}

type PodSetStatus struct {
        // Need to add attributes here.
}

type PodSet struct {
        metav1.TypeMeta   `json:",inline"`
        metav1.ObjectMeta `json:"metadata,omitempty"`

        Spec   PodSetSpec   `json:"spec,omitempty"`
        Status PodSetStatus `json:"status,omitempty"`
}
```

For this example operator, we want to add a `replicas` attribute to the `spec` portion of the custom resource. This will specify how many instances of the application we want. The `PodSetSpec` structure therefore needs to be updated to:

```copy
type PodSetSpec struct {
        Replicas int32 `json:"replicas"`
}
```


To track the names of the pods corresponding to those instances, we also add a `podNames` attribute to the `status` portion of the custom resource. The `status` portion is where the operator keeps any attributes it needs to track the status of the deployment based on the custom resource.

```copy
type PodSetStatus struct {
        PodNames []string `json:"podNames"`
}
```

To patch the `podset_types.go` file with this changes, run:

```execute
patch -p0 < $HOME/patches/podset_types.go.diff
```

Alternatively, you can if you want, edit the file manually using `vi` or `nano`.
