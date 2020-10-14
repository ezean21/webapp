#!/usr/bin/env bash

set -e
set -x

TAG=$1
DEBUG=$2
REALEASE_NAME="webapp"
COMMAND="install"
GREEN_ENABLED_KEY="global.slot.green.enabled"
BLUE_ENABLED_KEY="global.slot.blue.enabled"
GREEN_ENABLED="true"
BLUE_ENABLED="false"
NEWSLOT="blue"
ARGS="--set global.slot.blue.tag=${TAG} --set global.slot.green.tag=${TAG}"



[[ -z "${TAG}" ]] && { echo "Error: value not found in TAG"; exit 1; }


if [ $(helm list | awk '{print $1}' | tail -1) == "webapp" ];then

  COMMAND="upgrade"

  GREEN_ENABLED=$(helm get values ${REALEASE_NAME} -o json | jq -r ".${GREEN_ENABLED_KEY}")
  BLUE_ENABLED=$(helm get values ${REALEASE_NAME} -o json | jq -r ".${BLUE_ENABLED_KEY}")
  [[ "${BLUE_ENABLED}" == "true" ]] && NEWSLOT="green"

  ARGS="--reuse-values --set global.slot.${NEWSLOT}.tag=${TAG}"

fi


helm ${COMMAND} webapp . --version ${TAG} \
                         --wait \
                         --set ${BLUE_ENABLED_KEY}=${GREEN_ENABLED} \
                         --set ${GREEN_ENABLED_KEY}=${BLUE_ENABLED} \
                         ${ARGS} \
                         "${@: 2}"

