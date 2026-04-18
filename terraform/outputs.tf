output "vpc_id" {
  description = "ID de la VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de las subnets publicas"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = module.network.private_subnet_ids
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = module.network.internet_gateway_id
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = module.network.nat_gateway_id
}
