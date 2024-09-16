output "configure_kubectl_command_for_cluster" {
    value = "gcloud container clusters get-credentials ${module.google_kubernetes_cluster.name} --zone ${module.google_kubernetes_cluster.zone} --project ${module.google_kubernetes_cluster.project_id}"
}

 output "db_instance_address" {
    value = module.database.db_instance_address
}