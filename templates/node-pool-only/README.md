## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp"></a> [gcp](#module\_gcp) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | n/a | `string` | n/a | yes |
| <a name="input_gke_cluster_name"></a> [gke\_cluster\_name](#input\_gke\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_gke_nodepools"></a> [gke\_nodepools](#input\_gke\_nodepools) | n/a | <pre>map(object({<br/>    enable          = optional(bool, true)<br/>    machine_type    = string<br/>    service_account = string<br/>    nodepool_labels = optional(map(string), {})<br/>    node_count      = optional(number, 1)<br/>    autoscaling = optional(object({<br/>      enable         = optional(bool, true)<br/>      min_node_count = optional(number, 1)<br/>      max_node_count = optional(number, 2)<br/>    }))<br/>    node_locations = list(string)<br/>    tags           = optional(map(string), {})<br/>    node_taints = optional(map(object({<br/>      key    = string<br/>      value  = string<br/>      effect = string<br/>    })))<br/>    oauth_scopes = optional(list(string), [<br/>      "https://www.googleapis.com/auth/cloud-platform",<br/>      "https://www.googleapis.com/auth/logging.write",<br/>      "https://www.googleapis.com/auth/monitoring"<br/>    ])<br/>    metadata = optional(any, {<br/>      "disable-legacy-endpoints" : true<br/>    })<br/>  }))</pre> | n/a | yes |
| <a name="input_gke_version_prefix"></a> [gke\_version\_prefix](#input\_gke\_version\_prefix) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gke_cluster_ca_certificate"></a> [gke\_cluster\_ca\_certificate](#output\_gke\_cluster\_ca\_certificate) | GKE Cluster Certificate |
| <a name="output_gke_endpoint"></a> [gke\_endpoint](#output\_gke\_endpoint) | GKE Cluster Host |
| <a name="output_gke_nodepools"></a> [gke\_nodepools](#output\_gke\_nodepools) | GKE Node Pools available |
| <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name) | GKE Cluster Name |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | GCloud Project ID |
| <a name="output_region"></a> [region](#output\_region) | GCloud Region |
