# SPDX-FileCopyrightText: 2023 - 2024 Daniel Wolf <nephatrine@gmail.com>
#
# SPDX-License-Identifier: ISC

FROM code.nephatrine.net/nephnet/nxb-alpine:latest-golang AS builder

ARG ACT_RUNNER_VERSION=v0.2.6
RUN git -C /root clone -b "$ACT_RUNNER_VERSION" --single-branch --depth=1 https://gitea.com/gitea/act_runner.git

ARG TAGS="sqlite sqlite_unlock_notify cgo"
RUN echo "====== COMPILE ACT_RUNNER ======" \
 && cd /root/act_runner \
 && make -j$(( $(getconf _NPROCESSORS_ONLN) / 2 + 1 )) build

FROM code.nephatrine.net/nephnet/alpine-s6:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== INSTALL PACKAGES ======" \
 && apk add --no-cache curl docker git git-lfs jq npm

COPY --from=builder /root/act_runner/act_runner /usr/bin/
COPY override /
