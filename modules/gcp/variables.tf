variable "gcp_project_id" {
  type = string
}
variable "gcp_region" {
  type = string
}
variable "gcp_network" {
  type = string
}
variable "gcp_subnetwork" {
  type = string
}

variable "gke_cluster_name" {
  type = string
}
variable "gke_cluster_labels" {
  type = map(string)
}
variable "gke_version_prefix" {
  type = string
}
variable "create_gke_cluster" {
  type = bool
}


variable "gke_nodepools" {
  type = map(object({
    enable          = bool
    machine_type    = string
    service_account = string
    nodepool_labels = map(string)
    node_count      = number
    autoscaling = object({
      enable         = bool
      min_node_count = string
      max_node_count = string
    })
    node_locations = list(string)
    tags           = map(string)
    node_taints = object({
      key    = string
      value  = string
      effect = string
    })
    oauth_scopes = list(string)
    metadata     = any
  }))
}

