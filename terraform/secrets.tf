resource "google_secret_manager_secret" "projectID" {
  secret_id = "math-robot-secret-projectID"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "secret-version-projectID" {
  secret = google_secret_manager_secret.projectID.id

  secret_data = var.projectID
}

resource "google_secret_manager_secret" "credentials" {
  secret_id = "math-robot-secret-credentials"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "credentials" {
  secret = google_secret_manager_secret.credentials.id

  secret_data = base64decode(google_service_account_key.for_function.private_key)
}
