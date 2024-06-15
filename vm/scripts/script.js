require('dotenv').config();
const { CosmosClient } = require('@azure/cosmos');
const fs = require('fs');

async function uploadData() {
  try {
    // Provide required connection from environment variables in the .env file
    const key = process.env.COSMOS_KEY;
    const endpoint = "https://simoes.documents.azure.com:443/";

    if (!key || !endpoint) {
      throw new Error('Cosmos DB endpoint and key must be provided in environment variables');
    }

    console.log(`Using the endpoint: ${endpoint}`);

    // Authenticate to Azure Cosmos DB
    const cosmosClient = new CosmosClient({ endpoint, key });

    // Get the database object
    const db = cosmosClient.database('tonytectosDB');

    // Get the container object
    const container = db.container('tonytectosContainer');

    // Read data from JSON file
    const data = JSON.parse(fs.readFileSync('data.json', 'utf8'));

    // Upload data to Cosmos DB
    for (const item of data) {
      const { resource: createdItem } = await container.items.create(item);
      console.log(`Created item with id: ${createdItem.id}`);
    }

    console.log('Data upload completed.');
  } catch (err) {
    console.error('Error uploading data to Cosmos DB', err);
  }
}

uploadData();

