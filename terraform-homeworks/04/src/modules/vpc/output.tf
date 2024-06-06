output "cidr" {
  description = "The CIDR block of the VPC"
  value       = yandex_vpc_subnet.dev.v4_cidr_blocks
}

output "zone" {
  description = "Zone"
  value       = yandex_vpc_subnet.dev.zone
}

output "env_name" {
  value = "dev"
}
