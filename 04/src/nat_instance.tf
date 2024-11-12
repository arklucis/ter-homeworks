# resource "yandex_compute_instance" "nat_instance" {
#   name        = "nat-instance"
#   platform_id = "standard-v1"
#   zone        = var.default_zone

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd80mrhj8fl2oe87o4e1"
#     }
#   }

#   network_interface {
#     subnet_id  = yandex_vpc_subnet.external.id
#     nat        = true
#     ip_address = "192.168.10.254"
#   }

#   metadata = {
#     serial-port-enable = 1
#     ssh_public_key     = file(var.vms_ssh_root_key)
#   }
# }
