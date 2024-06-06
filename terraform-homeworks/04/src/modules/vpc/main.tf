terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.5.7"
}

resource "yandex_vpc_network" "dev" {
  name = var.env_name
  #folder_id = var.folder_id
  #name = module.network.env_name
}
resource "yandex_vpc_subnet" "dev" {
  name = var.env_name
  zone = var.zone
  #folder_id      = var.folder_id
  network_id     = yandex_vpc_network.dev.id
  v4_cidr_blocks = var.cidr

}

