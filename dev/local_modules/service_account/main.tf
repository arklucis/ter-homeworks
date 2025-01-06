terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

# Сервисный аккаунт
resource "yandex_iam_service_account" "sa" {
  name        = "terraform-dev"
  description = "Service account for Kubernetes clusters"
}

# Роль для сервисного аккаунта
resource "yandex_resourcemanager_folder_iam_binding" "sa_editor" {
  folder_id = var.folder_id
  role      = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}
