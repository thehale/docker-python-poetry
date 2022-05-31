# Copyright (c) 2022 Joseph Hale
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# Default to the latest slim version of Python
ARG PYTHON_IMAGE_TAG=slim

###############################################################################
# POETRY BASE IMAGE - Provides environment variables for poetry
###############################################################################
FROM python:${PYTHON_IMAGE_TAG} AS python-poetry-base
# Default to the latest version of Poetry
ARG POETRY_VERSION=""

ENV POETRY_VERSION=${POETRY_VERSION}
ENV POETRY_HOME="/opt/poetry"
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV POETRY_NO_INTERACTION=1

ENV PATH="$POETRY_HOME/bin:$PATH"


###############################################################################
# POETRY BUILDER IMAGE - Installs Poetry and dependencies
###############################################################################
FROM python-poetry-base AS python-poetry-builder
RUN apt-get update \
    && apt-get install --no-install-recommends --assume-yes curl
# Install Poetry via the official installer: https://python-poetry.org/docs/master/#installing-with-the-official-installer
# This script respects $POETRY_VERSION & $POETRY_HOME
RUN curl -sSL https://install.python-poetry.org | python3 -


###############################################################################
# POETRY RUNTIME IMAGE - Copies the poetry installation into a smaller image
###############################################################################
FROM python-poetry-base AS python-poetry
COPY --from=python-poetry-builder $POETRY_HOME $POETRY_HOME