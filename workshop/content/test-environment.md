To get started let's check that have required roles.

Can we create custom resource definitions.

```execute
oc auth can-i create customresourcedefinitions
```

Can we delete our custom resource definitions.

```execute
oc auth can-i delete customresourcedefinitions/%project_namespace%-pizzastands
```

Can we delete other custom resource definitions.

```execute
oc auth can-i delete customresourcedefinitions
```

Can we create a Kafka cluster.

```execute
oc auth can-i create kafkas
```

Can we deploy a Pizza Stand application.

```execute
oc auth can-i create %project_namespace%-pizzastands
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
podman tag tests docker-registry.default.svc:5000/%project_namespace%/tests:latest
```

Login to the OpenShift internal registry:

```execute
podman login -u default -p `oc whoami -t` docker-registry.default.svc:5000
```

Push the image to the registry:

```execute
podman push docker-registry.default.svc:5000/%project_namespace%/tests:latest
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
