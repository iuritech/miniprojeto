#!/bin/bash

# Set Variables
resourceGroupName="tp"
location="francecentral"
FUNCTION_NAME="tonytectosFunction"
STORAGE_NAME="simoesstorage"
GITHUB_REPO_URL="git@github.com:iuritech/function.git"
GITHUB_TOKEN="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"

az functionapp create --resource-group $resourceGroupName --consumption-plan-location $location --runtime node --functions-version 4 --name $FUNCTION_NAME --storage-account $STORAGE_NAME

az functionapp deployment source config --name $FUNCTION_NAME --resource-group $resourceGroupName --repo-url $GITHUB_REPO_URL --branch main --manual-integration


# # Create App Service Plan
# az appservice plan create --name "${WEB_APP_NAME}-plan" --resource-group $resourceGroupName --sku B1 --is-linux

# # Create Web App
# az webapp create --resource-group $resourceGroupName --plan "${WEB_APP_NAME}-plan" --name $WEB_APP_NAME --runtime "NODE:20-lts"

