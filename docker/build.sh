#!/usr/bin/env bash

set -e

TAG=$1

[[ -z "${TAG}" ]] && { echo "Error: value not found in TAG"; exit 1; }

docker build -t app:${TAG} -f ./app/Dockerfile ./app/
docker build -t nginx:${TAG} -f ./nginx/Dockerfile ./nginx/