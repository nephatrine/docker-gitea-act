<!--
SPDX-FileCopyrightText: 2023-2025 Daniel Wolf <nephatrine@gmail.com>
SPDX-License-Identifier: ISC
-->

# Gitea Actions Runner

[![NephCode](https://img.shields.io/static/v1?label=Git&message=NephCode&color=teal)](https://code.nephatrine.net/NephNET/docker-gitea-act)
[![GitHub](https://img.shields.io/static/v1?label=Git&message=GitHub&color=teal)](https://github.com/nephatrine/docker-gitea-act)
[![Registry](https://img.shields.io/static/v1?label=OCI&message=NephCode&color=blue)](https://code.nephatrine.net/NephNET/-/packages/container/gitea-runner/latest)
[![DockerHub](https://img.shields.io/static/v1?label=OCI&message=DockerHub&color=blue)](https://hub.docker.com/repository/docker/nephatrine/gitea-runner/general)
[![unRAID](https://img.shields.io/static/v1?label=unRAID&message=template&color=orange)](https://code.nephatrine.net/NephNET/unraid-containers)

This is an Alpine-based container hosting a Gitea Actions act_runner for
performing your own CI/CD builds. You can have multiple such runners connected
to a Gitea server.

**WARNING: Please note that the runner itself runs as the root user inside the
container. Only allow trusted users and organizations access to your runner.**

## Supported Tags

- `gitea-runner:0.2.11`: act_runner 0.2.11

## Software

- [Alpine Linux](https://alpinelinux.org/)
- [Skarnet S6](https://skarnet.org/software/s6/)
- [s6-overlay](https://github.com/just-containers/s6-overlay)
- [act_runner](https://gitea.com/gitea/act_runner)

## Configuration

This is the only configuration file you will likely need to be aware of and
potentially customize.

- `/mnt/config/etc/gitea-runner.yaml`

Modifications to this file will require a service restart to pull in the
changes made.

### Container Variables

- `TZ`: Time Zone (i.e. `America/New_York`)
- `PUID`: Mounted File Owner User ID
- `PGID`: Mounted File Owner Group ID
- `DOCKER_HOST`: Docker Host (i.e. `unix:///var/run/docker.sock`)
- `GITEA_INSTANCE_URL`: Gitea Instance URL
- `GITEA_RUNNER_REGISTRATION_TOKEN`: Token from Gitea
- `GITEA_RUNNER_NAME`: Runner Name

## Testing

### docker-compose

```yaml
services:
  gitea-runner:
    image: nephatrine/gitea-runner:latest
    container_name: gitea-runner
    environment:
      TZ: America/New_York
      PUID: 1000
      PGID: 1000
      GITEA_INSTANCE_URL: https://gitea.example.net
      GITEA_RUNNER_REGISTRATION_TOKEN:
      GITEA_RUNNER_NAME: test
    volumes:
      - /mnt/containers/gitea-runner:/mnt/config
      - /var/run/docker.sock:/run/docker.sock
```

### docker run

```bash
docker run --rm -ti code.nephatrine.net/nephnet/gitea-runner:latest /bin/bash
```
