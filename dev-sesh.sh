#!/bin/bash

# File: docker_control.sh

IMAGE_NAME="dev-container:latest"
CONTAINER_NAME="dev-container-instance"
SOURCE_CODE_PATH="/home/rahulrajesh/tee-project/src"

start_docker_daemon() {
	echo "Starting Docker daemon..."
	sudo systemctl start docker
}

stop_docker_daemon() {
	echo "Stopping Docker daemon..."
	sudo systemctl stop docker.socket;
	sudo systemctl stop docker.service;
}

bring_up_container() {
	echo "Starting a new container..."
	docker run --rm -it \
		--name $CONTAINER_NAME \
		--mount type=bind,source=/dev,target=/dev \
		--mount type=bind,source=${SOURCE_CODE_PATH},target=/workspace \
		--device-cgroup-rule "c 188:* rwm" \
		--device-cgroup-rule "c 189:* rwm" \
		$IMAGE_NAME
}

case "$1" in
	up)
		start_docker_daemon
		bring_up_container
		;;
	*)
		echo "Usage: $0 {up|(more to come ... )}"
		exit 1
		;;
esac

