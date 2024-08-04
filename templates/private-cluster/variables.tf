variable "gcp_project_id" {
  type = string
}
variable "gcp_region" {
  type = string
}
variable "gcp_machine_type" {
  type = string
}
variable "gcp_service_account" {
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
variable "gke_num_nodes" {
  description = "number of gke nodes"
  type     = number
}
variable "tags" {
  type = list(string)
}
