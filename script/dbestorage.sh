#!/bin/bash

# Set Variables
resourceGroupName="tp"
location="francecentral"

# Create a resource group
az group create --name $resourceGroupName --location $location


#blob
echo "creating sorage"
storageAccountName="simoesstorage"  # Storage account names must be globally unique
containerName="mycontainer"

# Create a storage account
az storage account create --name $storageAccountName --resource-group $resourceGroupName --location $location --sku Standard_ZRS --allow-blob-public-access true 

# Create a blob container
az storage container create --name $containerName --account-name $storageAccountName --auth-mode login --public-access blob


#database
echo "creating database"
accountName="simoes"
databaseName="tonytectosDB"
containerName="tonytectosContainer"
partitionKeyPath="/artigos"

# Create a Cosmos DB account
az cosmosdb create --name $accountName --resource-group $resourceGroupName --kind GlobalDocumentDB --default-consistency-level Eventual

# Create a database
az cosmosdb sql database create --account-name $accountName --resource-group $resourceGroupName --name $databaseName

# Create a container
az cosmosdb sql container create --account-name $accountName --resource-group $resourceGroupName --database-name $databaseName --name $containerName --partition-key-path $partitionKeyPath

az cosmosdb keys list -n simoes -g tp | grep primaryM
