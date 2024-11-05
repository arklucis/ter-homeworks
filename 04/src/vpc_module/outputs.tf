# first_vpc
output "vpc_id" {
  value = yandex_vpc_network.vpc.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.vpc.id
}

output "vpc_name" {
  value = var.vpc_name
}

output "zone" {
  value = var.default_zone
}

output "cidr" {
  value = var.default_cidr
}

output "network_id" {
  value = yandex_vpc_network.vpc.id
}


# second_vpc
# output "vpc_id2" {
#   value = yandex_vpc_network.vpc2.id
# }

# output "subnet_id2" {
#   value = yandex_vpc_subnet.vpc2.id
# }

# output "subnet_id3" {
#   value = yandex_vpc_subnet.vpc3.id
# }

# output "vpc_name2" {
#   value = var.public
# }

# output "zone2" {
#   value = var.default_zone2
# }

# output "cidr2" {
#   value = var.default_cidr2
# }

# output "network_id2" {
#   value = yandex_vpc_network.vpc2.id
# }
