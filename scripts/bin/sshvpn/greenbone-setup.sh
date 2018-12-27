#!/usr/bin/env bash

GVM_PATH="/usr/local/var/lib/gvm"

_CERT() {
  if [ ! -f "${GVM_PATH}/CA/clientcert.pem" ] || \
  [ ! -f "${GVM_PATH}/CA/cacert.pem" ] || \
  [ ! -f "${GVM_PATH}/private/CA/serverkey.pem" ] || \
  [ ! -f "${GVM_PATH}/CA/servercert.pem" ] || \
  [ ! -f "${GVM_PATH}/private/CA/clientkey.pem" ] || \
  [ ! -f "${GVM_PATH}/CA/clientcert.pem" ] ; then
    gvm-manage-certs -af
  fi
}

_ADMIN() {
  GVM_ADMIN="$(gvmd --get-users | grep -w admin)"
  if [ -z "${GVM_ADMIN}" ]; then
    gvmd --create-user=admin --role=Admin \
    && gvmd --user=admin --new-password=admin
  fi
}

_SYNC() {
  if [ "$(ls -A /usr/local/var/lib/openvas/plugins)" ]; then
    /usr/local/sbin/greenbone-nvt-sync --rsync
  else
    /usr/local/sbin/greenbone-nvt-sync --wget
  fi
  sleep 15
  greenbone-certdata-sync
  sleep 15
  greenbone-scapdata-sync
}

# _CERT
# _ADMIN
# _SYNC
