
TEST_MODULE = $(shell grep "ENV TEST_MODULE=" Containerfile | sed -n 's/.*="\(.*\)"/\1/p')
TEST_MODULE_NAME = $(shell grep "ENV TEST_MODULE_NAME=" Containerfile | sed -n 's/.*="\(.*\)"/\1/p')
TEST_MODULE_VERSION = $(shell grep "ENV TEST_MODULE_VERSION=" Containerfile | sed -n 's/.*="\(.*\)"/\1/p')
TEST_MODULE_REGISTRY = quay.io/abellott

all:	help

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help              show this help message"
	@echo "  build             build the container image for the $(TEST_MODULE):$(TEST_MODULE_VERSION)"
	@echo "  run               run the $(TEST_MODULE):$(TEST_MODULE_VERSION) container image"
	@echo "  inspect           invoke a bash shell in the $(TEST_MODULE):$(TEST_MODULE_VERSION) container image"
	@echo "  push              push the image built to $(TEST_MODULE_REGISTRY)"

build:
	echo "Building Version $(TEST_MODULE_VERSION) of $(TEST_MODULE_NAME) ..."
	podman build \
		-t $(TEST_MODULE):$(TEST_MODULE_VERSION) .

run:
	podman run --hostname=$(TEST_MODULE) $(TEST_MODULE):$(TEST_MODULE_VERSION)

inspect:
	podman run --hostname=$(TEST_MODULE) -it $(TEST_MODULE):$(TEST_MODULE_VERSION) /bin/bash

push:
	podman push $(TEST_MODULE):$(TEST_MODULE_VERSION) $(TEST_MODULE_REGISTRY)/$(TEST_MODULE):$(TEST_MODULE_VERSION)

