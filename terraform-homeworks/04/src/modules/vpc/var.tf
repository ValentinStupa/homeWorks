# variable "folder_id" {
#   type = string
# }

variable "zone" {
  type = string
  #default     = "ru-central1-a"

}
variable "cidr" {
  type = list(string)
  #default     = ["10.0.1.0/24"]
}

variable "env_name" {
  type = string
  #default     = "dev_mod"
  description = "VPC network&subnet name"
}
