#!/bin/bash

usage() {
  echo "Usage: $0 KEYVAULT_NAME CERTIFICATE_NAME CONFIG_NAME"
  echo "Provisions a new secret called CERTIFICATE_NAME into KEYVAULT_NAME using Azure CLI credentials."
  echo "Use 'az login' to authenticate if you have not already done so."
  exit 1
}

if [[ -z "$1" || -z "$2" ]];then
  usage
fi

set -euo pipefail

keyvault_name="$1"
certificate_name="$2"
config_name="$3"

request_id=$(az rest -o json --method post \
  --url "https://${keyvault_name}.vault.azure.net/certificates/${certificate_name}/create?api-version=7.1" \
  --body @${config_name}.json --resource "https://vault.azure.net" \
  --query request_id --output tsv)

request_id=$(echo $request_id | tr -d '\n' | tr -d '\r')

certificate_creation_status_inprogress="inProgress"
certificate_creation_status_completed="completed"
certificate_creation_status=$certificate_creation_status_inprogress
timeout_seconds=600
current_time_seconds=0
check_interval_seconds=10

while [ $certificate_creation_status == $certificate_creation_status_inprogress ]
do
  echo "Wait for ${check_interval_seconds} seconds then check the status of the certificate creation."
  sleep $check_interval_seconds

  (( current_time_seconds = current_time_seconds + check_interval_seconds ))
  if [ $current_time_seconds -gt $timeout_seconds ]; then
    break;
  fi

  certificate_creation_status=$(az rest -o json --method get \
    --url "https://${keyvault_name}.vault.azure.net/certificates/${certificate_name}/pending?api-version=7.1&request_id=${request_id}" \
    --resource "https://vault.azure.net" \
    --query status --output tsv)

  certificate_creation_status=$(echo $certificate_creation_status | tr -d '\n' | tr -d '\r')

  echo "The certificate creation's current status is $certificate_creation_status";
done

if [ $certificate_creation_status == $certificate_creation_status_completed ]; then
  echo "The certificate creation is completed."
  exit 0
elif [ $certificate_creation_status == $certificate_creation_status_inprogress ]; then
  echo "The certificate creation failed because of timeout."
  exit 1
else
  echo "The certificate creation failed with status $certificate_creation_status."
  exit 2
fi