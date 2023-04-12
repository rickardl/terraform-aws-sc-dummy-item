resource "null_resource" "this" {}


data "env_variable" "env_vars" {
  for_each = var.env_var_names
  name     = each.value
}
