output "environment_variables" {
  description = "Non-sensitive environment variables of the machine running Terraform"
  value = {
    for key, value in data.env_variable.env_vars : key => value.value
  }
}

output "null_resource_id" {
  value = null_resource.this.id
}

output "example_variables_sensitive" {
  description = "Environment variables of the machine running Terraform"
  value = {
    "DATABASE_PASSWORD" = sensitive("password")
    "DATABASE_USERNAME" = sensitive("username")
    "HOSTNAME"          = "localhost"
  }

  sensitive = true
}
