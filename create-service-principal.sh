#!/bin/bash

# Create a Service Principal in Azure Cloud
# then Associate a ROLE and assign the ROLE to the
# Service Principal with the scope of RESOURCE GROUP.
#
# Prerequisites:
#   az cli
#   name of existing resource group
#

RG=${1:-example_rg_public}
spname=${2:-example-service-principal}
ROLE_NAME=${3:-ICP-K8S-PUBLIC}

az ad sp show --id "http://$spname"

aadClientSecret=$(az ad sp create-for-rbac --skip-assignment -n $spname -o json | jq -r .password)
aadClientId=$(az ad sp show --id "http://$spname" | grep objectId)

echo "aadClientId: $aadClientId aadClientSecret: $aadClientSecret"

# create the Role definition corresponsing to the ROLE NAME
az role definition create --role-definition ./role-definitions/icp-k8s-nopublic.json

# verify if role is assigned to Service Principal
az role assignment list --role "$ROLE_NAME" --resource-group "$RG" --assignee $aadClientId -o json

# create role to Service Principal , at the resource group scope
az role assignment create --role "$ROLE_NAME" --resource-group "$RG" --assignee-object-id $aadClientId
