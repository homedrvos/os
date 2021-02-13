#!/bin/bash

set -ex

mkdir -p bits
curl -L 'https://github.com/burmilla/refpolicy/releases/download/v0.0.3/policy.29' -o '_bits/selinux_policy.29'
curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-x86.tar.gz' -o '_bits/linux-4.14.218-burmilla-x86.tar.gz'
curl -L 'https://storage.googleapis.com/golang/go1.8.5.linux-amd64.tar.gz' -o '_bits/go1.8.5.linux-amd64.tar.gz'
# curl -L 'https://github.com/burmilla/os-kernel/releases/download/v4.14.218-burmilla/linux-4.14.218-burmilla-arm64.tar.gz' -o linux-4.14.218-burmilla-arm64.tar.gz
