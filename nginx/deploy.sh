#!/bin/bash

DB_ENABLE=false
APP_ENABLE=false
NGINX_ENABLE=true


REPLICA_COUNT=1
IMAGE="${DOCKER_ID}/${RELEASE}"
TAG="${DOCKER_TAG}"
IMAGE_PULL_POL="IfNotPresent"
TARGET_PORT=8080

SERVICE_PORT=8080
SERVICE_TYPE=NodePort

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
    ./charts/values-template.yaml > values.yaml