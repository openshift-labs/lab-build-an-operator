# Lab - Build an Operator

* [Overview](#overview)
* [Deploying the Workshop](#deploying-the-workshop)
  * [Deploying to OpenShift](#deploying-to-openshift)
  * [Deploying on Red Hat Product Demo System](#deploying-on-red-hat-product-demo-system)
* [Running the Workshop](#running-the-workshop)
* [Deleting the Workshop](#deleting-the-workshop)
* [Development](#development)

## Overview

This workshop covers two primary topics:

* Installing an Operator through the OpenShift web interface and using it to deploy and configure an etcd cluster.
* Creating a new Operator using the Operator SDK, including:
  * Defining a new Custom Resource Definition (CRD) the Operator will manage
  * Generating the scaffold code, using the SDK, for an Operator in Go
  * Deploying the Operator and testing it through the creation of a custom resource

| | |
--- | ---
| Audience Experience Level | Intermediate |
| Supported Number of Users | One per cluster [1] |
| Average Time to Complete | 45 minutes |

[1] It is possible for multiple users to share a cluster, but they won't have the full experience. The etcd Operator is installed cluster-wide. The first user to reach that point will be able to deploy the Operator; any other students will see the Operator as deployed. Each student, however, will still be able to complete the steps for deploying their own etcd cluster.

## Deploying the Workshop

### Deploying to OpenShift

**WARNING**
>This workshop grants the user cluster admin access. It also uses ``buildah`` inside of a container in the OpenShift cluster to build images. Using ``buildah`` in a container currently requires that it be run as ``root`` and inside of a ``privileged`` container.
>Because of the elevated access rights, only use this workshop on an expendable cluster which is going to be destroyed when the workshop is finished.

To deploy the workshop, first clone this Git repository to your own machine. Use the command:

```
git clone --recurse-submodules https://github.com/openshift-labs/lab-build-an-operator.git
```

The ``--recurse-submodules`` option ensures that Git submodules are checked out. If you forget to use this option, after having clone the repository, run:

```
git submodule update --recursive --remote
```

Next create a project in OpenShift into which the workshop is to be deployed.

```
oc new-project lab-operator
```

From within the top level of the Git repository, now run:

```
./.workshop/scripts/deploy-spawner.sh
```

The name of the pod used to start the workshop will be ``lab-build-an-operator-spawner``.

### Deploying on Red Hat Product Demo System

The workshop is found in the catalog under the *Workshops* folder and is named *OCP4 Workshop - Build an Operator*.

Once the cluster is deployed, follow the directions in the next section to begin the workshop itself.

## Running the Workshop

You can determine the hostname for the URL to access the workshop by running:

```
oc -n lab-operator get route lab-build-an-operator-spawner
```

When first accessing the workshop URL, the user may be presented with a warning about a potential security risk. This is due to the workshop using a self-signed certificate and users should be instructed to elect to continue to the site.

That URL leads to a login for the workshop itself.

![Workshop Login](/docs/jupyter-login.png)

Users will enter the following information:

| Key | Value |
| --- | ----- |
| Username | The user's e-mail address. This address is not saved anywhere outside of the workshop itself; it will not be used to follow up with the user. It simply acts as a unique identifier for the workshop instance. Logging into the site with a new username will cause a new instance of the workshop to be created (on the same cluster, however, so previously run cluster-wide operations will still be in effect. |
| Password | ``openshift`` |

After logging in, the workshop takes a few seconds to start:

![Workshop Startup](/docs/starting-up.png)

Once the workshop begins, users are presented with a two panel interface:

![Workshop Terminal](/docs/workshop-terminal.png)

On the left are the instructions users will follow for the workshop. The workshop itself explains how to use the interface, but generally speaking users will follow the directions on the left, with navigation buttons appearing at the end of each section. Text that is highlighted with a yellow background may be clicked to have the operation automatically executed in the cluster on the right.

By default, users are presented with the terminal, which contains (among other things) an authenticated ``oc`` client. The ``Console`` tab on the right can be clicked to open the OpenShift web console. Again, the user will already be authenticated; if a workshop requires users to change their logged in OpenShift user, the workshop instructions will specifically mention that.

![Workshop Console](/docs/workshop-console.png)

## Deleting the Workshop

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


## Development

The deployment created above will use an image from ``quay.io`` for this workshop based on the ``master`` branch of the repository.

To make changes to the workshop content and test them, edit the files in the Git repository and then run:

```
./.workshop/scripts/build-workshop.sh
```

This will replace the existing image used by the active deployment.

If you are running an existing instance of the workshop, if you want to start over with a fresh project, first delete the project used for the session.

```
oc delete project $PROJECT_NAMESPACE
```

Then select "Restart Workshop" from the menu top right of the workshop environment dashboard.

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
