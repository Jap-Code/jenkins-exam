#!/bin/bash

DB_ENABLE="true"
APP_ENABLE="false"

REPLICA_COUNT=1
IMAGE="postgres"
TAG="12.1-apline"
IMAGE_PULL_POL="IfNotPresent"
CONT_PORT=80

SERVICE_PORT=80
SERVICE_TYPE=NodePort

MOUNT_PATH=/var/lib/postgresql/data/

PVC_EN="true"
STORAGE_CLASS_NAME="local-db-storage"

DB_USER="admin"
DB_PASSWORD="NoLimit"

sed -e "s|__DB_ENABLE__|${DB_ENABLE}|g" \
    -e "s|__APP_ENABLE__|${APP_ENABLE}|g" \
    -e "s|__REPLICA_COUNT__|${REPLICA_COUNT}|g" \
    -e "s|__IMAGE__|${IMAGE}|g" \
    -e "s|__TAG__|${TAG}|g" \
    -e "s|__IMAGE_PULL_POL__|${IMAGE_PULL_POL}|g" \
    -e "s|__CONT_PORT__|${CONT_PORT}|g" \
    -e "s|__SERVICE_PORT__|${SERVICE_PORT}|g" \
    -e "s|__SERVICE_TYPE__|${SERVICE_TYPE}|g" \
    -e "s|__MOUNT_PATH__|${MOUNT_PATH}|g" \
    -e "s|__PVC_EN__|${PVC_EN}|g" \
    -e "s|__STORAGE_CLASS_NAME__|${STORAGE_CLASS_NAME}|g" \
    -e "s|__DB_USER__|${DB_USER}|g" \
    -e "s|__DB_PASSWORD__|${DB_PASSWORD}|g" \
    values-template.yaml > values.yaml