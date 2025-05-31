#!/bin/bash

# File: docker_control.sh

IMAGE_NAME="dev-container:latest"
CONTAINER_NAME="dev-container-instance"
SOURCE_CODE_PATH="/home/rahulrajesh/tee-project/src"
TARGET_PATH="/home/user/"

bring_up_container() {
    echo "Checking for existing container..."
    if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Container ${CONTAINER_NAME} already exists. attaching shell..."
	docker start ${CONTAINER_NAME}
        docker exec -it ${CONTAINER_NAME} bash
    else
        echo "Starting a new container..."
        docker run -it \
            --name ${CONTAINER_NAME} \
            --mount type=bind,source=/dev,target=/dev \
            --mount type=bind,source="${SOURCE_CODE_PATH}",target="${TARGET_PATH}" \
            --device-cgroup-rule "c 188:* rwm" \
            --device-cgroup-rule "c 189:* rwm" \
            ${IMAGE_NAME}
    fi
}

bring_up_container_mnt() {
    echo "Checking for existing container..."
    if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Container ${CONTAINER_NAME} already exists. attaching shell..."
	docker start ${CONTAINER_NAME}
        docker exec -it ${CONTAINER_NAME} bash
    else
        echo "Starting a new container..."
        docker run -it \
            --name ${CONTAINER_NAME} \
            --mount type=bind,source=/dev,target=/dev \
            --mount type=bind,source=/mnt,target=/mnt \
            --mount type=bind,source="${SOURCE_CODE_PATH}",target="${TARGET_PATH}" \
            --device-cgroup-rule "c 188:* rwm" \
            --device-cgroup-rule "c 189:* rwm" \
            ${IMAGE_NAME}
    fi
}

new_bash_shell() {
	if docker ps --filter="name=${CONTAINER_NAME}" >/dev/null 2>&1; then
		echo "Container $CONTAINER_NAME already running. Spawning new bash shell..."
		docker exec -it $CONTAINER_NAME bash
	fi
}

build_image() {
	docker build -t $IMAGE_NAME .
}

case "$1" in
	up)
		bring_up_container
		;;
	up-mnt)
		bring_up_container_mnt
		;;
	sh)
		new_bash_shell
		;;
	build)
		build_image
		;;
	*)
		echo "Usage: $0 {up | up-mnt | sh | build | (more to come ... )}"
		exit 1
		;;
esac

