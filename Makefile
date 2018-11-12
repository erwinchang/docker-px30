all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo "  1. make run         - start px30 docker image"
	@echo "  2. make build       - build the px30 image"
	@echo "  3. make release     - release the px30 image"

run:
	@docker run -v ${HOME}:/mnt/home --rm --name px30-image -it erwinchang/px30 /bin/bash

build:
	@docker build --tag=erwinchang/px30 .

release: build
	@docker build --tag=erwinchang/px30:$(shell cat VERSION) .

