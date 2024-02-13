/*
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}
*/

module "my_vpc" {
  source   = "./vpc_module"
  vpc_name = "my-vpc"
  #zone     = "ru-central1-a"
}


module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "vector"
  network_id     = module.my_vpc.vpc_id #yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.my_vpc.subnet_id] #[yandex_vpc_subnet.develop.id]
  instance_name  = "host"
  instance_count = 1
  image_family   = "centos-7"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

  labels = { project = "marketing" }

}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "clickhouse"
  network_id     = module.my_vpc.vpc_id #yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.my_vpc.subnet_id] #[yandex_vpc_subnet.develop.id]
  instance_name  = "host"
  instance_count = 1
  image_family   = "centos-7"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

  labels = { project = "analytics" }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_public_key = file(var.vms_ssh_root_key)
  }
}
