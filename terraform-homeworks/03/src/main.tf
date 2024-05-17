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
data "yandex_compute_image" "ubuntu" {
  family = var.vpc_image
}
#---------------------------------
# Create 2 Vm's with the same specs
resource "yandex_compute_instance" "platform" {
  #for_each = toset(["web-1", "web-2"])
  #name     = "netology-develop-platform-${each.value}"
  count       = length(var.platform_name)
  name        = "netology-develop-platform-${var.platform_name[count.index]}"
  platform_id = var.vpc_platform_id
  resources {
    cores         = var.hardware.platform-web.cores
    memory        = var.hardware.platform-web.memory
    core_fraction = var.hardware.platform-web.core_fraction
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

  metadata = var.metadata
}
#---------------------------------------

resource "yandex_compute_instance" "db" {
  for_each = toset(var.db_specs.vm_name)
  name     = "netology-develop-platform-db-${each.value.vm_name}"
  platform_id = var.vpc_platform_id
  resources {

    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.hardware.platform-web.core_fraction
    #disk_volume   = each.value.disk_volume
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

  metadata = var.metadata
}
