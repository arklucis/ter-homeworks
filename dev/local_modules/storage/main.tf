terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_storage_bucket" "bucket" {
  bucket                = "devops1"
  default_storage_class = "standard"
  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }

  lifecycle {
    prevent_destroy = false # Блокируем случайное удаление бакета
  }

}
