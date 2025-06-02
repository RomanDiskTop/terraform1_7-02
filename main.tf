# Создание облачной сети
resource "yandex_vpc_network" "network" {
  name = "app1-network"
  description = "Основная сеть для app1"
}

# Создание подсети
resource "yandex_vpc_subnet" "app1_net" {
  name           = "app1-net"
  description    = "Подсеть для app1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

# Создание виртуальной машины
resource "yandex_compute_instance" "vm" {
  name        = "app1-vm"
  description = "Виртуальная машина app1"
  platform_id = "standard-v1"
  scheduling_policy {
  preemptible = true
  }
  resources {
    cores  = var.vm_resources.cores
    memory = var.vm_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = "fd8aus3bfglr6dg9hsbk" # Ubuntu 20.04 LTS
      size     = var.vm_resources.disk_size
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.app1_net.id
    nat       = var.enable_nat
  }

  metadata = {
    ssh-keys        = "ubuntu:${var.ssh_key}"
    radmin-password = var.app1_password
  }
}