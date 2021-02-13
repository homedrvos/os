#!/bin/bash

set -ex

mkdir -p _

# selinux policy
curl -L 'https://github.com/burmilla/refpolicy/releases/download/v0.0.3/policy.29' -o '_/selinux_policy.29'

# linux kernel
curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-x86.tar.gz' -o '_/linux-4.14.218-burmilla-x86.tar.gz'
# curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-arm64.tar.gz' -o linux-4.14.218-burmilla-arm64.tar.gz

# golang
curl -L 'https://storage.googleapis.com/golang/go1.8.5.linux-amd64.tar.gz' -o '_/go1.8.5.linux-amd64.tar.gz'
curl -L 'https://storage.googleapis.com/golang/go1.15.8.linux-amd64.tar.gz' -o '_/go1.15.8.linux-amd64.tar.gz'

# docker client

curl -L 'https://get.docker.com/builds/Linux/x86_64/docker-1.10.3' -o '_/docker-amd64'
curl -L 'https://github.com/burmilla/docker/releases/download/v1.10.3-ros1/docker-1.10.3_arm64' -o '_/docker-arm64'

# os-base

curl -L 'https://github.com/burmilla/os-base/releases/download/v2018.02.11-1/os-base_amd64.tar.xz' -o '_/os-base_amd64.tar.xz'
curl -L 'https://github.com/burmilla/os-base/releases/download/v2018.02.11-1/os-base_arm64.tar.xz' -o '_/os-base_arm64.tar.xz'
