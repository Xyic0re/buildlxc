terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.0.0"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://tragopan.local:8006/api2/json"
    pm_password = "Juice87a"
    pm_user = "sv-terraform@pve"
    pm_otp = ""
}

resource "proxmox_lxc" "lxc-test" {
    features {
        nesting = true
    }
    hostname = "server1"
    rootfs {
	storage = "local-zfs"
	size = "8G"
    }
    network {
        name = "eth0"
        bridge = "vmbr0"
        ip = var.ip
        ip6 = "manual"
	gw = "192.168.8.126"
    }
    ostemplate = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
    password = "Juice87a$"
    pool = "terraform"
    target_node = "tragopan"
    unprivileged = true
    cores = "1"
    memory = "512"
}
