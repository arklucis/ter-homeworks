
output "vpc_id" {
  value = yandex_vpc_network.vpc.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.vpc.id
}

