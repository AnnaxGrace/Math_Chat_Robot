terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.projectID
  region  = var.region
  zone    = var.zone
}


# resource "google_storage_bucket" "auto-expire" {
#   name          = "aconover-terraform-test"
#   location      = "US"
# }