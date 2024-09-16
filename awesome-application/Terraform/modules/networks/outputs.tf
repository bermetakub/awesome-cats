output "vpc_name" {
  value = google_compute_network.vpc.name
}

# output "bastion_sa" {
#   value = google_service_account.bastion.email
# }

output "subnet" {
  value = google_compute_subnetwork.subnet.name
}

# output "ip" {
#   value       = google_compute_instance.bastion.network_interface.0.network_ip
#   description = "The IP address of the Bastion instance."
# }

# output "ssh" {
#   description = "GCloud ssh command to connect to the Bastion instance."
#   value       = "gcloud compute ssh ${google_compute_instance.bastion.name} --project ${var.project_id} --zone ${google_compute_instance.bastion.zone} -- -L 8888:127.0.0.1:8888"
# }

# output "kubectl_command" {
#   description = "kubectl command using the local proxy once the Bastion ssh command is running."
#   value       = "HTTPS_PROXY=localhost:8888 kubectl"
# }