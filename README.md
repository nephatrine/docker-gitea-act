[Git](https://code.nephatrine.net/NephNET/docker-gitea-act/src/branch/master) |
[Docker](https://hub.docker.com/r/nephatrine/gitea-runner/) |
[unRAID](https://code.nephatrine.net/nephatrine/unraid-containers)

# Gitea CI/CD Runner

This docker image contains a Gitea actions runner.

- [Alpine Linux](https://alpinelinux.org/)
- [Skarnet Software](https://skarnet.org/software/)
- [S6 Overlay](https://github.com/just-containers/s6-overlay)
- [Gitea-Runner](https://gitea.com/gitea/act_runner)

You can spin up a quick temporary test container like this:

~~~
docker run --rm -v /var/run/docker.sock:/run/docker.sock -it nephatrine/gitea-runner:latest /bin/bash
~~~

## Docker Tags

- **nephatrine/gitea-runner:latest**: Gitea-Runner v0.1.2 / Alpine Latest

## Configuration Variables

You can set these parameters using the syntax ``-e "VARNAME=VALUE"`` on your
``docker run`` command. Some of these may only be used during initial
configuration and further changes may need to be made in the generated
configuration files.

- ``GITEA_INSTANCE_URL``: Gitea Instance URL (**""**)
- ``GITEA_RUNNER_REGISTRATION_TOKEN``: Gitea Runner Token (*""*)
- ``GITEA_RUNNER_NAME``: Gitea Runner Name (*""*)
- ``GITEA_RUNNER_LABELS``: Gitea Runner Labels (*""*)
- ``PUID``: Mount Owner UID (*1000*)
- ``PGID``: Mount Owner GID (*100*)
- ``TZ``: System Timezone (*America/New_York*)

## Persistent Mounts

You can provide a persistent mountpoint using the ``-v /host/path:/container/path``
syntax. These mountpoints are intended to house important configuration files,
logs, and application state (e.g. databases) so they are not lost on image
update.

- ``/mnt/config``: Persistent Data.
- ``/run/docker.sock`: Docker Daemon Socket.

Do not share ``/mnt/config`` volumes between multiple containers as they may
interfere with the operation of one another.

You can perform some basic configuration of the container using the files and
directories listed below.

- ``/mnt/config/etc/crontabs/<user>``: User Crontabs. [*]
- ``/mnt/config/etc/gitea-runner.yaml``: Set Runner Settings. [*]
- ``/mnt/config/etc/logrotate.conf``: Logrotate Global Configuration.
- ``/mnt/config/etc/logrotate.d/``: Logrotate Additional Configuration.

**[*] Changes to some configuration files may require service restart to take
immediate effect.**
