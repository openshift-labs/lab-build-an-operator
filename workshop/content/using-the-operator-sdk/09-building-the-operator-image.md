Instead of running the Operator locally and testing it against the cluster, we will build a container image for the Operator, push the image to the internal image registry of the cluster, and then create a deployment for it.

Before building the image for the Operator, we first need to ensure that vendor packages are available and up to date. Run:

```execute
go mod vendor
```

Now build the image using the `operator-sdk build` command. The image name we provide here is what the final name for the image will be when pushed to the internal image registry. We will be using `buildah` to build the image.

To start the build run:

```execute
operator-sdk build --image-builder buildah %image_registry%/%project_namespace%/podset-operator:0.1.0
```

<span class="fas fa-exclamation-circle"></span> This will take a while the first time it is run (up to 5 minutes in this workshop environment).

The steps in the build process are to compile all the Go code which makes up the Operator and the packages it uses. It will then build the container image using the `Dockerfile` in the `build` directory, with the compiled binaries as input.

Once the build completes, to see that the container image has been created, run:

```execute
podman images
```

To push the image to the internal image registry, you first need to login to the registry.

```execute
podman login -u default -p `oc whoami -t` %image_registry%
```

Now push the image to the registry:

```execute
podman push %image_registry%/%project_namespace%/podset-operator:0.1.0
```

Verify that the image has been uploaded by querying the image stream:

```execute
oc get is/podset-operator
```
