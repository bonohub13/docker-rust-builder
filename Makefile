SHELL := bash
CC := $(shell which cargo)
PWD := $(shell pwd)
PROJECT_NAME := $(shell pwd | /bin/awk -F/ '{print$NF}')
BIN := ""

all: build run

# Rust code
clean:
	$(CC) clean

fmt:
	$(CC) fmt

build: fmt clean
	mkdir -p bin
	$(CC) build
	cp ./target/debug/$(shell pwd | /bin/awk -F/ '{print$NF}') bin

run:
	./bin/$(shell pwd | /bin/awk -F/ '{print$NF}')

rebuild-linux-image:
	cp Cargo.toml docker
	docker build . -t $(shell pwd | /bin/awk -F/ '{print$NF}')/linux -f docker/Dockerfile.linux --no-cache
	rm docker/Cargo.toml

docker-build: fmt clean
	mkdir -p bin
	docker run --rm -it -v $(shell pwd):/app $(shell pwd | /bin/awk -F/ '{print$NF}')/linux
	cp ./target/debug/$(shell pwd | /bin/awk -F/ '{print$NF}') bin
