variable "project_id" {
  description = "Project ID where the GKE cluster will be created."
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster."
  type        = string
}

variable "location" {
  description = "Region or zone for GKE cluster."
  type        = string
}

variable "initial_node_count" {
  description = "Initial number of nodes."
  type        = number
  default     = 1
}

variable "network" {
  description = "VPC network name."
  type        = string
}

variable "subnet_name" {
  description = "Subnet name where the GKE cluster will be created."
  type        = string
}

variable "node_pool_name" {
  description = "Name of the node pool."
  type        = string
}

variable "min_node_count" {
  description = "Minimum number of nodes for autoscaling."
  type        = number
}

variable "max_node_count" {
  description = "Maximum number of nodes for autoscaling."
  type        = number
}

variable "machine_type" {
  description = "Machine type for nodes."
  type        = string
}

variable "oauth_scopes" {
  description = "OAuth scopes for node instances."
  type        = list(string)
  default = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/cloud-platform",
  ]
}

