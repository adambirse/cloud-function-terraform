// General Variables

variable "service_account" {
  type = "string"
  description = "GCP service account location."
}

variable "project_name" {
  type = "string"
  description = "project name"
}

variable region {
  type = "string"
  description = "Region to use."
  default = "europe-west2"
}

variable database_version {
  type = "string"
  default = "MYSQL_5_7"
}

variable database_tier {
  type = "string"
  default = "db-f1-micro"
}

variable database_name {
  type = "string"
  default = "cloud-functions"
}

variable database_charset {
  type = "string"
  default = "utf8"
}

variable database_user {
  type = "string"
  default = "test"
}

variable database_password {
  type = "string"
  default = "test"
}

output "cloud_function_url" {
  value = google_cloudfunctions_function.app_function.https_trigger_url
}

output "database_cloud_function_url" {
  value = google_cloudfunctions_function.database-app_function.https_trigger_url
}
