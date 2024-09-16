# Database output
output db_instance_address {
  description = "IP address of the master database instance"
  value = google_sql_database_instance.postgresql.ip_address
}
output db_instance_name {
  description = "Name of the database instance"
  value = google_sql_database_instance.postgresql.name
}
output db_instance_username {
  description = "Name of the database user" 
  value = "${var.db_user_name}"
}

