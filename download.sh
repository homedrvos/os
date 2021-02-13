#!/bin/bash

set -ex

mkdir -p _

# selinux policy
curl -L 'https://github.com/burmilla/refpolicy/releases/download/v0.0.3/policy.29' -o '_/selinux_policy.29'

# linux kernel
curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-x86.tar.gz' -o '_/linux-4.14.218-burmilla-x86.tar.gz'
# curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-arm64.tar.gz' -o linux-4.14.218-burmilla-arm64.tar.gz

# golang
# curl -L 'https://storage.googleapis.com/golang/go1.8.5.linux-amd64.tar.gz' -o '_/go1.8.5.linux-amd64.tar.gz'
curl -L 'https://storage.googleapis.com/golang/go1.15.8.linux-amd64.tar.gz' -o '_/go1.15.8.linux-amd64.tar.gz'

# docker client
curl -L 'https://get.docker.com/builds/Linux/x86_64/docker-1.10.3' -o '_/docker-amd64'
curl -L 'https://github.com/burmilla/docker/releases/download/v1.10.3-ros1/docker-1.10.3_arm64' -o '_/docker-arm64'

# os-base
curl -L 'https://github.com/burmilla/os-base/releases/download/v2018.02.11-1/os-base_amd64.tar.xz' -o '_/os-base_amd64.tar.xz'
curl -L 'https://github.com/burmilla/os-base/releases/download/v2018.02.11-1/os-base_arm64.tar.xz' -o '_/os-base_arm64.tar.xz'

# os-initrd-base
curl -L 'https://github.com/burmilla/os-initrd-base/releases/download/v2018.02.11-1/os-initrd-base-amd64.tar.gz' -o '_/os-initrd-base-amd64.tar.gz'
curl -L 'https://github.com/burmilla/os-initrd-base/releases/download/v2018.02.11-1/os-initrd-base-arm64.tar.gz' -o '_/os-initrd-base-arm64.tar.gz'

# os-system-docker
readonly SYSTEM_DOCKER_VERSION="17.06-ros6"
curl -L "https://github.com/burmilla/os-system-docker/releases/download/${SYSTEM_DOCKER_VERSION}/docker-amd64-${SYSTEM_DOCKER_VERSION}.tgz" -o '_/system-docker-amd64.tgz'
curl -L "https://github.com/burmilla/os-system-docker/releases/download/${SYSTEM_DOCKER_VERSION}/docker-arm64-${SYSTEM_DOCKER_VERSION}.tgz" -o '_/system-docker-arm64.tgz'

# kexec
mkdir -p scripts/installer/kexec/_
curl -L 'https://www.kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.15.tar.gz' -o '_/kexec-tools-2.0.15.tar.gz'
cp '_/kexec-tools-2.0.15.tar.gz' 'scripts/installer/kexec/_/.'
