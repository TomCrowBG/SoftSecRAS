packer {
	required_plugins {
		qemu = {
			source = "github.com/hashicorp/qemu"
			version = "~> 1"
		}
	}
}

variable "image_name" {
	type = string
	default = "x86-ubuntu-24-04-3"
}

variable "ssh_password" {
	type = string
	default = "12345"
}

variable "ssh_username" {
	type = string
	default = "gem5"
}

source "qemu" "initialize" {
	accelerator = "kvm"
	boot_command = [
		"e<wait>",
		"<down><down><down>",
		"<end><bs><bs><bs><bs><wait>",
		"autoinstall ds=nocloud-net\\;s=https://{{ .HTTPIP }}:{{ .HHTPPort }}/ ---<wait>",
		"<f10><wait>",
	]
	cpus = "4"
	disk_size = "5000"
	format = "raw"
	headless = "true"
	http_directory = "http"
	iso_checksum = "!!!"
	iso_urls = ["https://releases.ubuntu.com/noble/ubuntu-24.04.3-live-server-amd64.iso"]
	memory = "8192"
	output_directory = "disk-image-ubuntu-24-04"
	qemu_binary = "!!!"
	qemuargs = [["-cpu", "host"], ["-display", "none"]]
	ssh_password = "${var.ssh_password}"
	ssh_username = "${var.ssh_username}"
	ssh_wait_timeout = "60m"
	vm_name = "${var.image_name}"
	ssh_handshake_attempts = "1000"
}

build {
	sources = ["source.qemu.initialize"]

	provisioner "file" {
		destination = "/home/gem5/"
		source = "files/exit.sh"
	}

	provisioner "file" {
		destination = "/home/gem5/"
		source = "files/gem5_init.sh"
	}

	provisioner "file" {
		destination = "/home/gem5/"
		source = "files/after_boot.sh"
	}

	provisioner "file" {
		destination = "/home/gem5/"
		source = "serial-getty@.service"
	}

	provisioner "shell" {
		execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
		scripts = ["scripts/post-installation.sh"]
		expect_disconnect = true
	}

	provisioner "file" {
		source = "/home/gem5/vmlinux-x86-ubuntu"
		destination = "./disk-image-ubuntu-24-04/vmlinux-x86-ubuntu"
		direction = "download"
	}
}