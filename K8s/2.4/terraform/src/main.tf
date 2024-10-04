resource "yandex_vpc_address" "addr" {
  name = "external-IP"
  deletion_protection = "true"
  external_ipv4_address {
    zone_id = var.default_zone
  }
}

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
data "yandex_compute_image" "centos" {
  #family = "centos-7"
  family = "almalinux-8"
}
#---------------------------------
resource "yandex_compute_instance" "vm_1" {
  name        = "k8s"
  platform_id = var.vpc_platform_id
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
      size = 25
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
# resource "yandex_compute_instance" "vm_2" {
#   name        = "vm2"
#   platform_id = var.vpc_platform_id
#   zone        = var.default_zone

#   resources {
#     cores         = 2
#     memory        = 4
#     core_fraction = 5
#   }
#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.centos.image_id
#     }
#   }
#   scheduling_policy {
#     preemptible = true
#   }
#   network_interface {
#     subnet_id = yandex_vpc_subnet.develop.id
#     nat       = true
#   }

#   metadata = var.metadata
# }
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
