resource "random_id" "db_id" {
  byte_length = 4
  prefix = "sql-${terraform.workspace}-"
}

resource "google_sql_database_instance" "cloud-functions-db" {
  name = random_id.db_id.hex
  database_version = var.database_version
  region = var.region

  settings {
    tier = var.database_tier
    ip_configuration {
      ipv4_enabled = "true"
    }
  }
}


resource "google_sql_database" "database" {
  name = var.database_name
  instance = google_sql_database_instance.cloud-functions-db.name
  charset = var.database_charset
}


resource "google_sql_user" "app-user" {
  name = var.database_user
  instance = google_sql_database_instance.cloud-functions-db.name
  host = "%"
  password = var.database_password
}
