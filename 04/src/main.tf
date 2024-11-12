resource "yandex_vpc_network" "vpc" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "external" {
  name           = var.subnet_name1
  zone           = var.default_zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.default_cidr
}

# resource "yandex_vpc_subnet" "internal" {
#   name           = var.subnet_name2
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.vpc.id
#   v4_cidr_blocks = var.default_cidr2
#   route_table_id = yandex_vpc_route_table.private_rt.id # Привязка таблицы маршрутизации
# }


module "my_vpc" {
  source   = "./vpc_module"
  vpc_name = "my-vpc"
  # vpc_name2 = "my-vpc2"
  # public    = "public"
  # private   = "private"
}

data "yandex_compute_image" "centos-7" {
  family = "centos-7"
}


module "k8s" {
  source         = "./local_modules/random_vm/"
  vm_name        = "kubernetes"
  subnet_id      = [module.my_vpc.subnet_id]
  subnet_zones   = ["ru-central1-a"]
  public_ip      = var.vm_resource[0].public_ip
  image_family   = "ubuntu-2004-lts"
  instance_count = 0

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 0
  }

  labels = { project = "prod" }
}


# module "proxy" {
#   source         = "./local_modules/random_vm/"
#   vm_name        = "ubuntu2"
#   subnet_id      = [module.my_vpc.subnet_id] #[yandex_vpc_subnet.internal.id]
#   subnet_zones   = ["ru-central1-a"]
#   public_ip      = false #var.vm_resource[0].public_ip
#   image_family   = "ubuntu-2004-lts"
#   instance_count = 0

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered
#     serial-port-enable = 1
#   }

#   labels = { project = "web" }
# }

# module "random_vm" {
#   source         = "./local_modules/random_vm/"
#   vm_name        = "ubuntu"
#   subnet_id      = [yandex_vpc_subnet.external.id]
#   subnet_zones   = ["ru-central1-a"]
#   public_ip      = true #var.vm_resource[0].public_ip
#   image_family   = "ubuntu-2004-lts"
#   instance_count = 0

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered
#     serial-port-enable = 1
#   }

#   labels = { project = "web" }
# }

# module "test-vm" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = "jenkins-master"
#   network_id     = module.my_vpc.vpc_id #yandex_vpc_network.develop.id
#   subnet_zones   = ["ru-central1-a"]
#   subnet_ids     = [module.my_vpc.subnet_id] #[yandex_vpc_subnet.develop.id]
#   instance_name  = "host"
#   instance_count = 0
#   image_family   = "centos-7"
#   public_ip      = true

#   metadata = {
#     user-data = data.template_file.cloudinit.rendered
#   }

#   labels = { project = "marketing" }

# }

# module "example-vm" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = "jenkins-agent"
#   network_id     = module.my_vpc.vpc_id #yandex_vpc_network.develop.id
#   subnet_zones   = ["ru-central1-a"]
#   subnet_ids     = [module.my_vpc.subnet_id] #[yandex_vpc_subnet.develop.id]
#   instance_name  = "host"
#   instance_count = 0
#   image_family   = "centos-7"
#   public_ip      = true

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered
#     serial-port-enable = 1
#   }

#   labels = { project = "analytics" }

# }


data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = file(var.vms_ssh_root_key)
    bucket_url     = "https://${yandex_storage_bucket.bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.bucket_object.key}"
  }
}
