resource "google_storage_bucket" "function_bucket" {
    name = "${var.editor}-${var.project_name}-for-function"
    location = "US"
}

resource "google_storage_bucket_object" "function_object" {
    name = "main.py.zip"
    bucket = google_storage_bucket.function_bucket.name
    source = "./function_scripts/main.py.zip"
}

resource "google_cloudfunctions2_function" "ai_api_function" {
  name     = "${var.editor}-${var.project_name}"
  location = var.region
  depends_on = [ google_storage_bucket.function_bucket, google_storage_bucket_object.function_object ]

  build_config {
    runtime = "python38"
    entry_point = "run_api"
    environment_variables = {
      PROJECT  = "${var.projectID}"
      LOCATION = "${var.region}"
    }
    source {
        storage_source {
            bucket = google_storage_bucket.function_bucket.name
            object = google_storage_bucket_object.function_object.name
        }
    }
  }
}
