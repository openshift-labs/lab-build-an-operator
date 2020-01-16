The Operator SDK client tools have already been installed for you. The command line client is called `operator-sdk`.

To see what type of operations the Operator SDK command line client supports run:

```execute
operator-sdk --help
```

The first step you need to do in creating your Operator is to generate the initial project scaffolding. Do this by running:

```execute
operator-sdk new podset-operator --type=go --skip-git-init
```

The scaffold command creates a new directory named `podset-operator` with the project files. Change to that directory as subsequent steps must be run from that directory.

```execute
cd podset-operator
```

To see the contents of the generated project directory, run:

```execute
ls -las
```

The purposes of the directories are as follows.

`cmd` - Contains the file `manager/main.go`, which is the main program of the Operator. This instantiates a new manager which registers all custom resource definitions under the directory `pkg/apis/...` and starts all controllers under the directory `pkg/controllers/...`. You won't need to edit this file beyond what is generated.

`pkg/apis` - The directory tree containing the files that specify the APIs of the custom resources. For each custom resource (`kind`), it is necessary to edit the `pkg/apis/<group>/<version>/<kind>_types.go` file to define the API. These will be imported into their respective controllers to watch for changes in these resource types.

`pkg/controller` - Contains the implementation of the controllers. For each custom resource, it is necessary to edit the `pkg/controller/<kind>/<kind>_controller.go` file to define the controller's reconciliation logic for handling that resource type.

`build` - Contains the `Dockerfile` and build scripts used to build the Operator. You won't need to edit any files in this directory.

`deploy` - Contains the YAML manifests for registering the custom resources definitions, setting up any special role base access control (RBAC) access as required by the Operator, and deploying the Operator pod itself.

`vendor` - The vendor folder that contains the local copies of any external dependencies that satisfy the imports of this project. You won't need to manually edit any of these files.

Note that when generating the scaffolding for an Operator, you can specify whether the Operator should be configured to only monitor a single namespace, or all namespaces in a cluster.

In this example Operator, the default of monitoring a single namespace only will be used. Such an Operator usually needs to be installed separately into each namespace that needs monitoring.

If you need to implement an Operator which can be installed once, and monitor all namespaces, you can supply the `--cluster-scoped` option to `operator-sdk new` when run.
