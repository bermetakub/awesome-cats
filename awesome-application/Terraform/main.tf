# terraform {
#   backend "gcs" {
#     bucket = "tfstate-for-final-project"
#     prefix = "tfstate"
#     #credentials = "creds.json"
#   }
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "6.0.0"
#     }
#   }
# }

# data "kubernetes_cluster" "example" {
#   config_path = module.google_container_cluster.primary.kube_config[0].raw
# }

provider "google" {
  credentials = file(var.credentials_file_path)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

locals {
    routes = var.routes
}

module "google_networks" {
  source = "./modules/networks"

  region = var.region
  zone = var.zone
  project_id = var.project_id
  routes = var.routes
  name = var.name
  subnet_CIDR = var.subnet_CIDR
  firewall_rules = var.firewall_rules
  # authorized_ipv4_cidr_block = var.bastion_ip
}

module "google_kubernetes_cluster" {
  source = "./modules/gke"

  project_id = var.project_id
  cluster_name = var.name
  location = var.zone
  initial_node_count = var.initial_node_count
  network = module.google_networks.vpc_name
  subnet_name = module.google_networks.subnet
  node_pool_name = var.name
  max_node_count = var.max_node_count
  min_node_count = var.min_node_count
  machine_type = var.machine_type
}

module "google_dns_managed_zone" {
  source         = "./modules/dns"
  project_id     = var.project_id
  region          = var.region
  dns_zone_name  = var.dns_zone_name
  dns_name        = "alymkulovabk.online."
}

module "database" {
  source = "./modules/database"
  region = var.region
  project_id = var.project_id
  zone = var.zone
}