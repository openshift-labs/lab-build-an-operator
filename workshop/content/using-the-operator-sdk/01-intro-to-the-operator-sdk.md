As a user of an OpenShift cluster, most of the time you will only be a consumer of existing Operators which have been installed into the cluster. The primary use case involve helping you provision applications such as databases or middleware products, including message queuing systems, rules management systems etc. A typical developer looking to use these services should never have a need to create their own Operator.

If you do have a need to implement an Operator to manage use of an application, perhaps as a way of making it easier for users to consume your own product, to make that task easier you can use the [Operator SDK](https://github.com/operator-framework/operator-sdk). The Operator SDK can be installed on your own development system and supports the creation of operators using the Go programming language, Ansible, or by bundling up Helm charts into an Operator.

In this part of the workshop you will use the Operator SDK to create an Operator implemented in the Go programming language.

The benefit of using the Operator SDK's Go support is that it uses the controller-runtime library from the Kubernetes project, to make writing operators easier. The SDK provides:

* High level APIs and abstractions to write the operational logic more intuitively.
* Tools for scaffolding and code generation to bootstrap a new project quickly.
* Extensions to cover more common Operator use cases.

The general steps for creating an Operator using the SDK which you will be guided through are:

1. Creating a new Operator project using the SDK CLI.
2. Creating a new Custom Resource Definition using the SDK CLI.
3. Defining the Spec and Status sections of the custom resource type.
4. Adding your Custom Resource Definition (CRD) to the Kubernetes cluster.
5. Creating a new Kubernetes controller to handle your custom resources.
6. Writing the reconciliation logic for your controller.
7. Running the Operator to test your code against the Kubernetes cluster.
8. Using the SDK CLI to build and generate the operator deployment manifests.

The example Operator you will be creating implements a common pattern of Operators. That is, the creation and management of a set of pods, and scaling the number of pods.
