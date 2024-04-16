output "WIF_PROVIDER"{
    value=google_iam_workload_identity_pool_provider.github.name
}
output "WIF_SERVICE_ACCOUNT"{
    value=google_service_account.push_image_to_gar.email
}
