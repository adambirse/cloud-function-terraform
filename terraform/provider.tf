provider "google" {
  credentials = file(var.service_account)
  project     = var.project_name
  region      = var.region
}