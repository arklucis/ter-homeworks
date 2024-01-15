###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  default     = "b1gjvjgh8siq871n3ijv"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gcpvf3t2ef5deh3tnl"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
}

/*
variable "vm_resource_name" {
  type    = list(string)
  default = ["netology-develop-platform-web", "standard-v1"]  # Add more strings as needed
}
*/

variable "vm_web_resource" {
  type = list(object({
    instance_name   = string
    instance_cores  = number
    instance_memory = number
    instance_core_fraction = number
    public_ip       = bool
    platform        = string
    preemptible     = bool
  }))
  default = [
    {
      instance_name   = "netology-develop-platform-web"
      instance_cores  = 2
      instance_memory = 1
      instance_core_fraction = 5
      public_ip       = true
      platform        = "standard-v1"
      preemptible     = true

    }
  ]
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBk+lCwqNyEPCC0Fkk3l3NeTwdRRHLHLwDwvIOO0apvO achernov@tp2-shift-w01"
  description = "ssh-keygen -t ed25519"
}
