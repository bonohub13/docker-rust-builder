SHELL := bash
CC := $(shell which cargo)
PWD := $(shell pwd)
PROJECT_NAME := $(shell pwd | sed "s#.*/##")

all: build run

# Rust code
clean:
	$(CC) clean

fmt:
	$(CC) fmt

build: fmt clean
	mkdir -p bin
	$(CC) build
	cp ./target/debug/${PROJECT_NAME} bin

run:
	./bin/${PROJECT_NAME}

rebuild-linux-image:
	cp Cargo.toml docker
	docker build . -t ${PROJECT_NAME}/linux -f docker/Dockerfile.linux --no-cache
	rm docker/Cargo.toml

docker-build: fmt clean
	mkdir -p bin
	docker run --rm -it -v $(shell pwd):/app ${PROJECT_NAME}/linux
	cp ./target/debug/${PROJECT_NAME} bin
