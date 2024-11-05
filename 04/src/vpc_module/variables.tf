
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
  type = string
  #default     = "vpczone"
  description = "VPC network&subnet name"
}


# variable "default_zone2" {
#   type    = string
#   default = "ru-central1-a"
# }
# variable "default_cidr2" {
#   type    = list(string)
#   default = ["192.168.10.0/24"]
# }

# variable "public" {
#   type        = string
#   description = "subnet name"
# }

# variable "vpc_name2" {
#   type = string
#   #default     = "vpczone"
#   description = "VPC network&subnet name"
# }

# variable "default_cidr3" {
#   type    = list(string)
#   default = ["192.168.20.0/24"]
# }

# variable "private" {
#   type        = string
#   description = "VPC subnet name"
# }

# variable "route_table_id" {
#   description = "Route table ID for private subnet"
#   type        = string
# }

# variable "nat_instance_ip" {
#   description = "IP-адрес NAT-инстанса"
#   type        = string
# }
