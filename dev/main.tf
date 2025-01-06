module "service_account" {
  source    = "./local_modules/service_account"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}


module "storage" {
  source = "./local_modules/storage"

}

terraform {
  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket   = "devops1"
    region   = "ru-central1"
    key      = "state/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

module "vpc" {
  source = "./local_modules/vpc"

  vpc_name = "develop"

  subnets = {
    subnet1 = { cidr = ["192.168.1.0/24"], zone = "ru-central1-a" }
    subnet2 = { cidr = ["192.168.2.0/24"], zone = "ru-central1-b" }
    subnet3 = { cidr = ["192.168.3.0/24"], zone = "ru-central1-d" }
  }
}

module "k8s-master" {
  source         = "./local_modules/random_vm/"
  vm_name        = "kubernetes-master-a"
  subnet_id      = [module.vpc.subnets["subnet1"].id]
  subnet_zones   = "ru-central1-a"
  public_ip      = var.vm_resource[0].public_ip
  image_family   = "ubuntu-24-04-lts"
  cores          = 2
  memory         = 4
  disk           = 10
  instance_count = 1

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

  labels = { project = "master" }
}

module "k8s-worker1" {
  source         = "./local_modules/random_vm/"
  vm_name        = "kubernetes-worker-b"
  subnet_id      = [module.vpc.subnets["subnet2"].id]
  subnet_zones   = "ru-central1-b"
  public_ip      = var.vm_resource[0].public_ip
  image_family   = "ubuntu-24-04-lts"
  cores          = 2
  memory         = 2
  disk           = 20
  instance_count = 1

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 0
  }

  labels = { project = "worker" }
}

module "k8s-worker2" {
  source         = "./local_modules/random_vm/"
  vm_name        = "kubernetes-worker-d"
  subnet_id      = [module.vpc.subnets["subnet3"].id]
  subnet_zones   = "ru-central1-d"
  public_ip      = var.vm_resource[0].public_ip
  image_family   = "ubuntu-24-04-lts"
  cores          = 2
  memory         = 2
  disk           = 20
  instance_count = 1

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 0
  }

  labels = { project = "worker" }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = file(var.vms_ssh_root_key)
    private_key    = file("~/.ssh/id_ed25519")
  }
}

