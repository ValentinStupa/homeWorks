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
resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

#---------------------------------
data "yandex_compute_image" "image" {
  #family = "centos-7"
  #family = "almalinux-8"
  family = var.vpc_image
}
#---------------------------------
resource "yandex_compute_instance" "nat-instance" {
  name        = "public"
  platform_id = var.vpc_platform_id
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1" #data.yandex_compute_image.image.image_id
      size     = var.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    ipv4               = true
    ip_address         = "192.168.10.254"
  }
  allow_stopping_for_update = true # Позволяет выключить ВМ, внести изменения в конфигурацию железа и включить.

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "almalinux:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI4AI6/iSUW6k+H8SU5AW7z4wxVZooyapkkXa88tuL2"
    user-data          = "#cloud-config\nusers:\n  - name: ${var.vm_user_nat}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}
# #-----------------------------------
resource "yandex_compute_instance" "private" {
  name        = "private"
  platform_id = var.vpc_platform_id
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
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
    subnet_id = yandex_vpc_subnet.private.id
    #nat       = false
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
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
