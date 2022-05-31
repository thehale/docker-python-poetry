# Copyright (c) 2022 Joseph Hale
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

POETRY_VERSION=1.1.13
PYTHON_IMAGE_TAG=3.8.13-slim
build:
	docker build \
		--build-arg POETRY_VERSION=$(POETRY_VERSION) \
		--build-arg PYTHON_IMAGE_TAG=$(PYTHON_IMAGE_TAG) \
		--tag jhale1805/python-poetry:$(POETRY_VERSION)-py$(PYTHON_IMAGE_TAG) \
		.

run:
	docker run --rm --name poetry poetry poetry --version