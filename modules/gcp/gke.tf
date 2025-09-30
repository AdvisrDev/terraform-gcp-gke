# GCP Config
data "google_client_config" "default" {}
data "google_service_account" "sa" {
  account_id = var.gcp_service_account
}

data "google_container_engine_versions" "gke_version" {
  location       = var.gcp_region
  version_prefix = var.gke_version_prefix
}

resource "google_container_cluster" "primary" {
  count              = var.create_gke_cluster ? 1 : 0
  name               = var.gke_cluster_name
  location           = var.gcp_region
  deletion_protection = false
  remove_default_node_pool = true
  initial_node_count = 1
  network    = var.gcp_network
  subnetwork = var.gcp_subnetwork

  resource_labels = merge(
    var.gke_cluster_labels,
    {
      env     = var.gcp_project_id
      cluster = var.gke_cluster_name
    }
  )
}

data "google_container_cluster" "existing" {
  count    = var.create_gke_cluster ? 0 : 1
  name     = var.gke_cluster_name
  location = var.gcp_region
}

data "google_container_node_pools" "existing" {
  count    = var.create_gke_cluster ? 0 : 1
  cluster  = var.gke_cluster_name
  location = var.gcp_region
  depends_on = [google_container_node_pool.primary_nodes]
}

# Selecciona el nombre del cluster según el caso
locals {
  gke_cluster_name = var.create_gke_cluster ? google_container_cluster.primary[0].name : data.google_container_cluster.existing[0].name
}

# Node Pool siempre usa el cluster correcto
resource "google_container_node_pool" "primary_nodes" {
  name     = "${local.gke_cluster_name}-primary"
  location = var.gcp_region
  cluster  = local.gke_cluster_name

  version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]

  # Autoscaling y node_count son mutuamente excluyentes
  dynamic "autoscaling" {
    for_each = var.enable_autoscaling ? [1] : []
    content {
      min_node_count = var.min_node_count
      max_node_count = var.max_node_count
    }
  }
  node_count = var.enable_autoscaling ? null : var.gke_num_nodes

  node_locations = [
    "${var.gcp_region}-c"
  ]

  node_config {
    service_account = data.google_service_account.sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = merge(
      var.gke_cluster_labels,
      {
        env     = var.gcp_project_id
        cluster = local.gke_cluster_name_final
      }
    )

    machine_type = var.gcp_machine_type
    tags         = var.tags

    metadata = {
      disable-legacy-endpoints = "true"
    }

    # Node Taints para controlar el scheduling, por ejemplo NO_SCHEDULE
    dynamic "taint" {
      for_each = var.node_taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect # ejemplo: "NO_SCHEDULE"
      }
    }
  }
}

