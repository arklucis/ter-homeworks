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

variable "vm_user" {
  type    = string
  default = "root"
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

variable "user_data" {
  description = "Cloud-init user-data"
  type        = string
  default     = <<-EOF
    #!/bin/bash
    sudo -i mkdir -p /home/ubuntu/test/
  EOF
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




# write_files:
#   - path: /run/index.html
#     content: |
#       <h1>Welcome to the LAMP server</h1>
#       <p>Image from S3 Bucket:</p>
#       <img src="${bucket_url}" alt="Image">

# users:
#   - name: ubuntu
#     groups: sudo
#     shell: /bin/bash
#     sudo: ["ALL=(ALL) NOPASSWD:ALL"]
#     ssh_authorized_keys: ${ssh_public_key}
# runcmd:
#   - if hostname | grep -q "^nginx-"; then apt-get update && apt-get install -y nginx; fi
#   - if hostname | grep -q "^ha-proxy-"; then apt-get update && apt-get install -y haproxy; fi
#   - if hostname | grep -q "^kubernetes-"; then apt-get update && apt-get install -y snapd && snap install microk8s --classic && usermod -a -G microk8s root; fi
#   - echo "<h1>Welcome to the LAMP server</h1>" > /var/www/html/index.html
#   - echo "<p>Image from S3 Bucket:</p>" >> /var/www/html/index.html
#   - echo "<img src='http://BUCKET_URL_PLACEHOLDER/IMAGE_KEY_PLACEHOLDER' alt='Image'>" >> /var/www/html/index.html


# data "template_file" "cloudinit" {
#   template = file("./cloud-init.yml")
#   # vars = {
#   #   ssh_public_key = file(var.vms_ssh_root_key)
#   # bucket_url     = "https://${yandex_storage_bucket.bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.bucket_object.key}"
# }
# # }

# - echo "<img src='https://${yandex_storage_bucket.bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.bucket_object.key}' alt='Image' width='1920' height='1080'>" >> /var/www/html/index.html
