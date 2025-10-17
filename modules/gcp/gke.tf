# GCP Config
data "google_client_config" "default" {}
data "google_service_account" "sa" {
  for_each   = { for k, v in var.gke_nodepools : k => v if v.enable }
  account_id = each.value.service_account
}
data "google_container_engine_versions" "gke_version" {
  location       = var.gcp_region
  version_prefix = var.gke_version_prefix
}

resource "google_container_cluster" "primary" {
  count                    = var.create_gke_cluster ? 1 : 0
  name                     = var.gke_cluster_name
  location                 = var.gcp_region
  deletion_protection      = false
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.gcp_network
  subnetwork               = var.gcp_subnetwork
  resource_labels          = var.gke_cluster_labels
}

data "google_container_cluster" "existing" {
  count    = var.create_gke_cluster ? 0 : 1
  name     = var.gke_cluster_name
  location = var.gcp_region
}

data "google_container_cluster" "post_create" {
  name       = var.gke_cluster_name
  location   = var.gcp_region
  depends_on = [google_container_cluster.primary, google_container_node_pool.primary_nodes]
}

# Selecciona el nombre del cluster según el caso
locals {
  gke_cluster_name = var.create_gke_cluster ? google_container_cluster.primary[0].name : data.google_container_cluster.existing[0].name
}

# Node Pool siempre usa el cluster correcto
resource "google_container_node_pool" "primary_nodes" {
  for_each = { for k, v in var.gke_nodepools : k => v if v.enable }

  name     = each.key
  location = var.gcp_region
  cluster  = local.gke_cluster_name
  version  = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]

  # Autoscaling y node_count son mutuamente excluyentes
  dynamic "autoscaling" {
    for_each = each.value.autoscaling.enable ? [1] : []
    content {
      min_node_count = each.value.autoscaling.min_node_count
      max_node_count = each.value.autoscaling.max_node_count
    }
  }
  node_count = each.value.autoscaling.enable ? null : each.value.node_count

  node_locations = each.value.node_locations

  node_config {
    service_account = data.google_service_account.sa[each.key].email
    oauth_scopes    = each.value.oauth_scopes

    labels = merge(
      var.gke_cluster_labels,
      each.value.nodepool_labels
    )

    machine_type = each.value.machine_type
    tags         = each.value.tags

    metadata = each.value.metadata

    # Node Taints para controlar el scheduling, por ejemplo NO_SCHEDULE
    dynamic "taint" {
      for_each = each.value.node_taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect # ejemplo: "NO_SCHEDULE"
      }
    }
  }
}

