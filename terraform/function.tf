resource "google_storage_bucket" "function_bucket" {
  name     = "${var.editor}-${var.project_name}-for-function"
  location = "US"
}

resource "google_storage_bucket_object" "function_object" {
  name   = "main.py.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "./function_scripts/main.py.zip"
}

resource "google_cloudfunctions2_function" "ai_api_function" {
  name       = "${var.editor}-${var.project_name}"
  location   = var.region
  depends_on = [google_storage_bucket.function_bucket, google_storage_bucket_object.function_object, google_service_account.service_account]

  build_config {
    runtime     = "python38"
    entry_point = "run_api"

    source {
      storage_source {
        bucket = google_storage_bucket.function_bucket.name
        object = google_storage_bucket_object.function_object.name
      }
    }
  }

  service_config {
    service_account_email = google_service_account.service_account.email
    environment_variables = {
      PROJECT_NUMBER = "${var.projectNumber}"
      LOCATION       = var.region
    }
  }
}

#ANNA this is not secure but will maybe let me know where the issue is.
resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloudfunctions2_function.ai_api_function.location
  service  = google_cloudfunctions2_function.ai_api_function.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}
