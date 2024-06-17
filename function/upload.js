const { BlobServiceClient } = require('@azure/storage-blob');
const fs = require('fs');
const path = require('path');
const Jimp = require('jimp');

// Azure Storage account connection string
const AZURE_STORAGE_CONNECTION_STRING = 'DefaultEndpointsProtocol=https;AccountName=simoesstorage;AccountKey=G/nBkvimIeDH7RTS0l9wh3oz1ylk8xsH6SDEvoL9l53oWlDUkPfJUj9lW+tcr8JF42Wna/GtIT4d+AStvEzTTA==;EndpointSuffix=core.windows.net';

// Initialize the BlobServiceClient
const blobServiceClient = BlobServiceClient.fromConnectionString(AZURE_STORAGE_CONNECTION_STRING);

// Name of the container
const containerName = 'mycontainer';

// Get the container client
const containerClient = blobServiceClient.getContainerClient(containerName);

// Local directory containing photos
const localDirectory = path.join(__dirname, 'fotos');  // __dirname refers to the directory where the script is located

// Function to upload a file to Azure Blob Storage
async function uploadFile(filePath, blobName) {
  const blockBlobClient = containerClient.getBlockBlobClient(blobName);
  console.log(`Uploading ${blobName} to Azure Blob Storage...`);
  const data = fs.readFileSync(filePath);
  await blockBlobClient.upload(data, data.length);
  console.log(`${blobName} uploaded successfully!`);
}

// Function to create a thumbnail and upload it
async function createAndUploadThumbnail(filePath, originalBlobName) {
  const thumbnailBlobName = `thumbnail_${originalBlobName}`;
  const thumbnailPath = path.join(path.dirname(filePath), `thumbnail_${path.basename(filePath)}`);

  // Create a thumbnail using Jimp
  const image = await Jimp.read(filePath);
  await image.resize(500, 300).writeAsync(thumbnailPath);

  // Upload the thumbnail
  await uploadFile(thumbnailPath, thumbnailBlobName);

  // Remove the local thumbnail file after upload
  fs.unlinkSync(thumbnailPath);
}

// Read files from the local directory and upload them
fs.readdir(localDirectory, (err, files) => {
  if (err) {
    return console.error(`Unable to scan directory: ${err}`);
  }
  files.forEach(file => {
    const filePath = path.join(localDirectory, file);
    const blobName = file;
    if (file.endsWith('.png') || file.endsWith('.jpg') || file.endsWith('.jpeg') || file.endsWith('.ico')) {
      uploadFile(filePath, blobName)
        .then(() => createAndUploadThumbnail(filePath, blobName))
        .catch(err => console.error(`Error uploading ${blobName}: ${err.message}`));
    }
  });
});

