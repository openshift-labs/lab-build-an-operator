The operator will watch for any instances of the `PodSet` custom resource. Let's update the original sample resource file for `PodSet` which was created for us to have the `spec.replicas` attribute which the operator implements. Run:

```execute
cat > deploy/crds/app_v1alpha1_podset_cr.yaml << EOF
apiVersion: app.example.com/v1alpha1
kind: PodSet
metadata:
  name: example-podset
spec:
  replicas: 3
EOF
```

Now create an instance of the custom resource from this resource file:

```execute
oc apply -f deploy/crds/app_v1alpha1_podset_cr.yaml
```

You should see the operator logs update as it responds to the custom resource, creates the corresponding pods, and then update the custom resource status with the list of pods.

To see the list of pods created corresponding to the custom resource, run:

```execute
oc get pods -l app=example-podset
```

Now verify that these are the pod names recorded in the status of the custom resource:

```execute
oc get podset/example-podset -o yaml
```

Stop the tailing of the log file.

```execute-2
<ctrl-c>
```

Instead, run a watch on the pods:

```execute-2
watch oc get pods -l app=example-podset
```

Grab the name of one of the running pods:

```execute
POD=`oc get pods -l app=example-podset --field-selector=status.phase=Running -o name | head -1 -`; echo $POD
```

Delete the pod:

```execute
oc delete $POD
```

You should see from the watch that the pod starts terminating and at the same time is replaced. Because the pod is running `sleep` within `busybox`, and doesn't respond correctly to signals, it will take a little while before it completely disappears.

Check the status of the custom resource to verify the list of current pods has been updated:

```execute
oc get podset/example-podset -o yaml
```

Next confirm that the operator handles scaling the number of pods correctly, by changing the number of replicas. We will scale it down to one replica.

```execute
oc patch podset/example-podset --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value":1}]'
```

Two of the pods should be terminated, leaving just one.

Stop the watch for the pods.

```execute-2
<ctrl-c>
```
