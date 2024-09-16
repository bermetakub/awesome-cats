resource "google_sql_database_instance" "postgresql" {
  name = var.db_name
  project = var.project_id
  region = "${var.region}"
  database_version = "${var.db_version}"
  deletion_protection = false

  settings {
    tier = "${var.db_tier}"
    
    location_preference {
      zone = "${var.zone}"
    }

    ip_configuration {
      ipv4_enabled = "true"
      authorized_networks {
        value = "${var.db_instance_access_cidr}"
      }
    }
  }
}


# create database
#resource "google_sql_database" "postgresql_db" {
 # name = "${var.db_name}"
  #project = var.project_id
  #instance = "${google_sql_database_instance.postgresql.name}"
#}

resource "google_sql_user" "postgresql_user" {
  name = "${var.db_user_name}"
  project = var.project_id
  instance = "${google_sql_database_instance.postgresql.name}"
#   host = "${var.db_user_host}"
  password = "postgres"
}