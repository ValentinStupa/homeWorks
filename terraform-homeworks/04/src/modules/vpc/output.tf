# # VPC ID
# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = module.network
# }

# VPC CIDR blocks
output "cidr" {
  description = "The CIDR block of the VPC"
  value       = yandex_vpc_subnet.dev.v4_cidr_blocks
}

output "zone" {
  description = "Zone"
  value       = yandex_vpc_subnet.dev.zone
}
