#!/usr/bin/env bash

# Generates Self signed HTTPs certificates for Traefik.
set -e
PROJ_FOLDER=$(dirname $(readlink -f $0))
PROJ_FOLDER=$(dirname $PROJ_FOLDER)

TARGET_PATH=$PROJ_FOLDER/cert

# Set our variables
CA_KEY_PATH="$TARGET_PATH/ca.key"
CA_CERT_PATH="$TARGET_PATH/ca.crt"
SERVER_KEY_PATH="$TARGET_PATH/server.key"
SERVER_CERT_PATH="$TARGET_PATH/server.crt"


if [ -f "$SERVER_CERT_PATH" ]; then
  read -p "A server certificate already exists. Do you want to overwrite it? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      exit 1
  fi
fi

[ -z "$CERT_EMAIL" ] && CERT_EMAIL=$(git config user.email)
[ -z "$CERT_EMAIL" ] && echo "CERT_EMAIL was not supplied and could not be grabbed from git" && exit 1

# Generate the CA certificate
cat <<EOF > ca.cnf
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_ca
prompt = no
[req_distinguished_name]
C = DE
ST = HE
OU = H
CN = Traefik Local CA
localityName = Traefik Local CA
commonName = Traefik Local CA
emailAddress = $CERT_EMAIL
[v3_ca]
subjectKeyIdentifier = hash
basicConstraints = CA:TRUE
EOF

echo "Generating CA certificate..."
openssl genrsa -out "$CA_KEY_PATH" 2048
openssl req -x509 -new -nodes -key "$CA_KEY_PATH" -sha256 -days 3650 -out "$CA_CERT_PATH" -config ca.cnf
rm ca.cnf

# Generate the server certificate
cat <<EOF > server.cnf
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no
[req_distinguished_name]
C = DE
ST = HE
OU = H
CN = Traefik Local Server
localityName = Traefik Local Server
commonName = Traeifk Local Server
emailAddress = $CERT_EMAIL
[v3_req]
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
basicConstraints = CA:FALSE
[alt_names]
DNS.1   = $DOMAINNAME
DNS.2   = *.docker.localhost
EOF

echo "Generating server certificate..."
openssl genrsa -out "$SERVER_KEY_PATH" 2048
openssl req -new -key "$SERVER_KEY_PATH" -out server.csr -config server.cnf
openssl x509 -req -in server.csr -CA "$CA_CERT_PATH" -CAkey "$CA_KEY_PATH" \
  -CAcreateserial -out "$SERVER_CERT_PATH" -days 3650 -sha256 -extfile server.cnf -extensions v3_req
rm server.csr server.cnf

echo "Server certificate generated successfully!"
