# resource "yandex_vpc_address" "addr" {
#   name = "external-IP"
#   deletion_protection = "true"
#   external_ipv4_address {
#     zone_id = var.default_zone
#   }
# }

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
data "yandex_compute_image" "image" {
  #family = "centos-7"
  #family = "almalinux-8"
  family = var.vpc_image
}
#---------------------------------
resource "yandex_compute_instance" "vm_1" {
  name        = "k8s-master"
  platform_id = var.vpc_platform_id
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "vm_2" {
  name        = "k8s-worker-1"
  platform_id = var.vpc_platform_id
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "vm_3" {
  name        = "k8s-worker-2"
  platform_id = var.vpc_platform_id
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "vm_4" {
  name        = "k8s-worker-3"
  platform_id = var.vpc_platform_id
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "vm_5" {
  name        = "k8s-worker-4"
  platform_id = var.vpc_platform_id
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.
  metadata                  = var.metadata
}
#-----------------------------------
# resource "local_file" "ansible_host" {
#   content = templatefile("${path.module}/hosts.tftpl",
#     {
#       clickhouse = yandex_compute_instance.clickhouse.*,
#       vector     = yandex_compute_instance.vector.*,
#       lighthouse = yandex_compute_instance.lighthouse.*
#   })
#   filename = "../../playbook/inventory/hosts.list"
# }
