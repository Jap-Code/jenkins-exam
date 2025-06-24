#!/bin/bash

DB_ENABLE=true
APP_ENABLE=false
NGINX_ENABLE=false

REPLICA_COUNT=1
IMAGE="postgres"
TAG="12.1-alpine"
IMAGE_PULL_POL="IfNotPresent"
TARGET_PORT=5432

SERVICE_PORT=5432
SERVICE_TYPE=ClusterIP

MOUNT_PATH=/var/lib/postgresql/data/

STORAGE_CLASS_NAME="local-path"

DB_USER="admin"
DB_PASSWORD="credential"


sed -e "s|__DB_ENABLE__|${DB_ENABLE}|g" \
    -e "s|__APP_ENABLE__|${APP_ENABLE}|g" \
    -e "s|__NGINX_ENABLE__|${NGINX_ENABLE}|g" \
    -e "s|__REPLICA_COUNT__|${REPLICA_COUNT}|g" \
    -e "s|__IMAGE__|${IMAGE}|g" \
    -e "s|__TAG__|${TAG}|g" \
    -e "s|__IMAGE_PULL_POL__|${IMAGE_PULL_POL}|g" \
    -e "s|__TARGET_PORT__|${TARGET_PORT}|g" \
    -e "s|__SERVICE_PORT__|${SERVICE_PORT}|g" \
    -e "s|__SERVICE_TYPE__|${SERVICE_TYPE}|g" \
    -e "s|__MOUNT_PATH__|${MOUNT_PATH}|g" \
    -e "s|__STORAGE_CLASS_NAME__|${STORAGE_CLASS_NAME}|g" \
    -e "s|__DB_USER__|${DB_USER}|g" \
    -e "s|__DB_PASSWORD__|${DB_PASSWORD}|g" \
    ./charts/values-template.yaml > values.yaml