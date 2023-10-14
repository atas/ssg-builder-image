.PHONY: build run-local-image update-workflow-image tag-workflow-image

build:
	docker build . -t atas-ssg-builder:latest

multi-platform-build:
	docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 . -t atas-ssg-builder:latest

run-local-image:
	docker run --rm -it -v $(shell pwd):/workspace atas-ssg-builder:latest

# Updates the GHCR:latest image
update-workflow-image:
	docker login ghcr.io
	docker buildx build --platform linux/amd64 system/workflow-image -t ghcr.io/atas/ssg-builder:latest
	docker push ghcr.io/atas/ssg-builder:latest

# Creates a new tag for GHCR:latest image with the current date and time
tag-workflow-image:
	docker tag ghcr.io/atas/ssg-builder:latest ghcr.io/atas/ssg-builder:$(shell date +%Y%m%d%H%M)
	docker push ghcr.io/atas/ssg-builder:$(shell date +%Y%m%d%H%M)

