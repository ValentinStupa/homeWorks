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

variable "vpc_platform_name-b" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Yandex compute instance name"
}