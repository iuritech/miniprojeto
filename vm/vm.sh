RESOURCE_GROUP="tp"
VM_NAME="tonyVM"
USERNAME="tony"
PASSWORD="!Tonytectos!"

az vm delete --id /subscriptions/0f4dc1b5-0409-47fb-845c-5de7c20a4a4b/resourceGroups/TP/providers/Microsoft.Compute/virtualMachines/tonyVM
ssh-keygen -f "/home/simoes/.ssh/known_hosts" -R "40.89.151.56"

az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image Ubuntu2204 \
  --admin-username $USERNAME \
  --admin-password $PASSWORD \
  --custom-data cloud-init.yaml \
  --size Standard_B1s \

