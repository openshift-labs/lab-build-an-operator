Before you can start creating instances of your custom resource type and run an Operator which handles them, you need to load the CRD for the custom resource into the cluster.

To load the CRD, run:

```execute
oc apply -f deploy/crds/app_v1alpha1_podset_crd.yaml
```

You can load the CRD because in this workshop environment you are a cluster admin. In your own cluster, if you are not a cluster admin, you would need to request a cluster admin to do it.

To verify that the CRD has been loaded run:

```execute
oc describe crd/podsets.app.example.com
```

This will display details about the custom resource type defined by the CRD. To perform queries against the schema, you can use `oc explain`.

To see the custom attributes added to the `spec` for the custom resource, run:

```execute
oc explain podset.spec
```

At the moment, no descriptions have been provided for the custom attributes, so only information about the type of the attributes will be shown.

To check that you can now create instances of the `PodSet` resource, run:

```execute
oc auth can-i create podset
```

It should respond with "yes".

This will work because you are a cluster admin in this workshop environment, and can create resources of any type.

After the Operator is deployed to a project namespace, if users who are not cluster admins need to be able to create instances of the new `PodSet` resource type, it will be necessary to create a cluster role which describes that right, as well as a role binding against the users or group of users who need it.

The cluster role for being able to work with the `PodSet` resource would be:

```
apiVersion: authorization.openshift.io/v1
kind: ClusterRole
metadata:
  name: podset-operator-user
rules:
- apiGroups:
  - "app.example.com"
  resources:
  - podsets
  verbs:
  - get
  - list
  - watch
  - create
  - delete
  - patch
  - update
```

You would use the `oc adm policy add-cluster-role-to-user` command to bind the role to the users requiring it.
