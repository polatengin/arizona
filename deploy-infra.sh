is_logged_in=$(az account show 2>&1)
if [[ $is_logged_in == "ERROR:"* ]]; then
  echo "Please login to Azure CLI"
  exit 1
fi

resource_suffix=$(openssl rand -hex 4)

location="westus2"

az group create --name "rg-$resource_suffix" --location "$location" --output none

