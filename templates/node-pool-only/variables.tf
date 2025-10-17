variable "gcp_project_id" {
  type    = string
}

variable "gcp_region" {
  type    = string
}

variable "gcp_machine_type" {
  type    = string
}

variable "gcp_service_account" {
  type    = string
}

variable "gcp_network" {
  type    = string
  default = "default"
}

variable "gcp_subnetwork" {
  type    = string
  default = "default"
}

variable "gke_cluster_name" {
  type    = string
}
variable "gke_nodepool_name" {
  type    = string
}

variable "gke_cluster_labels" {
  type    = map(string)
  default = {
    environment = "dev"
    owner       = "terraform"
  }
}

variable "gke_version_prefix" {
  type    = string
  default = "1.29."
}

variable "gke_num_nodes" {
  description = "number of gke nodes"
  type        = number
  default     = 2
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "create_gke_cluster" {
  type    = bool
  default = false
}

variable "enable_autoscaling" {
  type    = bool
  default = false
}

variable "min_node_count" {
  type    = number
  default = 1
}

variable "max_node_count" {
  type    = number
  default = 3
}

variable "node_taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string   # Ejemplo: "NO_SCHEDULE", "PREFER_NO_SCHEDULE", "NO_EXECUTE"
  }))
  default = []
}
