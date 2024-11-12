resource "yandex_storage_bucket" "bucket" {
  bucket                = "alekc"
  default_storage_class = "standard"
  #   acl                   = "public-read" #не будет доступа у сервисного аккаунта на изменение бакета
  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }
}

resource "yandex_storage_object" "bucket_object" {
  bucket = yandex_storage_bucket.bucket.bucket
  key    = "old_phone.jpeg"
  source = "/root/all_Homework/ter-homeworks/04/src/old_phone.jpeg"
  acl    = "public-read"
}

output "file_url" {
  value = "https://${yandex_storage_bucket.bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.bucket_object.key}"
}
