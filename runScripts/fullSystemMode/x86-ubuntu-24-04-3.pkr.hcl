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
	boot_command = [
		"e<wait>",
		"<down><down><down>",
		"<end><bs><bs><bs><bs><wait>",
		"autoinstall ds=nocloud-net\\;s=https://{{ .HTTPIP }}:{{ .HHTPPort }}/ ---<wait>",
		"<f10><wait>",
	]
}