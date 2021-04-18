package main

import (
	"fmt"
	"path"
	"runtime"
)

type download struct {
	name   string
	source string
}

func githubRelease(repo, ver, file string) string {
	p := path.Join(repo, "releases/download", ver, file)
	return "https://github.com/" + p
}

func burmillaRelease(repo, ver, file string) string{
	return githubRelease(path.Join("burmilla", repo), ver, file)
}

func main() {
	const (
		goVersion           = "1.16.3"
		kernelVersion       = "5.10.16-burmilla"
		systemDockerVersion = "17.06-ros6"
	)

	arch := runtime.GOARCH
	kernelArch := arch
	if kernelArch == "amd64" {
		kernelArch = "x86"
	}

	var downloads []*download
	add := func(name, src string) {
		downloads = append(downloads, &download{
			name:   name,
			source: src,
		})
	}

	add(
		"kernel.tar.gz",
		burmillaRelease(
			"os-kernel", "v"+kernelVersion,
			fmt.Sprintf("%s-%s.tar.gz", kernelVersion, kernelArch),
		),
	)

	switch arch {
	case "amd64":
		add(
			"build-docker",
			"https://get.docker.com/builds/Linux/x86_64/docker-1.10.3",
		)
	case "arch64":
		add(
			"build-docker",
			burmillaRelease("docker", "v1.10.3-ros1", "docker-1.10.3_arm64"),
		)
	}

	add("os-base.tar.xz", burmillaRelease(
		"os-base", "v2018.02-11-1",
		fmt.Sprintf("os-base_%s.tar.xz", arch),
	))
	add("os-initrd-base.tar.gz", burmillaRelease(
		"os-initrd-base", "v2018.02.11-1",
		fmt.Sprintf("os-initrd-base-%s.tar.gz", arch),
	))

	add("system-docker", burmillaRelease(
		"os-system-docker", systemDockerVersion,
		fmt.Sprintf("docker-%s-%s.tgz", arch, systemDockerVersion),
	))

	add(
		"golang.tar.gz",
		"https://storage.googleapis.com/golang/"+
			fmt.Sprintf("go%s.linux-%s.tar.gz", goVersion, arch),
	)

	if arch == "arm64" {
		add(
			"rpi-kernel.tar.gz",
			burmillaRelease(
				"os-rpi-kernel", "v"+kernelVersion,
				fmt.Sprintf("%s-v8.tar.gz", kernelVersion),
			),
		)
		add(
			"rpi-bootloader.tar.gz",
			burmillaRelease(
				"os-rpi-kernel", "v"+kernelVersion,
				"rpi-bootloader.tar.gz",
			),
		)

		const brcmURLBase = "https://git.kernel.org/pub/scm/linux/kernel" +
			"/git/firmware/linux-firmware.git/plain/brcm/"

		add("brcmfmac43430-sdio.bin", brcmURLBase + "brcmfmac43430-sdio.bin")
		add(
			"brcmfmac43430-sdio.txt",
			brcmURLBase + "brcmfmac43430-sdio.raspberrypi,3-model-b.txt",
		)
		add("brcmfmac43455-sdio.bin", brcmURLBase + "brcmfmac43455-sdio.bin")
		add(
			"brcmfmac43455-sdio.txt",
			brcmURLBase + "brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt",
		)
	}

	for _, d := range downloads {
		fmt.Println(d.name, d.source)
	}
}
