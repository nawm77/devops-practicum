locals {
  bucket-name = "tf-intro-site-bucket"
  index = "index.html"
}

resource "yandex_iam_service_account" "sa" {
  folder_id = local.folder_id
  name      = "tf-nawm"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "tf-nawm-bucket"
  acl = "public-read"

  website {
    index_document = local.index
  }
}

output site_name {
  value = yandex_storage_bucket.test.website_endpoint
}