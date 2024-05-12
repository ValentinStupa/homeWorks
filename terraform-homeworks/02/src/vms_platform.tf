###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

# variable "cloud_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
# }

# variable "folder_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
# }

variable "default_zone-b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr-b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name-b" {
  type        = string
  default     = "develop-b"
  description = "VPC network & subnet name"
}

#------------------------------------------
# variable "vpc_image" {
#   type        = string
#   default     = "ubuntu-2004-lts"
#   description = "OS image name"
# }

variable "vpc_platform_name-b" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Yandex compute instance name"
}

# variable "vpc_platform_id" {
#   type        = string
#   default     = "standatd-v1"
#   description = "Type of family cores"
# }

#------------------------------------------
###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI4AI6/iSUW6k+H8SU5AW7z4wxVZooyapkkXa88tuL2"
#   description = "ssh-keygen -t ed25519"
# }
