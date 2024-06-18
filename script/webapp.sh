#!/bin/bash

# Set Variables
resourceGroupName="tp"
location="francecentral"
WEB_APP_NAME="tonytectos"
GITHUB_REPO_URL="git@github.com:iuritech/tonytectos.git"
BRANCH="main"
GITHUB_TOKEN="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"

# Create Resource Group
#az group create --name $resourceGroupName --location $location

# Create App Service Plan
az appservice plan create --name "${WEB_APP_NAME}-plan" --resource-group $resourceGroupName --sku free --is-linux

# Create Web App
az webapp create --resource-group $resourceGroupName --plan "${WEB_APP_NAME}-plan" --name $WEB_APP_NAME --runtime "NODE:20-lts"

