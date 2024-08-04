output "region" {
  value       = module.terraform-gcp-gke.region
  description = "GCloud Region"
}

output "project_id" {
  value       = module.terraform-gcp-gke.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.terraform-gcp-gke.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "gke_endpoint" {
  value       = module.terraform-gcp-gke.gke_endpoint
  description = "GKE Cluster Host"
}

output "gke_cluster_ca_certificate" {
  value       = module.terraform-gcp-gke.gke_cluster_ca_certificate
  description = "GKE Cluster Certificate"
}