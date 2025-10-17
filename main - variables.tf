variable "gcp_project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_network" {
  type    = string
  default = ""
}

variable "gcp_subnetwork" {
  type    = string
  default = ""
}

variable "gke_cluster_name" {
  type = string
}

variable "gke_cluster_labels" {
  type    = map(string)
  default = {}
}

variable "gke_version_prefix" {
  type = string
}

variable "create_gke_cluster" {
  type = bool
}

variable "gke_nodepools" {
  type = map(object({
    enable          = optional(bool, true)
    machine_type    = string
    service_account = string
    nodepool_labels = optional(map(string), {})
    node_count      = optional(number, 1)
    autoscaling = optional(object({
      enable         = optional(bool, true)
      min_node_count = optional(number, 1)
      max_node_count = optional(number, 2)
    }))
    node_locations = list(string)
    tags           = optional(list(string))
    node_taints = optional(map(object({
      key    = string
      value  = string
      effect = string
    })))
    oauth_scopes = optional(list(string), [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ])
    metadata = optional(any, {
      "disable-legacy-endpoints" : true
    })
  }))
}

