module "nodepool" {
  source             = "../.."
  gcp_project_id     = var.gcp_project_id
  gcp_region         = var.gcp_region
  gke_cluster_name   = var.gke_cluster_name
  gke_version_prefix = var.gke_version_prefix
  gke_nodepools      = var.gke_nodepools
  create_gke_cluster = var.create_gke_cluster
}
