<!--
 Copyright (c) 2022 Joseph Hale

 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# [Python Poetry](https://github.com/python-poetry/poetry) in Docker

<!-- BADGES -->

[![](https://badgen.net/docker/pulls/thehale/python-poetry)](https://hub.docker.com/r/thehale/python-poetry)
[![](https://badgen.net/github/license/thehale/docker-python-poetry)](https://github.com/thehale/docker-python-poetry/blob/master/LICENSE)
[![](https://badgen.net/badge/icon/Sponsor/pink?icon=github&label)](https://github.com/sponsors/thehale)
[![Joseph Hale's software engineering blog](https://jhale.dev/badges/website.svg)](https://jhale.dev)
[![](https://jhale.dev/badges/follow.svg)](https://www.linkedin.com/comm/mynetwork/discovery-see-all?usecase=PEOPLE_FOLLOWS&followMember=thehale)

Robust, lightweight, configurable `python-poetry` Docker images for any use
case.

_NOTE: This repository is **not** an official project from the creators of
Python Poetry. Hopefully you find it useful anyway!_

## Quickstart

Most of the time, you will be using these images as a base image for your own
Dockerfiles (e.g. devcontainers, building Python applications, etc.)

```Dockerfile
FROM thehale/python-poetry

RUN poetry --version
# Your build steps here.
```

However, you can also download and run the latest `python-poetry` Docker image
by pulling it from DockerHub.

```
docker pull thehale/python-poetry
docker run --rm thehale/python-poetry poetry --version
```

There are tagged images for all the latest stable versions of `python-poetry`
for all versions of Python that Poetry supports (>3.7). You can see the [full
tag list on DockerHub](https://hub.docker.com/r/thehale/python-poetry/tags).

## Build Your Own Image

This repo automatically builds images for the latest stable versions of
`python-poetry` for all supported versions of Python (>3.7).

- You can see the full build matrix in
  [.github/workflows/docker-image.yml](https://github.com/thehale/docker-python-poetry/blob/master/.github/workflows/docker-image.yml)

However, if you need a combination that isn't automatically built, you can
easily create your own by modifying the command below to contain your preferred
values for `POETRY_VERSION` and `PYTHON_IMAGE_TAG`:

```bash
make build-version \
    POETRY_VERSION="1.1.13" \
    PYTHON_IMAGE_TAG="3.10-slim"
```

## Non-root User

> [!NOTE]
>
> This section was adapted from the Node.js docs for [**Non-root
> user**](https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#non-root-user)
> in their Docker images.


By default, Docker runs commands inside the container as root which violates the [Principle of Least Privilege (PoLP)](https://en.wikipedia.org/wiki/Principle_of_least_privilege) when superuser permissions are not strictly required. You want to run the container as an unprivileged user whenever possible. The nonroot images provide the `nonroot` user for such purpose. The Docker Image can then be run with the `nonroot` user in the following way:

```
-u "nonroot"
```

Alternatively, the user can be activated in the `Dockerfile`:

```Dockerfile
FROM thehale/python-poetry:1.8.3
...
# At the end, set the user to use when running this image
USER nonroot
```

> [!TIP] 
>
> When using the `nonroot` user, remember to assign the corresponding ownership
> to your application tree (e.g. `chmod`).

Note that the `nonroot` user is neither a build-time nor a run-time dependency
and it can be removed or altered, as long as the functionality of the
application you want to add to the container does not depend on it.

If you do not want nor need the user created in this image, you can remove it with the following:

```Dockerfile
# For debian based images use:
RUN userdel -r nonroot

# For alpine based images use:
RUN deluser --remove-home nonroot
```

If you need to change the uid/gid of the user, you can use:

```Dockerfile
RUN groupmod -g 999 nonroot && usermod -u 999 -g 999 nonroot
```

If you need another name for the user (ex. `myapp`), execute:

```Dockerfile
RUN usermod -d /home/myapp -l myapp nonroot
```

For alpine based images, you do not have `groupmod` nor `usermod`, so to change the uid/gid you have to delete the previous user:

```Dockerfile
RUN deluser --remove-home nonroot \
  && addgroup -S nonroot -g 999 \
  && adduser -S -G nonroot -u 999 nonroot
```

## License

This project is licensed under the terms of the [MIT License](https://choosealicense.com/licenses/mit/).
