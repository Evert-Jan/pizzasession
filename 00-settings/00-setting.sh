az login
az account list --output table

az account show
az account set --subscription Eduarte_Team_RockCity

az account set --subscription bb09eaf3-5f0a-4389-b983-07bb6c49aaad

az account set --subscription Eduarte_Team_RockCity

az account set --subscription 'Iddink Eduarte - ETAP'

az account set --subscription Eduarte_Team_RockCity


********   Creating things      *************
az group create --name ejl01 --location westeurope

az keyvault create --location westeurope --name pizzasession --resource-group ejl01

az keyvault certificate create --vault-name pizzasession -n cert1  -p "$(az keyvault certificate get-default-policy)" 
secrets=$(az keyvault secret list-versions --vault-name pizzasession -n cert1 --query "[?attributes.enabled].id" -o json)
vm_secrets=$(az vm secret format -s "$secrets")

az keyvault update --name pizzasession --enabled-for-deployment true

az vm create -g ejl01 -n ejl01_vm --admin-username ejl --image UbuntuLTS --secrets "$vm_secrets"
az vm create -g ejl01 -n ejl02_vm --admin-username ejl --image UbuntuLTS --secrets "$vm_secrets"


az vm create -g ejl01 -n ejl02_vm --admin-username ejl --image UbuntuLTS --secrets "$vm_secrets"

az vm delete --name ejl03_vm -r ejl01