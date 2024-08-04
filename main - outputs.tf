output "region" {
  value       = var.gcp_region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.gcp_project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.gcp.gke.name
  description = "GKE Cluster Name"
}

output "gke_endpoint" {
  value       = module.gcp.gke.endpoint
  description = "GKE Cluster Host"
}

output "gke_cluster_ca_certificate" {
  value       = module.gcp.gke.cluster_ca_certificate
  description = "GKE Cluster Certificate"
}