variable "projectID" {
  description = "This is the project ID where are you using the API. This is the project that will be billed"
}

variable "projectNumber" {
  description = "This is the project number where are you using the API. This is the project that will be billed"
}

# variable "GCP_key" {
#   description = "This is the JSON of your service account"
# }

# variable "service_account_email" {
#   description = "This is the email of your service account that your function will use"
# }

variable "region" {
  description = "This is the region where you want to provison resources"
  default     = "us-central1"
}

variable "zone" {
  description = "This is the zone in the region where you want to provison resources"
  default     = "us-central1-c"
}

variable "editor" {
  description = "The individual who is creating/editing this infrastructure"
}

variable "project_name" {
  description = "This will be used in your resource creation to help organize them"
  default     = "math-robot-learn"
}

