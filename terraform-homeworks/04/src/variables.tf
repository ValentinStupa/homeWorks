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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

#----------------------
variable "username" {
  type        = string
  default     = "valentins"
  description = "User name"
  validation {
    condition     = contains(["valentins"], var.username)
    error_message = "Invalid username"
  }
}

variable "package" {
  type        = string
  default     = "nginx"
  description = "Packages"
  validation {
    condition     = contains(["nginx"], var.package)
    error_message = "Invalid package "
  }
}
#------------------------
variable "ip" {
  type        = string
  default     = "192.168.0.1"
  description = "Ip address"
  validation {
    condition     = can(regex("[0-9]{3}.[0-9]{3}.[0-9].[0-9]", var.ip))
    error_message = "Wrong ip address"
  }

}
# https://www.oreilly.com/library/view/regular-expressions-cookbook/9780596802837/ch07s16.html
variable "range_ip" {
  type = list(string)
  #default = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
  description = "Range of Ip's"
  validation {
    #condition     = can([for ip in var.range_ip : regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", ip)])
    condition     = can([for ip in var.range_ip : regex("^([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})$", ip)])
    error_message = "Wrong IPs range"
  }

}
