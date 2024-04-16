resource "google_compute_network" "vpc_network" {
  name                    = "quote-api-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnet_us" {
  name          = "subnet-us"
  region        = "us-central1"
  ip_cidr_range = "192.168.5.0/24"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range = [{
    range_name    = "pods"
    ip_cidr_range = "192.168.1.0/24"
    }
    , {
      range_name    = "services"
      ip_cidr_range = "192.168.2.0/24"
  }]

}
resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "proxy-us"
  ip_cidr_range = "192.168.3.0/24"
  region        = "us-central1"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = google_compute_network.vpc_network.id
}
