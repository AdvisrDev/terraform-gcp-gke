module "gcp" {
  source         = "./modules/gcp"
  gcp_project_id = var.gcp_project_id
  gcp_region     = var.gcp_region
  gcp_network    = var.gcp_network
  gcp_subnetwork = var.gcp_subnetwork

  gke_cluster_name   = var.gke_cluster_name
  gke_cluster_labels = var.gke_cluster_labels
  gke_version_prefix = var.gke_version_prefix
  create_gke_cluster = var.create_gke_cluster

  gke_nodepools = var.gke_nodepools

  providers = {
    google = google.gcp
  }
}
