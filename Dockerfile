FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
	screen \
	openocd \
	gdb-multiarch \
	vim \
	neovim \
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
	git-email \
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

RUN apt-get update && \
	apt-get install sudo

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the non-root user
USER user

# Set up the working directory
WORKDIR /home/user
