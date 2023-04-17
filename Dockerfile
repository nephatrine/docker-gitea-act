FROM nephatrine/nxbuilder:golang AS builder

ARG ACT_RUNNER_VERSION=v0.1.2
RUN git -C /root clone -b "$ACT_RUNNER_VERSION" --single-branch --depth=1 https://gitea.com/gitea/act_runner.git

RUN echo "====== COMPILE ACT_RUNNER ======" \
 && cd /root/act_runner && make build

FROM nephatrine/alpine-s6:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== INSTALL PACKAGES ======" \
 && apk add --no-cache docker git git-lfs npm

COPY --from=builder /root/act_runner/act_runner /usr/bin/
COPY override /
