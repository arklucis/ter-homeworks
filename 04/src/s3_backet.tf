resource "yandex_storage_bucket" "bucket" {
  bucket                = "alekc"
  default_storage_class = "standard"
  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "bucket_object" {
  bucket = yandex_storage_bucket.bucket.bucket
  key    = "old_phone.jpeg"
  source = "/root/all_Homework/ter-homeworks/04/src/old_phone.jpeg"
  acl    = "public-read"

  lifecycle {
    prevent_destroy = false
  }

}

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "key1"
  description       = "symmetric_key_for_s3backet"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}



output "file_url" {
  value = "https://${yandex_storage_bucket.bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.bucket_object.key}"
}
