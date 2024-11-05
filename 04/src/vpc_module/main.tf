terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


resource "yandex_vpc_network" "vpc" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "vpc" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.default_cidr
}


# resource "yandex_vpc_network" "vpc2" {
#   name = var.vpc_name2
# }

# resource "yandex_vpc_subnet" "vpc2" {
#   name           = var.public
#   zone           = var.default_zone2
#   network_id     = yandex_vpc_network.vpc2.id
#   v4_cidr_blocks = var.default_cidr2
# }

# resource "yandex_vpc_subnet" "vpc3" {
#   name           = var.private
#   zone           = var.default_zone2
#   network_id     = yandex_vpc_network.vpc2.id
#   v4_cidr_blocks = var.default_cidr3
#   route_table_id = var.nat_instance_ip #yandex_vpc_route_table.private_rt.id # Привязка таблицы маршрутизации
# }
