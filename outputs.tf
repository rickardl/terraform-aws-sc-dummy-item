output "simple_string" {
  description = "The value of the simple_string variable"
  value       = var.simple_string
}

output "validated_string" {
  description = "The value of the validated_string variable"
  value       = var.validated_string
}

output "default_string" {
  description = "The value of the default_string variable"
  value       = var.default_string
}

output "simple_number" {
  description = "The value of the simple_number variable"
  value       = var.simple_number
}

output "validated_number" {
  description = "The value of the validated_number variable"
  value       = var.validated_number
}

output "default_number" {
  description = "The value of the default_number variable"
  value       = var.default_number
}

output "complex_list" {
  description = "The value of the complex_list variable"
  value       = var.complex_list
}

output "complex_object" {
  description = "The value of the complex_object variable"
  value       = var.complex_object
}

output "null_resource_id" {
  description = "value of the null_resource_id output"
  value       = module.main_module.null_resource_id
}

output "environment_variables" {
  description = "Non-sensitive environment variables of the machine running Terraform"
  value       = module.main_module.environment_variables
  sensitive   = true
}


output "example_variables_sensitive" {
  description = "Environment variables of the machine running Terraform"
  value       = module.main_module.example_variables_sensitive
  sensitive   = true
}
