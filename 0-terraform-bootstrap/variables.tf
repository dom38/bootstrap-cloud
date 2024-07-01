variable "project_id" {
  description = "The ID of the project in which to create the cluster"
  type        = string
  default = "trial-404919"
}

variable "region" {
  description = "The region in which to create the cluster"
  type        = string
  default     = "europe-west1"
}

# variable "credentials_file" {
#   description = "The path to the GCP credentials JSON file"
#   type        = string
# }

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "bootstrap-cluster"
}
