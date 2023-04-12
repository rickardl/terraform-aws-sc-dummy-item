variable "env_var_names" {
  description = "A map of environment variable names to retrieve their values"
  type        = map(string)
  default     = {}
}
