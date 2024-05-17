# variable "db_specs" {
#   description = "List of configurations."
#   type        = list(object)
#    default = {
#     netology-develop-platform-db-main = {
#         cores           = 2
#         memory          = 2
#         core_fraction   = 10
#     },
#     netology-develop-platform-db-replica = {
#         cores           = 2
#         memory          = 1
#         core_fraction   = 5
#     }
#   }
# }
#---------------------------

variable "db_specs" {
  type = list(object({ vm_name = string, cpu = number, ram = number, disk_volume = number }))
  default = [
    {
      vm_name = "main"
      cpu     = 2
      ram     = 2
      #core_fraction = 10
      disk_volume = 10
    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 1
      #core_fraction = 5
      disk_volume = 10

    }
  ]
}
#--------------------------------
# variable "db_specs" {
#   type = list(object({
#     name          = string,
#     cpu           = number,
#     ram           = number,
#     core_fraction = number,
#     disk_volume   = number
#   }))
#   default = [
#     {
#       name          = "main"
#       cpu           = 2
#       ram           = 2
#       core_fraction = 10
#       disk_volume   = 10
#     },
#     {
#       name          = "replica"
#       cpu           = 2
#       ram           = 1
#       core_fraction = 5
#       disk_volume   = 10

#     }
#   ]
# }
