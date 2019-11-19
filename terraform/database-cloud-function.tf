resource "random_id" "database_id" {
  byte_length = 10
}

data "archive_file" "database-app_zip" {
  type = "zip"
  source_dir = "${path.root}/../database-app/"
  output_path = "${path.root}/database-app.zip"
}

resource "google_storage_bucket" "database-app_bucket" {
  name = "database-app_bucket-${random_id.database_id.hex}"
  location = var.region
}

# place the zip-ed code in the bucket
resource "google_storage_bucket_object" "database-app_zip" {
  name = "database-app.zip"
  bucket = google_storage_bucket.database-app_bucket.name
  source = "${path.root}/database-app.zip"
}

resource "google_cloudfunctions_function" "database-app_function" {
  name = "app"
  description = "database"
  available_memory_mb = 256
  source_archive_bucket = google_storage_bucket.database-app_bucket.name
  source_archive_object = google_storage_bucket_object.database-app_zip.name
  timeout = 60
  trigger_http = true
  runtime = "nodejs8"

  environment_variables = {
    DB_USER = google_sql_user.app-user.name
    DB_PASS = google_sql_user.app-user.password
    DB_NAME = google_sql_database.database.name
    CLOUD_SQL_CONNECTION_NAME = google_sql_database_instance.cloud-functions-db.connection_name
  }
}
