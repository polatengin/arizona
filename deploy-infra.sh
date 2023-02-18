is_logged_in=$(az account show 2>&1)
if [[ $is_logged_in == "ERROR:"* ]]; then
  echo "Please login to Azure CLI"
  exit 1
fi
