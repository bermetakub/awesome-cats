variable "project_id" {
  type = string
  description = "The project ID to host the network in."
}
variable "region" {
  type = string
  description = "The project ID to host the network in."
  default = "us-central1"
}

variable "zone" {
  type = string
  description = "GCP zone"
}


variable db_version {
  description = "The version of of the database. For example, POSTGRES_9_6 or POSTGRES_11"
  default = "POSTGRES_11"
}
variable db_tier {
  description = "The machine tier (First Generation) or type (Second Generation). Reference: https://cloud.google.com/sql/pricing"
  default = "db-f1-micro"
}

variable db_instance_access_cidr {
  description = "The IPv4 CIDR to provide access the database instance"
  default = "0.0.0.0/0"
}
# database settings
variable db_name {
  description = "Name of the default database to create"
  default = "postgres"
}

# user settings
variable db_user_name {
  description = "The name of the default user"
  default = "postgres"
}
# variable db_user_host {
#   description = "The host for the default user"
#   default = "%"
# }
variable db_user_password {
  description = "The password for the default user. If not set, a  random one will be generated and available in the  generated_user_password output variable."
  default = "postgres"
}
