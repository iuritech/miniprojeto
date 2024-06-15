#!/bin/bash

# Variables
resourceGroupName="tp"
location="francecentral"  # Choose your preferred Azure region
storageAccountName="simoesstorage"  # Storage account names must be globally unique
containerName="mycontainer"

# Create a resource group
#az group create --name $resourceGroupName --location $location

# Create a storage account
az storage account create --name $storageAccountName --resource-group $resourceGroupName --location $location --sku Standard_ZRS

# Create a blob container
az storage container create --name $containerName --account-name $storageAccountName --auth-mode login

