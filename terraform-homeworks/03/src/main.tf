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
  metadata = {
    serial-port-enable = 1
    ssh-key            = local.ssh_pub
  }
  # Which means the DB vm's will be created first. After that web.
  depends_on = [yandex_compute_instance.db]
}
#---------------------------------------
resource "yandex_compute_instance" "db" {
  for_each    = var.db_specs
  name        = "netology-develop-platform-db-${each.value.vm_name}"
  platform_id = var.vpc_platform_id
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
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
#---------------------------------------
resource "local_file" "ansible_host" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = yandex_compute_instance.platform,
      databases  = yandex_compute_instance.db,
      storage    = yandex_compute_instance.storage.*
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}
#------------------------------------
#It works
# resource "local_file" "ansible_host" {
#   content  = <<-EOT
#   [webservers]
#   %{~ for i in yandex_compute_instance.platform}
#   ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}
#   %{~ endfor}
#   [databases]
#   %{~ for i in yandex_compute_instance.db}
#   ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}
#   %{~ endfor}
#   [storage]
#   %{~ for i in yandex_compute_instance.storage.*}
#   ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}
#   %{~ endfor}  
#   EOT
#   filename = "${abspath(path.module)}/hosts.cfg"
# }
#-------------------------------------
# To show "fqdn" each instance via terraform console. ! terraform apply must be done
#>yandex_compute_instance.storage.fqdn
#>yandex_compute_instance.platform[0].fqdn
#>yandex_compute_instance.platform[1].fqdn
#>yandex_compute_instance.db["db1"].fqdn
#>yandex_compute_instance.db["db2"].fqdn

