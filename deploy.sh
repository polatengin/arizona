is_logged_in=$(az account show 2>&1)
if [[ $is_logged_in == "ERROR:"* ]]; then
  echo "Please login to Azure CLI"
  exit 1
fi

RESOURCE_SUFFIX=$(openssl rand -hex 4)
LOCATION="westus2"

az group create --name "rg-arizona-${RESOURCE_SUFFIX}" --location "${LOCATION}" --output none

az staticwebapp create \
  --name "swa-${RESOURCE_SUFFIX}" \
  --resource-group "rg-arizona-${RESOURCE_SUFFIX}" \
  --source https://github.com/polatengin/arizona \
  --location "${LOCATION}" \
  --branch "main" \
  --app-location "src" \
  --login-with-github \
  --output none

echo "https://$(az staticwebapp show --name "swa-${RESOURCE_SUFFIX}" --resource-group "rg-arizona-${RESOURCE_SUFFIX}" --query "defaultHostname" --output tsv)"
