project_id = "monitoring-433016"
region = "us-central1"
zone = "us-central1-a"
credentials_file_path = "./monitoring.json"
name = "bermet"
routes = [ {
    name              = "igw-route"
    destination_range = "0.0.0.0/0"
    next_hop_internet = "true"
} ]
subnet_CIDR = "10.0.0.0/24"
initial_node_count = 2
min_node_count = 1
max_node_count = 4
machine_type = "e2-medium"
dns_zone_name = "project"