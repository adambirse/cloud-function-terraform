resource "random_id" "id" {
  byte_length = 10
}

data "archive_file" "app_zip" {
  type = "zip"
  source_dir = "${path.root}/../app/"
  output_path = "${path.root}/app.zip"
}

resource "google_storage_bucket" "app_bucket" {
  name = "app_bucket-${random_id.id.hex}"
  location = var.region
}

# place the zip-ed code in the bucket
resource "google_storage_bucket_object" "app_zip" {
  name = "app.zip"
  bucket = google_storage_bucket.app_bucket.name
  source = "${path.root}/app.zip"
}

resource "google_cloudfunctions_function" "app_function" {
  name = "hello"
  description = "Hello Function"
  available_memory_mb = 256
  source_archive_bucket = google_storage_bucket.app_bucket.name
  source_archive_object = google_storage_bucket_object.app_zip.name
  timeout = 60
  entry_point = "helloGET"
  trigger_http = true
  runtime = "nodejs8"
}