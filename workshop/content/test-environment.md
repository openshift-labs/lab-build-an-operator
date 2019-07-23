To get started let's check that have required roles.

Can we create custom `pizzastands`.

```execute
oc auth can-i create pizzastands
```

Can we create a Kafka cluster.

```execute
oc auth can-i create kafkas
```

Now let's check that `podman` works.

Pull down the `busybox` image:

```execute
podman pull busybox
```

Review the list of images:

```execute
podman images
```

Now run the image:

```execute
podman run --rm -it busybox sh
```

You should be presented with a command line prompt for the shell running inside of the busybox container.

Run:

```execute
busybox | head -1
```

You should see output similar to:

```
BusyBox v1.31.0 (2019-07-16 01:13:11 UTC) multi-call binary.
```

Run:

```execute
exit
```

to exit the container.

Now lets build our own image.

Change to the `tests` directory.

```execute
cd tests
```

Look at what files are in the directory:

```execute
ls -las
```

You should see a `Dockerfile`. This includes the instructions to build the image.

```execute
cat Dockerfile
```

To build the image run:

```execute
podman build -t tests .
```

Review the list of images:

```execute
podman images
```

With the image built, run it:

```execute
podman run --rm -it tests sh
```

Verify that the file `/tmp/helloworld` exists.

```execute
ls -las /tmp
```

Exit from the container:

```execute
exit
```

Lets tag this image:

```execute
podman tag tests image-registry.openshift-image-registry.svc:5000/%project_namespace%/tests:latest
```

Login to the OpenShift internal registry:

```execute
podman login -u default -p `oc whoami -t` image-registry.openshift-image-registry.svc:5000 --tls-verify=false
```

Push the image to the registry:

```execute
podman push image-registry.openshift-image-registry.svc:5000/%project_namespace%/tests:latest --tls-verify=false
```

Verify the image is uploaded:

```execute
oc get is
```

Deploy the image from the registry:

```execute
oc new-app tests:latest
```

Watch it being deployed:

```execute
oc rollout status dc/tests
```

Change back to the top level directory.

```execute
cd
```

Now lets try the operator SDK.

```execute
operator-sdk new pizzastand-operator
```

Change to the directory of the generated files.

```execute
cd pizzastand-operator
```

Add a new API for the custom resource `PizzaStand`

```execute
operator-sdk add api --api-version=workshops.openshift.dev/v1 --kind=PizzaStand
```

Add a new controller that watches for `PizzaStand`.

```execute
operator-sdk add controller --api-version=workshops.openshift.dev/v1 --kind=PizzaStand
```

Build the operator image.

First run this magic command else things don't work.

```execute
go mod vendor
```

Then do the build.

```execute
operator-sdk build image-registry.openshift-image-registry.svc:5000/%project_namespace%/pizzastand-operator
```

Push the image to the internal OpenShift image registry.

```execute
podman push image-registry.openshift-image-registry.svc:5000/%project_namespace%/pizzastand-operator --tls-verify=false
```

---

Done for now. Still need to convert the rest.

---

# Update the operator manifest to use the built image name (if you are performing these steps on OSX, see note below)
$ sed -i 's|REPLACE_IMAGE|quay.io/example/app-operator|g' deploy/operator.yaml
# On OSX use:
$ sed -i "" 's|REPLACE_IMAGE|quay.io/example/app-operator|g' deploy/operator.yaml

# Setup Service Account
$ kubectl create -f deploy/service_account.yaml
# Setup RBAC
$ kubectl create -f deploy/role.yaml
$ kubectl create -f deploy/role_binding.yaml
# Setup the CRD
$ kubectl create -f deploy/crds/app_v1alpha1_appservice_crd.yaml
# Deploy the app-operator
$ kubectl create -f deploy/operator.yaml

# Create an AppService CR
# The default controller will watch for AppService objects and create a pod for each CR
$ kubectl create -f deploy/crds/app_v1alpha1_appservice_cr.yaml

# Verify that a pod is created
$ kubectl get pod -l app=example-appservice
NAME                     READY     STATUS    RESTARTS   AGE
example-appservice-pod   1/1       Running   0          1m

# Test the new Resource Type
$ kubectl describe appservice example-appservice
