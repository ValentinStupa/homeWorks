resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}
#---------------------------------
resource "yandex_vpc_subnet" "develop-b" {
  name           = var.vpc_name-b
  zone           = var.default_zone-b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr-b
}
#---------------------------------
data "yandex_compute_image" "ubuntu" {
  #family = "ubuntu-2004-lts"
  family = var.vpc_image
}
#---------------------------------
resource "yandex_compute_instance" "platform" {
  #name        = "netology-develop-platform-web"
  name = "vm-web-${var.vpc_platform_name}"
  #platform_id = "standart-v4" #FailedPrecondition desc = Platform "standard-v4" not found(https://yandex.cloud/en/docs/compute/concepts/vm-platforms, https://terraform-provider.yandexcloud.net/Resources/compute_instance )
  #platform_id = "standard-v1"
  platform_id = var.vpc_platform_id
  resources {
    #cores         = 1 #InvalidArgument desc = the specified number of cores is not available on platform "standard-v1"; allowed core number: 2, 4
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
#-----------------------------------
resource "yandex_compute_instance" "platform-b" {
  name        = "vm-db-${var.vpc_platform_name-b}"
  platform_id = var.vpc_platform_id
  zone = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
