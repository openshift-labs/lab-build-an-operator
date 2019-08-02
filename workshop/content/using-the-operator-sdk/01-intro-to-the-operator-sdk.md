As a user of a Kubernetes cluster, most of the time you would only be a consumer of existing operators which have been installed into the cluster. The primary use case would be to help you provision applications such as databases, or middleware products, including message queuing systems, rules management systems etc. A typical developer would never have a need to create their own operator.

If you do have a need to implement an operator to manage use of an application, perhaps as a way of making it easier for users to consume your own product, to make that task easier, you can use the [Operator SDK](https://github.com/operator-framework/operator-sdk). The Operator SDK supports the creation of operators using the Go programming language, Ansible, or by bundling up Helm charts into an operator.

In this part of the workshop you will use the Operator SDK to create an operator implemented in the Go programming language.

The benefit of using the Go Operator SDK is that it uses the controller-runtime library from the Kubernetes project, to make writing operators easier. The SDK provides:

* High level APIs and abstractions to write the operational logic more intuitively.
* Tools for scaffolding and code generation to bootstrap a new project quickly.
* Extensions to cover more common operator use cases.

The general steps for creating an operator using the SDK which you will be guided through are:

1. Creating a new operator project using the SDK CLI.
2. Creating a new Custom Resource Definition API Type using the SDK CLI.
3. Adding your Custom Resource Definition (CRD) to the Kubernetes cluster.
4. Defining the Spec and Status sections of the Custom Resource.
5. Creating a new Controller for your Custom Resource Definition API.
6. Writing the reconciliation logic for your Controller.
7. Running the operator to test your code against the Kubernetes cluster.
8. Using the SDK CLI to build and generate the operator Deployment manifests.
9. Optionally add additional APIs and Controllers using the SDK CLI.

The example operator you will creating implements a common pattern of operators which you saw in action with the `etcd` operator. That is, the creation and management of a set of pods, and scaling the number of pods.
