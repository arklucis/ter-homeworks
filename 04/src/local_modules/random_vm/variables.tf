variable "vm_name" {
  type    = string
  default = null
}

variable "labels" {
  description = "for dynamic block 'labels' "
  type        = map(string)
  default     = {}
}

variable "subnet_zones" {
  type = list(string)
}

variable "image_id" {
  description = "ID of the image for the instance."
  type        = string
  default     = null
}

variable "subnet_id" {
  type    = list(string)
  default = null
}

variable "public_ip" {
  type    = bool
  default = null
}

variable "user_data" {
  description = "User data for the instance."
  type        = string
  default     = null
}

variable "image_family" {
  type    = string
  default = "centos-7"
}

variable "metadata" {
  description = "for dynamic block 'metadata' "
  type        = map(string)
}

variable "vm_resource" {
  type = list(object({
    public_ip   = bool
    platform    = string
    preemptible = bool
    #vm_name     = string
    cores  = number
    memory = number
    #disk          = number
    core_fraction = number
    count         = number
  }))
  default = [
    {
      public_ip   = true
      platform    = "standard-v1"
      preemptible = true
      #vm_name     = "ligthouse"
      cores  = 2
      memory = 4
      #disk          = number
      core_fraction = 20
      count         = 1

    }
  ]
}
