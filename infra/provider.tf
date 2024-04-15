terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"  # Specify a version constraint (more on this below)
    }
  }
}

provider "google" {
  project=var.PROJECT_ID
}
