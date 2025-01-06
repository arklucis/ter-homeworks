variable "subnets" {
  type = map(object({
    cidr = list(string)
    zone = string
  }))

  default = {
    subnet1 = { cidr = ["192.168.1.0/24"], zone = "ru-central1-a" }
    subnet2 = { cidr = ["192.168.2.0/24"], zone = "ru-central1-b" }
    subnet3 = { cidr = ["192.168.3.0/24"], zone = "ru-central1-d" }
  }
}

variable "vpc_name" {
  type        = string
  description = "VPC network name"
}
