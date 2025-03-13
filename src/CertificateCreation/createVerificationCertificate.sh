#!/bin/bash
usage() {
 echo "Usage: $0 VERIFICATION_CODE KEYVAULT_NAME CA_CERT_NAME"
 echo "Generates a leaf certificate for the provided validation code by downloading CA key material from Key Vault."
 exit 1
}

if [[ -z "$1" || -z "$2" || -z "$3" ]];then
 usage
fi

set -euo pipefail

VERIFICATION_CODE="$1"
KEY_VAULT_NAME="$2"
CA_CERTIFICATE_NAME="$3"

KEY="${VERIFICATION_CODE}.key.pem"
CSR="${VERIFICATION_CODE}.csr.pem"
CERT="${VERIFICATION_CODE}.cert.pem"

# generate CSR for verification code
openssl req -newkey rsa:4096 -subj "/CN=${VERIFICATION_CODE}" -keyout /dev/null -nodes -out "$CSR"

sign_it() {
 # OpenSSL will consume all stdin for a given parameter; we need to pass both CA and CA key
 # Buffer the stdin (combo cert+key PEM) in a variable, so we can re-use it later
 output=$(cat -)

 # OpenSSL expects files (not stdin) for its CA* arguments. Leverage process
 # substitution to avoid writing that data to disk, and play back the captured
 # stdin twice. OpenSSL reads through input until it finds what its looking for
 # so passing combo cert+key to both is fine.
 openssl x509 -req -in "$CSR" -CA <(echo -n "$output") -CAkey <(echo -n "$output") -set_serial 01 -out "$CERT" -days 1 -sha256 \
 -extfile <(printf 'basicConstraints=CA:FALSE\nsubjectKeyIdentifier=hash\nauthorityKeyIdentifier=keyid,issuer\nkeyUsage=critical,nonRepudiation,digitalSignature,keyEncipherment\nextendedKeyUsage=clientAuth,emailProtection')

 echo "Proof of possession for verification code '${VERIFICATION_CODE}' was written to '${CERT}'."
}

# Use process substitution to prevent private key being written out to disk or appearing on command line
az keyvault secret download --file >(sign_it) --encoding ascii --vault-name "$KEY_VAULT_NAME" --name "$CA_CERTIFICATE_NAME"