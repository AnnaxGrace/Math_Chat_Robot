resource "google_service_account" "service_account" {
  account_id   = "${var.editor}-${var.project_name}"
  display_name = "Account for apennington AI learning"
}

resource "google_service_account_key" "for_function" {
  service_account_id = google_service_account.service_account.name
}

resource "google_project_iam_member" "secret_access" {
  project = var.projectID
  role    = "roles/secretmanager.secretAccessor"
  member  = google_service_account.service_account.member
}

resource "google_project_iam_member" "ai_user" {
  project = var.projectID
  role    = "roles/aiplatform.user"
  member  = google_service_account.service_account.member
}
