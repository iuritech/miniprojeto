# Variables
resourceGroupName="tp"
location="francecentral"
accountName="simoes"
databaseName="tonytectosDB"
containerName="tonytectosContainer"
partitionKeyPath="/artigos"

# Create a resource group
az group create --name $resourceGroupName --location $location

# Create a Cosmos DB account
az cosmosdb create --name $accountName --resource-group $resourceGroupName --kind GlobalDocumentDB --default-consistency-level Eventual

# Create a database
az cosmosdb sql database create --account-name $accountName --resource-group $resourceGroupName --name $databaseName

# Create a container
az cosmosdb sql container create --account-name $accountName --resource-group $resourceGroupName --database-name $databaseName --name $containerName --partition-key-path $partitionKeyPath
