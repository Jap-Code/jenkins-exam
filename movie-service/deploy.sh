#!/bin/bash

DB_ENABLE=false
APP_ENABLE=true
NGINX_ENABLE=false


REPLICA_COUNT=1
IMAGE="${DOCKER_ID}/${RELEASE}"
TAG="${DOCKER_TAG}"
IMAGE_PULL_POL="IfNotPresent"
TARGET_PORT=8000

SERVICE_PORT=8000
SERVICE_TYPE=ClusterIP

DB_USER="admin"
DB_PASSWORD="credential"
DATABASE_URI="postgresql://${DB_USER}:${DB_PASSWORD}@${RELEASE}-db-service/${RELEASE}-db"


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
    -e "s|__DB_USER__|${DB_USER}|g" \
    -e "s|__DB_PASSWORD__|${DB_PASSWORD}|g" \
    -e "s|__DATABASE_URI__|${DATABASE_URI}|g" \
    ./charts/values-template.yaml > values.yaml