TARGETS := $(shell ls scripts | grep -vE 'clean|run|help|release*|build-moby|run-moby')

.dapper:
	cp _/dapper .dapper

$(TARGETS): .dapper
	./.dapper $@

pr-validation: .dapper
	ARCH="amd64" \
	KERNEL_URL_amd64="skip" \
	SKIP_BUILD="true" \
	./.dapper ci

trash: .dapper
	./.dapper -m bind trash

trash-keep: .dapper
	./.dapper -m bind trash -k

deps: trash

build/initrd/.id: .dapper
	./.dapper prepare

run: build/initrd/.id .dapper
	./.dapper -m bind build-target
	./scripts/run

build-moby:
	./scripts/build-moby

run-moby:
	./scripts/run-moby

shell-bind: .dapper
	./.dapper -m bind -s

clean:
	@./scripts/clean

release: .dapper release-build

release-build:
	mkdir -p dist
	./.dapper release

rpi64: .dapper
	./scripts/release-rpi64

vmware: .dapper
	mkdir -p dist
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="burmilla/os-openvmtools:11.2.0-5" \
	./.dapper release-vmware

hyperv: .dapper
	mkdir -p dist
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="burmilla/os-hypervvmtools:v4.14.206-burmilla-1" \
	./.dapper release-hyperv

azurebase: .dapper
	mkdir -p dist
	AZURE_SERVICE="true" \
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="burmilla/os-hypervvmtools:v4.14.206-burmilla-1 burmilla/os-waagent:v2.2.49.2-1" \
	./.dapper release-azurebase

4glte: .dapper
	mkdir -p dist
	APPEND_SYSTEM_IMAGES="burmilla/os-modemmanager:v1.6.4-1" \
	./.dapper release-4glte

proxmoxve: .dapper
	mkdir -p dist
	PROXMOXVE_SERVICE="true" \
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="burmilla/os-qemuguestagent:v3.1.0-1" \
	./.dapper release-proxmoxve

help:
	@./scripts/help

.DEFAULT_GOAL := default

.PHONY: $(TARGETS)
