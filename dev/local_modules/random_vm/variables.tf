variable "vm_name" {
  type    = string
  default = null
}

variable "cores" {
  type    = number
  default = null
}

variable "memory" {
  type    = string
  default = null
}

# variable "zone" {
#   type    = string
#   default = null
# }

variable "disk" {
  type    = number
  default = null
}

variable "labels" {
  description = "for dynamic block 'labels' "
  type        = map(string)
  default     = {}
}

variable "subnet_zones" {
  type    = string
  default = null
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
  default = "null"
}

variable "metadata" {
  description = "for dynamic block 'metadata' "
  type        = map(string)
}

variable "instance_count" {
  type    = number
  default = 1
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
    #count         = number
  }))
  default = [
    {
      public_ip   = true
      platform    = "standard-v3"
      preemptible = true
      #vm_name     = "ligthouse"
      cores  = 2
      memory = 2
      #disk          = number
      core_fraction = 20
      #count         = 2

    }
  ]
}
