
locals {
    routes = var.routes
}

resource "google_compute_network" "vpc" {
  name = var.name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode = var.routing_mode
}


resource "google_compute_subnetwork" "subnet" {
  name = var.public_subnet_name
  ip_cidr_range = var.subnet_CIDR
  region        = var.region
  network       = google_compute_network.vpc.id
}

# resource "google_service_account" "bastion" {
#   account_id = var.name
#   display_name = "GKE Bastion Service Account"
# }

# resource "google_project_iam_member" "bastion_sa_gke_admin" {
#   project = var.project_id
#   role    = "roles/container.admin"
#   member  = "serviceAccount:${google_service_account.bastion.email}"
# }

# resource "google_project_iam_member" "bastion_sa_compute_admin" {
#   project = var.project_id
#   role    = "roles/compute.admin"
#   member  = "serviceAccount:${google_service_account.bastion.email}"
# }

# resource "google_project_iam_member" "bastion_sa_iap_tunnel_user" {
#   project = var.project_id
#   role    = "roles/iap.tunnelResourceAccessor"
#   member  = "serviceAccount:${google_service_account.bastion.email}"
# }

# resource "google_compute_address" "internal_ip_add" {
#   project      = var.project_id
#   address_type = "INTERNAL"
#   region       = var.region
#   subnetwork   = google_compute_subnetwork.subnet.name
#   name         = "my-ip"
#   address      = var.authorized_ipv4_cidr_block
#   description  = "An internal IP address for my jump host"
# }

# resource "google_compute_instance" "bastion" {
#   name = var.name
#   machine_type = "e2-medium"
#   zone = var.zone
#   tags = ["bastion"]
#   project = var.project_id
#   boot_disk {
#     initialize_params {
#       image = "debian-12-bookworm-v20240815"
#       }
#     }

#   metadata_startup_script = file("${path.module}/startup-script.sh")
#   network_interface {
#     subnetwork = google_compute_subnetwork.subnet.name
#     network_ip         = google_compute_address.internal_ip_add.address
#   }
  
#   service_account {
#       email = google_service_account.bastion.email
#       scopes = ["cloud-platform"]
#   }
# }
#============================= FIREWALL RULES ================================
resource "google_compute_firewall" "rules" {
  for_each                = { for r in var.firewall_rules : r.name => r }
  name                    = each.value.name
  direction               = each.value.direction
  network                 = google_compute_network.vpc.id
  source_ranges           = each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges      = each.value.direction == "EGRESS" ? each.value.ranges : null
  source_tags             = each.value.source_tags
  target_tags             = each.value.target_tags

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}

resource "google_compute_router" "router" {
  project = var.project_id
  name = var.name
  region = var.region
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat_router" {
  project = var.project_id
  name = var.name
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  depends_on = [
    google_compute_subnetwork.subnet,
  ]
}

# ================================ ROUTES ===================================
resource "google_compute_route" "route" {
  for_each = { for route in local.routes : route.name => route }
  network = google_compute_network.vpc.id
  name                   = each.key
  description            = lookup(each.value, "description", null)
  tags                   = compact(split(",", lookup(each.value, "tags", "")))
  dest_range             = lookup(each.value, "destination_range", null)
  next_hop_gateway       = lookup(each.value, "next_hop_internet", "false") == "true" ? "default-internet-gateway" : null
  next_hop_ip            = lookup(each.value, "next_hop_ip", null)
  next_hop_instance      = lookup(each.value, "next_hop_instance", null)
  next_hop_instance_zone = lookup(each.value, "next_hop_instance_zone", null)
  next_hop_vpn_tunnel    = lookup(each.value, "next_hop_vpn_tunnel", null)
  next_hop_ilb           = lookup(each.value, "next_hop_ilb", null)
  priority               = lookup(each.value, "priority", null)
}