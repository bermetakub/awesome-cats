variable "credentials_file_path" {
  type = string
}

variable "project_id" {
  type    = string
  description = "Google Cloud Platform project ID"
}

variable "region" {
  type    = string
  description = "Google Cloud region"
}

variable "zone" {
  type    = string
  description = "Google Cloud zone"
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = []
}

variable "name" {
  type = string
  description = "Name that will be used as name of resources"
}

variable "subnet_CIDR" {
  description = "List of public subnets."
  type = string 
}


variable "firewall_rules" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = [
        {
      name        = "allow-iap-traffic"
      direction   = "INGRESS"
      ranges      = ["0.0.0.0/0"]
      target_tags = []
      source_tags = null

      allow = [{
        protocol = "tcp"
        ports    = ["22", "80", "443"]
      }]
      deny = []
    }
  ]
  type = list(object({
    name                    = string
    direction               = string
    ranges                  = list(string)
    source_tags             = list(string)
    target_tags             = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
  })) 
}

variable "initial_node_count" {
  description = "Initial number of nodes."
  type        = number
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

variable "dns_zone_name" {
  type = string
  description = "Name of the DNS zone"
}

