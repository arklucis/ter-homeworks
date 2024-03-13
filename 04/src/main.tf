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

data "yandex_compute_image" "centos-7" {
  family = "centos-7"
}

module "random_vm" {
  source         = "./local_modules/random_vm/"
  vm_name        = "vm"
  subnet_id      = [module.my_vpc.subnet_id]
  subnet_zones   = ["ru-central1-a"]
  public_ip      = var.vm_resource[0].public_ip
  image_family   = "centos-7"
  instance_count = 0

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

  labels = { project = "monitoring" }
}

module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "jenkins-master"
  network_id     = module.my_vpc.vpc_id #yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.my_vpc.subnet_id] #[yandex_vpc_subnet.develop.id]
  instance_name  = "host"
  instance_count = 1
  image_family   = "centos-7"
  public_ip      = true

  metadata = {
    user-data = data.template_file.cloudinit.rendered
  }

  labels = { project = "marketing" }

}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "jenkins-agent"
  network_id     = module.my_vpc.vpc_id #yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.my_vpc.subnet_id] #[yandex_vpc_subnet.develop.id]
  instance_name  = "host"
  instance_count = 1
  image_family   = "centos-7"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
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
