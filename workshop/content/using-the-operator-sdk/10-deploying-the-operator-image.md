When you use the Operator SDK it will create you resource definitions for deploying the operator into the cluster. To view the deployment configuration which was generated, run:

```execute
cat deploy/operator.yaml
```

In this resource definition you will see that `spec.template.spec.containers.image` is set as:

```
image: REPLACE_IMAGE
```

We need to update `REPLACE_IMAGE`, changing it to reference the image from the internal image registry where we pushed it. To change this, run:

```execute
sed -i.bak -e "s#REPLACE_IMAGE#%image_registry%/%project_namespace%/podset-operator:0.1.0#" deploy/operator.yaml
```

Before we create this resource, we first need to create the service account which the deployment has been set up to run as:

```execute
kubectl apply -f deploy/service_account.yaml
```

We also need to create a role indicating what actions the service account can take:

```execute
kubectl apply -f deploy/role.yaml
```

Then bind the role to the service account:

```execute
kubectl apply -f deploy/role_binding.yaml
```

Finally we can create the deployment:

```execute
kubectl apply -f deploy/operator.yaml
```

To see that the pod for the operator is running, you can use:

```execute
kubectl get pods -l name=podset-operator
```

Keep running this command until the status has transitioned to "Running".

So we can monitor what the operator is doing as we test it, grab the name of the pod:

```execute-2
POD=`kubectl get pods -l name=podset-operator --field-selector=status.phase=Running -o name | head -1 -`; echo $POD
```

Now tail the logs for the pod:

```execute-2
kubectl logs $POD -f
```
