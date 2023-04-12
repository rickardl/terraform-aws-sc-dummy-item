# Main Module

This Terraform module retrieves specified environment variables from the machine running Terraform and returns their values as a map in the output.

## Usage

To use this module in your Terraform configuration, add the following code:

```hcl
module "main_module" {
  source = "./modules/main_module"

  env_var_names = {
    "ENV_VAR_1",
    "ENV_VAR_2",
    "ENV_VAR_3",
  }
}
