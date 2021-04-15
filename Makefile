TARGETS := $(shell ls scripts | grep -vE 'clean|run|help|release*|build-moby|run-moby')

$(TARGETS):
	dapper $@

trash:
	dapper -m bind trash

trash-keep:
	dapper -m bind trash -k

deps: trash

build/initrd/.id:
	dapper prepare

run: build/initrd/.id
	dapper -m bind build-target
	./scripts/run

build-moby:
	./scripts/build-moby

run-moby:
	./scripts/run-moby

shell-bind:
	dapper -m bind -s

clean:
	@./scripts/clean

release: release-build

release-build:
	mkdir -p dist
	dapper release

rpi64:
	./scripts/release-rpi64

vmware:
	mkdir -p dist
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="$(APPEND_SYSTEM_IMAGES) burmilla/os-openvmtools:11.2.0-1" \
	dapper release-vmware

hyperv:
	mkdir -p dist
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="$(APPEND_SYSTEM_IMAGES) burmilla/os-hypervvmtools:v5.9.6-burmilla-1" \
	dapper release-hyperv

azurebase:
	mkdir -p dist
	AZURE_SERVICE="true" \
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="$(APPEND_SYSTEM_IMAGES) burmilla/os-hypervvmtools:v5.9.6-burmilla-1 burmilla/os-waagent:v2.2.49.2-1" \
	dapper release-azurebase

4glte:
	mkdir -p dist
	APPEND_SYSTEM_IMAGES="$(APPEND_SYSTEM_IMAGES) burmilla/os-modemmanager:v1.6.4-1" \
	dapper release-4glte

proxmoxve:
	mkdir -p dist
	PROXMOXVE_SERVICE="true" \
	OS_FIRMWARE="false" \
	APPEND_SYSTEM_IMAGES="$(APPEND_SYSTEM_IMAGES) burmilla/os-qemuguestagent:v3.1.0-1" \
	dapper release-proxmoxve

help:
	@./scripts/help

.DEFAULT_GOAL := default

.PHONY: $(TARGETS)
