#!/bin/bash

set -x
set -eo pipefail

WORKSHOP_NAME=lab-build-an-operator
SPAWNER_APPLICATION=${SPAWNER_APPLICATION:-$WORKSHOP_NAME}
SPAWNER_NAMESPACE=`oc project --short`

APPLICATION_LABELS="app=$SPAWNER_APPLICATION-$SPAWNER_NAMESPACE,spawner=learning-portal"

PROJECT_RESOURCES="services,routes,deploymentconfigs,imagestreams,secrets,configmaps,serviceaccounts,rolebindings,serviceaccounts,rolebindings,persistentvolumeclaims,pods"

oc delete "$PROJECT_RESOURCES" --selector "$APPLICATION_LABELS"

CLUSTER_RESOURCES="clusterrolebindings,clusterroles"

oc delete "$CLUSTER_RESOURCES" --selector "$APPLICATION_LABELS"
