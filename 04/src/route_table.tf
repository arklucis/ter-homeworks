resource "yandex_vpc_route_table" "private_rt" {
  network_id = yandex_vpc_network.vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"                                                          # Весь исходящий трафик
    next_hop_address   = yandex_compute_instance.nat_instance.network_interface[0].ip_address # Привязка к IP NAT-инстанса
  }
}
