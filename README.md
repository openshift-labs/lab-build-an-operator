Lab - Build an Operator
=======================

This is a workshop demonstrating the use of a pre-installed operator, as well as the process for creating, building and deploying your own operator.

WARNING WARNING WARNING
-----------------------

This workshop uses ``podman`` inside of a container in the OpenShift cluster. Currently this requires that it be run as `root` and inside of a `privileged` container. There is a risk that anyone doing the workshop could take advantage of this and break out of the container or affect the underlying nodes.

Further, to allow the deployment of the operator, permissions have been granted to allow a user to be able to create custom resource definitions without being a full cluster admin.

Because of this elevated access rights, only use this workshop on an expendable cluster which is going to be destroyed when the workshop is finished.

Deploying the Workshop
----------------------

To deploy the workshop, first clone this Git repository to your own machine.

Next create a project in OpenShift into which the workshop is to be deployed.

```
oc new-project workshops
```

From within the top level of the Git repository, now run:

```
./.workshop/scripts/deploy-spawner.sh
```

The name of the deployment will be ``lab-build-an-operator``.

You can determine the hostname for the URL to access the workshop by running:

```
oc get route lab-build-an-operator
```

Building the Workshop
---------------------

The deployment created above will use an image for an empty workshop.

To deploy this workshop content, or make changes to the workshop content and test them, edit the files in the Git repository and then run:

```
./.workshop/scripts/build-workshop.sh
```

This will replace the existing image used by the active deployment.

If you are running an existing instance of the workshop, from your web browser select "Restart Workshop" from the menu top right of the workshop environment dashboard.

When you are happy with your changes, push them back to the remote Git repository.

If you need to change the RBAC definitions, or what resources are created when a project is created, change the definitions in the ``templates`` directory. You can then re-run:

```
./.workshop/scripts/deploy-spawner.sh
```

and it will update the active definitions.

Note that if you do this, you will need to re-run:

```
./.workshop/scripts/build-workshop.sh
```

to have any local content changes be used once again as it will revert back to using the image on ``quay.io``.

Deleting the Workshop
---------------------

To delete the spawner and any active sessions, including projects, run:

```
./.workshop/scripts/delete-spawner.sh
```

To delete the build configuration for the workshop image, run:

```
./.workshop/scripts/delete-workshop.sh
```

To delete any global resources which may have been created, run:

```
./.workshop/scripts/delete-resources.sh
```
