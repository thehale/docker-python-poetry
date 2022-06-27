# Copyright (c) 2022 Joseph Hale
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

build:
	docker build \
		--tag thehale/python-poetry:latest \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--cache-from thehale/python-poetry:latest \
		.

build-version:
	docker build \
		--tag thehale/python-poetry:$(POETRY_VERSION)-py$(PYTHON_IMAGE_TAG) \
		--build-arg POETRY_VERSION=$(POETRY_VERSION) \
		--build-arg PYTHON_IMAGE_TAG=$(PYTHON_IMAGE_TAG) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--cache-from thehale/python-poetry:$(POETRY_VERSION)-py$(PYTHON_IMAGE_TAG) \
		.
