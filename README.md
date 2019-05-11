# azure-examples

1. before creating the role definition, replace `<SUBSCRIPTIONID>` with your subscription id value in the role-definition/*.json file.

# verification

* verify ICP cluster creation in Azure with the minimal priviledge Service Principal
* verify ICP cluster creation with second Service Principal w/o public address access

# procedure

1. create resource group
2. create service principal associated to the resource group
3. install ICP into the resource group, passing in the service principal credentials

# Attribution

This work is made possible by the work presented here: https://github.com/jsturtevant/aks-examples
