terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

data "yandex_compute_image" "my_image" {
  family = var.image_family
}

resource "yandex_compute_instance" "vm" {
  count       = var.instance_count #var.vm_resource[0].count
  name        = "${var.vm_name}-${count.index + 1}"
  platform_id = "standard-v1"

  resources {
    cores         = var.vm_resource[0].cores
    memory        = var.vm_resource[0].memory
    core_fraction = var.vm_resource[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_resource[0].preemptible
  }

  network_interface {
    subnet_id = element(var.subnet_id, count.index)
    nat       = var.vm_resource[0].public_ip
  }

  metadata = {
    for k, v in var.metadata : k => v
  }

  labels = {
    for k, v in var.labels : k => v
  }

}
