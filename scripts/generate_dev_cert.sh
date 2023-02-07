#!/usr/bin/env bash

# Generates Self signed HTTPs certificates for Traefik.

DOMAIN=*.docker.localhost

PROJ_FOLDER=$(dirname $(readlink -f $0))
PROJ_FOLDER=$(dirname $PROJ_FOLDER)

target_path=./cert

KEY_PATH=$target_path/traefik.key
CERT_PATH=$target_path/traefik.crt

if [ -f "$KEY_PATH" ]; then
  read -p "Are you sure to overwrite your already existing Cert?" -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      exit 1
  fi
fi

[ -z "$CERT_EMAIL" ] && CERT_EMAIL=$(git config user.email)
[ -z "$CERT_EMAIL" ] && echo "CERT_EMAIL was not supplied and could not be grabbed from git" && exit 1

# Set our variables
cat <<EOF > req.cnf
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no
[req_distinguished_name]
C = DE
ST = HE
OU = H
CN = localhost
localityName = $DOMAIN
commonName = $DOMAIN
organizationalUnitName = home
emailAddress = $CERT_EMAIL
[v3_req]
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
basicConstraints = CA:false
[alt_names]
DNS.1   = $DOMAIN
DNS.2   = *.local
DNS.3   = *.lan
DNS.4   = localhost
DNS.5   = *.jk.wetech.local
EOF
# Generate our Private Key, and Certificate directly
openssl req -x509 -nodes -days 500 -newkey rsa:2048 \
  -keyout "$KEY_PATH" -config req.cnf \
  -out "$CERT_PATH" -sha256
rm req.cnf
