terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.80"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "terraform-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "terraform-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "vm" {
  name        = "terraform-vm"
  platform_id = "standard-v1"

  resources {
    cores  = var.vm_resources.cores
    memory = var.vm_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = "fd8aus3bfglr6dg9hsbk"
      size     = var.vm_resources.disk_size
      type     = "network-hdd" # Переносим сюда тип диска
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = var.enable_nat
  }

  metadata = {
    ssh-keys        = "ubuntu:${var.ssh_key}"
    radmin-password = var.radmin_password
  }
}