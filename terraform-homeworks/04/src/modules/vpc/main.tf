terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

resource "yandex_vpc_network" "dev" {
  name      = var.vpc_name
  folder_id = var.folder_id
}
resource "yandex_vpc_subnet" "dev" {
  name           = var.vpc_name
  zone           = var.default_zone
  folder_id      = var.folder_id
  network_id     = yandex_vpc_network.dev.id
  v4_cidr_blocks = var.default_cidr
}
