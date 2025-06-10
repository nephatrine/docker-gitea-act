# SPDX-FileCopyrightText: 2023-2025 Daniel Wolf <nephatrine@gmail.com>
# SPDX-License-Identifier: ISC

# hadolint global ignore=DL3018

# hadolint ignore=DL3007
FROM code.nephatrine.net/nephnet/nxb-golang:latest AS builder

ARG ACT_RUNNER_VERSION=v0.2.11
RUN git -C /root clone -b "$ACT_RUNNER_VERSION" --single-branch --depth=1 https://gitea.com/gitea/act_runner.git
WORKDIR /root/act_runner

ARG TAGS="sqlite sqlite_unlock_notify cgo"
RUN make -j$(( $(getconf _NPROCESSORS_ONLN) / 2 + 1 )) build

# hadolint ignore=DL3007
FROM code.nephatrine.net/nephnet/alpine-s6:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN apk add --no-cache docker git git-lfs jq npm && rm -rf /tmp/* /var/tmp/*

COPY --from=builder /root/act_runner/act_runner /usr/bin/
COPY override /
