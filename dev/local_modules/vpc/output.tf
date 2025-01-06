output "subnets" {
  value = {
    for key, subnet in var.subnets : key => {
      id   = yandex_vpc_subnet.subnets[key].id
      zone = subnet.zone
    }
  }
}
