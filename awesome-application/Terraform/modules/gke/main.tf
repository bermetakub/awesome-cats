resource "google_container_cluster" "gke_cluster" {
  project = var.project_id
  name    = var.cluster_name
  location = var.location
  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  network    = var.network
  subnetwork = var.subnet_name
  network_policy {
    enabled = true
   }
   
  logging_service     = "logging.googleapis.com/kubernetes"
  monitoring_service  = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "gke_node_pool" {
  name        = var.node_pool_name
  location    = google_container_cluster.gke_cluster.location
  cluster     = google_container_cluster.gke_cluster.name
  initial_node_count = var.initial_node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    machine_type   = var.machine_type
    preemptible  = true
    disk_size_gb    = 50

    metadata = {
      disable-legacy-endpoint = true
    }

    oauth_scopes = var.oauth_scopes

    labels = {
      cluster = google_container_cluster.gke_cluster.name
    }
  }
}

