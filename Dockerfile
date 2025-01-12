# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt update && apt upgrade -y
RUN apt install -y \
	screen \
	openocd \
	gdb-multiarch \
	vim \
	adb \
	acpica-tools \
	autoconf \
	automake \
	bc \
	bison \
	build-essential \
	ccache \
	cpio \
	cscope \
	curl \
	device-tree-compiler \
	e2tools \
	expect \
	fastboot \
	flex \
	ftp-upload \
	gdisk \
	git \
	libattr1-dev \
	libcap-ng-dev \
	libfdt-dev \
	libftdi-dev \
	libglib2.0-dev \
	libgmp3-dev \
	libhidapi-dev \
	libmpc-dev \
	libncurses5-dev \
	libpixman-1-dev \
	libslirp-dev \
	libssl-dev \
	libtool \
	libusb-1.0-0-dev \
	make \
	mtools \
	netcat \
	ninja-build \
	python3-cryptography \
	python3-pip \
	python3-pyelftools \
	python3-serial \
	python-is-python3 \
	rsync \
	swig \
	unzip \
	uuid-dev \
	wget \
	xdg-utils \
	xsltproc \
	xterm \
	xz-utils \
	zlib1g-dev \
	gcc-arm-linux-gnueabihf

# Clean up
RUN apt clean && rm -rf /var/lib/apt/lists/*

# Set a working directory
WORKDIR /workspace
