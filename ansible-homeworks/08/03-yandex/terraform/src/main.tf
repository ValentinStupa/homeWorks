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
data "yandex_compute_image" "almalinux" {
  family = "almalinux-8"
}
#---------------------------------
resource "yandex_compute_instance" "clickhouse" {
  name        = "clickhouse"
  platform_id = var.vpc_platform_id
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.almalinux.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "vector" {
  name        = "vector"
  platform_id = var.vpc_platform_id
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.almalinux.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.metadata
}
#-----------------------------------
resource "yandex_compute_instance" "lighthouse" {
  name        = "lighthouse"
  platform_id = var.vpc_platform_id
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.almalinux.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.metadata
}

# #---------------------------------------
# resource "local_file" "ansible_host" {
#   content  = <<-EOT
#   [clickhouse]
#   %{for i in yandex_compute_instance.clickhouse.*}
#   ${i["network_interface"][0]["nat_ip_address"]}
#   %{~endfor}
#   [vector]
#   %{for i in yandex_compute_instance.vector.*}
#   ${i["network_interface"][0]["nat_ip_address"]}
#   %{~endfor}
#   [lighthouse]
#   %{for i in yandex_compute_instance.lighthouse.*}
#   ${i["network_interface"][0]["nat_ip_address"]}
#   %{~endfor}
#   EOT
#   filename = "../../playbook/inventory/hosts.list"
# }
resource "local_file" "ansible_host" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      clickhouse = yandex_compute_instance.clickhouse.*,
      vector     = yandex_compute_instance.vector.*,
      lighthouse = yandex_compute_instance.lighthouse.*
  })
  filename = "../../playbook/inventory/hosts.list"
}
