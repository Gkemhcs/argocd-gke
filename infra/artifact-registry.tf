resource "google_artifact_registry_repository" "quote_repo" {
  location      = "us-central1"
  repository_id = "quote-repo"
  description   = "docker repository to store docker artifacts of quote generator api services"
  format        = "DOCKER"
}
resource "google_artifact_registry_repository_iam_binding" "github_actions" {
  project = var.PROJECT_ID
  location = google_artifact_registry_repository.quote_repo.location
  repository = google_artifact_registry_repository.quote_repo.name
  role = "roles/artifactregistry.createOnPushWriter"
  members = [
    "serviceAccount:${google_service_account.push_image_to_gar.email}",
  ]
}
