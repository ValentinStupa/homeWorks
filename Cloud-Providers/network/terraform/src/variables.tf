###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vpc_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID "
}

variable "vpc_image" {
  type = string
  #default     = "ubuntu-2004-lts"
  default     = "almalinux-8"
  description = "OS image name"
}

variable "disk_size" {
  type        = string
  default     = "10"
  description = "Disk size"
}


variable "metadata" {
  type = map(any)
  default = {
    serial-port-enable = 1
    ssh-keys           = "almalinux:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI4AI6/iSUW6k+H8SU5AW7z4wxVZooyapkkXa88tuL2"
    #ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI4AI6/iSUW6k+H8SU5AW7z4wxVZooyapkkXa88tuL2"
  }
}

# Объявление переменных для пользовательских параметров

variable "vm_user" {
  type = string
}

variable "vm_user_nat" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

# Добавление прочих переменных

locals {
  network_name     = yandex_vpc_network.develop.name
  subnet_name1     = yandex_vpc_subnet.public.name
  subnet_name2     = yandex_vpc_subnet.private.name
  sg_nat_name      = "nat-instance-sg"
  vm_nat_name      = "nat-instance"
  route_table_name = "nat-instance-route"
}