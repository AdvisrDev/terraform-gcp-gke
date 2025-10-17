output "gke" {
  value = {
    cluster_ca_certificate = (
      var.create_gke_cluster
        ? google_container_cluster.primary[0].master_auth[0].cluster_ca_certificate
        : data.google_container_cluster.existing[0].master_auth[0].cluster_ca_certificate
    )
    endpoint = (
      var.create_gke_cluster
        ? google_container_cluster.primary[0].endpoint
        : data.google_container_cluster.existing[0].endpoint
    )
    name = (
      var.create_gke_cluster
        ? google_container_cluster.primary[0].name
        : data.google_container_cluster.existing[0].name
    )
    nodepools = data.google_container_cluster.existing.node_pool[*].name
  }
}

