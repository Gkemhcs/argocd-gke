resource "google_secret_manager_secret" "api_host" {
  secret_id = "API_HOST_URL"

  labels = {
    used-by = "quote-generator"
  }

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }

    }
  }
}
resource "google_secret_manager_secret_version" "api_host" {
  secret = google_secret_manager_secret.api_host.id

  secret_data = var.API_CREDS.API_HOST
}
resource "google_secret_manager_secret_iam_binding" "api_host_binding" {
  project = google_secret_manager_secret.api_host.project
  secret_id = google_secret_manager_secret.api_host.secret_id
  role = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.push_image_to_gar.email}",

  ]
}
resource "google_secret_manager_secret" "api_key" {
  secret_id = "API_KEY"

  labels = {
    used-by = "quote-generator"
  }

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }

    }
  }
}
resource "google_secret_manager_secret_version" "api_key" {
  secret = google_secret_manager_secret.api_key.id

  secret_data = var.API_CREDS.API_KEY
}
resource "google_secret_manager_secret_iam_binding" "api_key_binding" {
  project = google_secret_manager_secret.api_key.project
  secret_id = google_secret_manager_secret.api_key.secret_id
  role = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.push_image_to_gar.email}",
    
  ]
}