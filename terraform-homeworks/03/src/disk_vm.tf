variable "disk" {
  type = map(any)
  default = {
    #name = "non-replicated-disk-name"
    size = 1
    type = "network-hdd"
    zone = "ru-central1-a"
  }
}
#---------------------------------------
resource "yandex_compute_disk" "empty_disk" {
  count = 3
  name  = "disk-name-${count.index}"
  size  = var.disk.size
  type  = var.disk.type
  zone  = var.disk.zone
}
#---------------------------------------
resource "yandex_compute_instance" "storage" {
  name        = "netology-develop-platform-storage"
  platform_id = var.vpc_platform_id
  # Add new empty disks by the loop
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.empty_disk
    content {
      disk_id = yandex_compute_disk.empty_disk[secondary_disk.key].id
    }
  }
  resources {
    cores         = var.hardware.platform-web.cores
    memory        = var.hardware.platform-web.memory
    core_fraction = var.hardware.platform-web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 10
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
    ssh-key            = local.ssh_pub
  }
}