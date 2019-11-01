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


output "cloud_function_url" {
  value = google_cloudfunctions_function.app_function.https_trigger_url
}