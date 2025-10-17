output "region" {
  value       = module.nodepool.region
  description = "GCloud Region"
}

output "project_id" {
  value       = module.nodepool.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.nodepool.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "gke_endpoint" {
  value       = module.nodepool.gke_endpoint
  description = "GKE Cluster Host"
}

output "gke_cluster_ca_certificate" {
  value       = module.nodepool.gke_cluster_ca_certificate
  description = "GKE Cluster Certificate"
}

output "gke_nodepools" {
  value       = module.nodepool.gke_nodepools
  description = "GKE Node Pools available"
}
