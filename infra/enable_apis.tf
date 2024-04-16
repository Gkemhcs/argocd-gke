resource "google_project_service" "enable_services" {
  for_each = toset(var.services)
  project  = var.PROJECT_ID
  service = each.value
}
