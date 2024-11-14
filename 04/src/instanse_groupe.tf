# Чтение и извлечение service_account_id из файла JSON
locals {
  authorized_key     = jsondecode(file("~/authorized_key.json"))
  service_account_id = local.authorized_key["service_account_id"]
}

resource "yandex_compute_instance_group" "group1" {
  name                = "lamp-instance-group"
  folder_id           = var.folder_id
  service_account_id  = local.service_account_id
  deletion_protection = false

  instance_template {
    platform_id = "standard-v1"
    resources {
      memory        = 2
      cores         = 2
      core_fraction = 20
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }

    network_interface {
      network_id = yandex_vpc_network.vpc.id
      subnet_ids = ["${yandex_vpc_subnet.external.id}"]
      nat        = true
    }

    #   metadata = {
    #     user_data          = data.template_file.cloudinit.rendered
    #     serial-port-enable = 1
    #     # ssh-keys           = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    #   }
    # }

    #   metadata = {
    #     user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("~/.ssh/id_ed25519.pub")}"
    #   }
    # }

    metadata = {
      user-data = <<-EOF
    #cloud-config
    users:
      - name: ${var.vm_user}
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh-authorized-keys:
          - ${file("~/.ssh/id_ed25519.pub")}
    
    runcmd:
      - echo "<h1>Welcome to the LAMP server</h1>" > /var/www/html/index.html
      - echo "<p>Image from S3 Bucket:</p>" >> /var/www/html/index.html
      - echo "<a href='https://${yandex_storage_bucket.bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.bucket_object.key}'>Click here to view the image</a>" >> /var/www/html/index.html
  EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 3
    max_expansion   = 2
    max_deleting    = 3
  }

  health_check {
    interval            = 5
    timeout             = 4
    healthy_threshold   = 2
    unhealthy_threshold = 3

    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}

# Сетевой балансировщик
resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.group1.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}
