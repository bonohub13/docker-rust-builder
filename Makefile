SHELL := bash
CC := $(shell which cargo)
PWD := $(shell pwd)
PROJECT_NAME := $(shell pwd | sed "s#.*/##")
DOCKER_IMAGE_NAME := $(shell pwd | sed "s#.*/##" | tr [:upper:] [:lower:])
BIN := ${PROJECT_NAME}
SRC_DIR := src
LIB_DIR := 
CARGO_TOML := Cargo.toml

all: build run

# Rust code
clean:
	$(CC) clean

fmt:
	$(CC) fmt

build: fmt clean
	mkdir -p bin
	$(CC) build
	cp ./target/debug/${BIN} bin

run:
	./bin/${BIN}

build-linux-image:
	cp Cargo.toml docker
	docker build . -t ${PROJECT_NAME}/linux -f docker/Dockerfile.linux
	rm docker/Cargo.toml

rebuild-linux-image:
	cp Cargo.toml docker
	docker build . -t ${DOCKER_IMAGE_NAME}/linux -f docker/Dockerfile.linux --no-cache
	rm docker/build.tar

docker-build: fmt clean
	mkdir -p bin
	docker run --rm -it -v $(shell pwd):/app ${DOCKER_IMAGE_NAME}/linux
	cp ./target/debug/${BIN} bin
