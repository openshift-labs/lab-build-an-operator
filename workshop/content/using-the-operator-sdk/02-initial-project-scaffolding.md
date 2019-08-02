The Operator SDK client tools have already been installed for you. The command line client is called `operator-sdk`.

To see what type of operation the Operator SDK command line client supports run:

```execute
operator-sdk --help
```

The first step you need to do in creating your operator is to generate the initial project scaffolding. Do this by running:

```execute
operator-sdk new podset-operator --type=go --skip-git-init
```

We are using the project directory `podset-operator` to generate the project. Change to that directory as subsequent steps must be run from that directory.

```execute
cd podset-operator
```

Run:

```execute
ls
```

to see the contents of the generated project directory.

The primary directories and files that the `operator-sdk new` command generates are:


| Directory      | Purpose |
| :---           | :--- |
| cmd       | Contains `manager/main.go` which is the main program of the operator. This instantiates a new manager which registers all custom resource definitions under `pkg/apis/...` and starts all controllers under `pkg/controllers/...`  . |
| pkg/apis | Contains the directory tree that defines the APIs of the Custom Resource Definitions(CRD). Users are expected to edit the `pkg/apis/<group>/<version>/<kind>_types.go` files to define the API for each resource type and import these packages in their controllers to watch for these resource types.|
| pkg/controller | This pkg contains the controller implementations. Users are expected to edit the `pkg/controller/<kind>/<kind>_controller.go` to define the controller's reconcile logic for handling a resource type of the specified `kind`. |
| build | Contains the `Dockerfile` and build scripts used to build the operator. |
| deploy | Contains various YAML manifests for registering CRDs, setting up [RBAC][RBAC], and deploying the operator as a Deployment.
| vendor | The golang vendor folder that contains the local copies of the external dependencies that satisfy the imports of this project. |
