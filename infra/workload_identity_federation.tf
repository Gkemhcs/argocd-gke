resource "google_iam_workload_identity_pool" "github_actions" {
  workload_identity_pool_id = "github-actions"
  display_name              = "GITHUB ACTIONS POOL"
}
resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"
  attribute_condition = "attribute.repository == \"${var.GITHUB_REPO}\""
  attribute_mapping                  = {
    "google.subject" = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.workflow" =  "assertion.workflow"
  }
  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
}
