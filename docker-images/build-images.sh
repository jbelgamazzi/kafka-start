#!/bin/bash

set -eo pipefail

#
# Parameter 1: image name
# Parameter 2: path to component (if different)
#
build_docker_image () {
    IMAGE_NAME=$1;
    IMAGE_PATH=$2;

    if [ -z "$IMAGE_PATH" ]; then
        IMAGE_PATH=${IMAGE_NAME};
    fi

    # IMAGE_PATH="${IMAGE_PATH}/${IMAGE_VERSION}"

    echo ""
    echo "****************************************************************"
    echo "** Validating  kafka-start/${IMAGE_NAME}"
    echo "****************************************************************"
    echo ""
    docker run --rm -i hadolint/hadolint:latest < "${IMAGE_PATH}"

    echo "****************************************************************"
    echo "** Building    kafka-start/${IMAGE_NAME}:${IMAGE_VERSION}"
    echo "****************************************************************"
    docker build -t "kafka-start/${IMAGE_NAME}:latest" "${IMAGE_PATH}"

    # echo "****************************************************************"
    # echo "** Tag         kafka-start/${IMAGE_NAME}:${IMAGE_VERSION}"
    # echo "****************************************************************"
    # docker tag "kafka-start/${IMAGE_NAME}:latest" "kafka-start/${IMAGE_NAME}:${IMAGE_VERSION}"
}


if [[ -z "$1" ]]; then
    echo ""
    echo "A version must be specified."
    echo ""
    echo "Usage:  build-images <version>";
    echo ""
    exit 1;
fi

IMAGE_VERSION="$1"

build_docker_image zookeeper
build_docker_image kafka
build_docker_image connect-base
build_docker_image connect-jdbc
build_docker_image use-case-mysql-customerdb        use-cases/mysql/customerdb
build_docker_image use-case-mysql-configurationdb   use-cases/mysql/configurationdb
build_docker_image use-case-mysql-safe-adm          use-cases/mysql/safe_adm
echo ""
echo "**********************************"
echo "Successfully created Docker images"
echo "**********************************"
echo ""
