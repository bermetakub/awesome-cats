output "name" {
    value = google_container_cluster.gke_cluster.name
    description = "The Kubernetes cluster name."
}

output "project_id" {
    value = google_container_cluster.gke_cluster.project
}

output "zone" {
    value = google_container_cluster.gke_cluster.location
}

