#!/bin/bash

set -ex

mkdir -p _
curl -L 'https://github.com/burmilla/refpolicy/releases/download/v0.0.3/policy.29' -o '_/selinux_policy.29'
curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-x86.tar.gz' -o '_/linux-4.14.218-burmilla-x86.tar.gz'
curl -L 'https://storage.googleapis.com/golang/go1.8.5.linux-amd64.tar.gz' -o '_/go1.8.5.linux-amd64.tar.gz'
curl -L 'https://storage.googleapis.com/golang/go1.15.8.linux-amd64.tar.gz' -o '_/go1.15.8.linux-amd64.tar.gz'
# curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-arm64.tar.gz' -o linux-4.14.218-burmilla-arm64.tar.gz
