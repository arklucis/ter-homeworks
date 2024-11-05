###cloud vars
/*
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
*/

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}


variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr2" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "prod_vpc"
  description = "VPC network&subnet name"
}

variable "subnet_name1" {
  type        = string
  default     = "public"
  description = "subnet name"
}

variable "subnet_name2" {
  type        = string
  default     = "private"
  description = "subnet name"
}

###common vars
variable "vms_ssh_root_key" {
  type        = string
  default     = "/root/.ssh/id_ed25519.pub"
  description = "ssh-keygen -t ed25519"
}

variable "vm_resource" {
  type = list(object({
    public_ip   = bool
    platform    = string
    preemptible = bool
  }))
  default = [
    {
      public_ip   = true
      platform    = "standard-v1"
      preemptible = true

    }
  ]
}


/*
###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}
*/

/*
variable "metadata" {
  type = map(string)
}
*/
