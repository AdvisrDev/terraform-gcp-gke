module "terraform-gcp-gke" {
  source = "../.."
  tags                = var.tags
  gcp_region          = var.gcp_region
  gcp_project_id      = var.gcp_project_id
  gcp_machine_type    = var.gcp_machine_type
  gcp_service_account = var.gcp_service_account
  gcp_network         = var.gcp_network
  gcp_subnetwork      = var.gcp_subnetwork

  gke_version_prefix = var.gke_version_prefix
  gke_num_nodes      = var.gke_num_nodes
  gke_cluster_labels = var.gke_cluster_labels
  gke_cluster_name   = var.gke_cluster_name
  gke_nodepool_name  = var.gke_nodepool_name

  create_gke_cluster       = var.create_gke_cluster

  enable_autoscaling       = var.enable_autoscaling
  min_node_count           = var.min_node_count
  max_node_count           = var.max_node_count

  node_taints              = var.node_taints
}