variable "region" {
  type = string
  default = "us-west1"
}

variable "zone" {
  type = string
  default = "us-west1-b"
}

variable "project_id" {
  description = "Project ID where the GKE cluster will be created."
  type        = string
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = [
   {
      name              = "igw"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    }
  ]
}

variable "name" {
  type = string
  description = "The name to use"  
  default = "bermet"
}

variable "auto_create_subnetworks" {
  description = "It will create a subnet for each region automatically across the across CIDR-block range, if it is <true> "
  type = bool
  default = false
}

variable "routing_mode" {
  description = "The network routing mode"
  type = string
  default = "GLOBAL"
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type = string
  default = "public"
}

variable "subnet_CIDR" {
  description = "List of public subnets."
  type = string
  default = "10.100.0.0/16"  
}

# variable "authorized_ipv4_cidr_block" {
#   description = "CIDR block for master authorized networks."
#   type        = string
#   default     = null
# }

#===========================FIREWALL_RULES============================

variable "firewall_rules" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = []
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