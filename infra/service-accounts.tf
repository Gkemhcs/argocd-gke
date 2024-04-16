resource "google_service_account" "secret_accessor" {
  account_id   = "secret-accessor"
  display_name = "secret accessor used by k8s services for pull secrets from gcpsm "
}
resource "google_service_account" "push_image_to_gar" {
  account_id   = "image-pusher-to-gar"
  display_name = "push images to gar from github workflows"

}


resource "google_service_account_iam_binding" "secret_accessor_binding" {
  service_account_id = google_service_account.secret_accessor.name
  role               = "roles/iam.workloadIdentityUser"
  depends_on = [ google_container_cluster.cluster_us ]
  members = [
    "serviceAccount:${var.PROJECT_ID}.svc.id.goog[quote-ns/quote-secrets-sa]",
  ]
}

resource "google_service_account_iam_binding" "github_actions_binding" {
  service_account_id = google_service_account.push_image_to_gar.name 

  role               = "roles/iam.workloadIdentityUser"
 
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.workflow/IMAGE_PUSHER",
  ]
}
