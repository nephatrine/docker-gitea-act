<!--
SPDX-FileCopyrightText: 2023 - 2024 Daniel Wolf <nephatrine@gmail.com>

SPDX-License-Identifier: ISC
-->

[Git](https://code.nephatrine.net/NephNET/docker-gitea-act/src/branch/master) |
[Docker](https://hub.docker.com/r/nephatrine/gitea-runner/) |
[unRAID](https://code.nephatrine.net/NephNET/unraid-containers)

# Gitea Actions Runner

This docker image contains a Gitea actions runner for hosting your own CI/CD
build environments.

The `latest` tag points to version `0.2.10` and this is the only image actively
being updated. There are tags for older versions, but these may no longer be
using the latest Alpine version and packages.

**Please note that the runner itself runs as the root user inside the container.**

## Docker-Compose

This is an example docker-compose file:

```yaml
services:
  act_runner:
    image: nephatrine/gitea-runner:latest
    container_name: act_runner
    environment:
      TZ: America/New_York
      PUID: 1000
      PGID: 1000
      GITEA_INSTANCE_URL: http://gitea.example.net:3000/
      GITEA_RUNNER_REGISTRATION_TOKEN: PUT_TOKEN_HERE
      GITEA_RUNNER_NAME: testrunner
      GITEA_RUNNER_LABELS: alpine:docker://nephatrine/nxbuilder:alpine,debian:docker://nephatrine/nxbuilder:debian
    volumes:
      - /mnt/containers/act_runner:/mnt/config
      - /var/run/docker.sock:/run/docker.sock
```

## Server Configuration

This is the only configuration file you will likely need to be aware of and
potentially customize.

- `/mnt/config/etc/gitea-runner.yaml`

Modifications to this file will require a service restart to pull in the
changes made.
