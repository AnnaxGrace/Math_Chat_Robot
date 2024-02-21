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


output "function_success" {
  description = "This is the ID for the function, so that we know it was created successfully"
  value = google_cloudfunctions2_function.ai_api_function.id
}
