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

To see the contents of the generated project directory, run:

```execute
ls
```

The purposes of the directories are as follows.

`cmd` - Contains the file `manager/main.go`, which is the main program of the operator. This instantiates a new manager which registers all custom resource definitions under the directory `pkg/apis/...` and starts all controllers under the directory `pkg/controllers/...`.

`pkg/apis` - The directory tree containing the files that specify the APIs of the Custom Resources. For each custom resource (`kind`), it is necessary to edit the `pkg/apis/<group>/<version>/<kind>_types.go` file to define the API. These will be imported into their respective controllers to watch for changes in these resource types.

`pkg/controller` - Contains the implementation of the controllers. For each custom resource, is it necessary to edit the `pkg/controller/<kind>/<kind>_controller.go` file to define the controller's reconcile logic for handling that resource type.

`build` - Contains the `Dockerfile` and build scripts used to build the operator.

`deploy` - Contains the YAML manifests for registering the custom resources, setting up any special role base access control (RBAC) access as required by the operator, and deploying the operator.

`vendor` - The vendor folder that contains the local copies of any external dependencies that satisfy the imports of this project.
