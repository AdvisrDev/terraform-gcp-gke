output "region" {
  value       = module.gke.region
  description = "GCloud Region"
}

output "project_id" {
  value       = module.gke.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.gke.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "gke_endpoint" {
  value       = module.gke.gke_endpoint
  description = "GKE Cluster Host"
}

output "gke_cluster_ca_certificate" {
  value       = module.gke.gke_cluster_ca_certificate
  description = "GKE Cluster Certificate"
}

output "gke_nodepools" {
  value       = module.gke.nodepools
  description = "GKE Node Pools available"
}
