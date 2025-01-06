terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_network" "main" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnets" {
  for_each = var.subnets

  name           = each.key                   # Имя подсети (ключ из map)
  zone           = each.value.zone            # Зона подсети
  network_id     = yandex_vpc_network.main.id # ID сети
  v4_cidr_blocks = each.value.cidr            # CIDR-блок подсети
}
