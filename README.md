# terraform-aws-sc-dummy-item

This Terraform project is designed to test the input and output handling of AWS Service Catalog, which now offers Terraform support. The purpose is to ensure the correct handling of various Terraform data types in variables and outputs when used with AWS Service Catalog.

## Dummy Data for the Catalog

* **Product name:** terraform-aws-sc-dummy-item

* **Product description (optional):** A Terraform Service Catalog item for testing AWS Service Catalog integration with support for various complex input and output data types.
* **Version name (optional):** v1.0.0
* **Owner:** ACME Cloud Engineering
* **Distributor (optional):** ACME Cloud Engineering

## Supported Data Types in Terraform

Terraform supports several data types for variables and outputs, which include:

* `string`: Represents a sequence of characters.
* `number`: Represents numeric values, including integers and floating-point numbers.
* `bool`: Represents a boolean value, either `true` or `false`.
* `list(<TYPE>)` or `tuple([<TYPE>, ...])`: Represents a sequence of values of the specified type(s).
* `set(<TYPE>)`: Represents an unordered collection of unique values of the specified type.
* `map(<TYPE>)` or `object({key = <TYPE>, ...})`: Represents a collection of key-value pairs, where keys are strings, and values are of the specified type(s).
* `any`: Represents a value of any type.

### Validation in Terraform Variables

Terraform allows you to add validation rules to your input variables using the `validation` block. This helps to ensure that the values passed to your modules meet specific criteria before they are used in the configuration. You can define custom error messages to provide better feedback when incorrect values are provided.

Example of a validation block:

```hcl
variable "instance_type" {
  type        = string
  description = "EC2 instance type"

  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium"], var.instance_type)
    error_message = "The instance_type must be one of: t2.micro, t2.small, t2.medium."
  }
}
````

In this example, the condition checks whether the provided instance_type is one of the allowed types. If not, it will display the custom error_message.

## Project Structure

```text
terraform-aws-sc-dummy-item/
├── main.tf
├── providers.tf
├── versions.tf
└── modules/
    └── main_module/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

This project structure includes a top-level directory with the main Terraform configuration files, and a `main_module` within the `modules` directory. The `main_module` is responsible for retrieving specified environment variables and outputting their values as a map.

For more information on Terraform data types, variables, and validation, refer to the Terraform documentation:

* [Input Variables](https://www.terraform.io/docs/language/values/variables.html)
* [Output Values](https://www.terraform.io/docs/language/values/outputs.html)
* [Type Constraints](https://www.terraform.io/docs/language/expressions/type-constraints.html)
* [Variable Validation](https://www.terraform.io/docs/language/values/variables.html#custom-validation-rules)

## Module Variables and Outputs

### Terraform Variables File

This is a reference output of the variables and outputs defined in the catalog item, with the included tfvars file.

| Variable Name    | Value                                                                                                           | Description                                                                   | Default Value                                                                                                                          | Source        |
| ---------------- | --------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| simple_string    | Test string                                                                                                     | A simple string variable without validation and without default value         | -                                                                                                                                      | tfvars        |
| validated_string | Validated string                                                                                                | A string variable with length validation (larger than 5) and no default value | -                                                                                                                                      | tfvars        |
| default_string   | Hello, World!                                                                                                   | A string variable with a default value and no validation                      | Hello, World!                                                                                                                          | default value |
| simple_number    | 10                                                                                                              | A simple number variable without validation and without default value         | -                                                                                                                                      | tfvars        |
| validated_number | 25                                                                                                              | A number variable with range validation (1-100) and no default value          | -                                                                                                                                      | tfvars        |
| default_number   | 42                                                                                                              | A number variable with a default value and no validation                      | 42                                                                                                                                     | default value |
| complex_list     | ['apple', '2', 'banana', '4']                                                                                   | A complex list variable containing strings and numbers, with a default value  | ['apple', 2, 'banana', 4]                                                                                                              | default value |
| complex_object   | {'field1': 'default_string', 'field2': ['item1', '2', 'item3'], 'field3': {'key1': 'value1', 'key2': 'value2'}} | A complex object variable with nested lists and maps, and a default value     | {<br> field1 = "default_string"<br> field2 = ["item1", 2, "item3"]<br> field3 = {<br>  key1 = "value1"<br>  key2 = "value2"<br> }<br>} | default value |

### Without tfvars file

without the values provided by the tfvars file. Here's an updated table that reflects this, here we enter the required variables manually.:

| Key                         | Value                                                        | Description                                                  | Source       |
| --------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------ |
| complex_list                | ['apple', '2', 'banana', '4']                                | A complex list variable containing strings and numbers, with a default value | variables.tf |
| complex_object              | {'field1': 'default_string', 'field2': ['item1', '2', 'item3'], 'field3': {'key1': 'value1', 'key2': 'value2'}} | A complex object variable with nested lists and maps, and a default value | variables.tf |
| default_number              | 42                                                           | A number variable with a default value and no validation     | variables.tf |
| default_string              | Hello, World!                                                | A string variable with a default value and no validation     | variables.tf |
| environment_variables       | (sensitive value)                                            | A sensitive string variable that should be populated with a value from an environment variable | variables.tf |
| example_variables_sensitive | (sensitive value)                                            | An example of a sensitive string variable                    | manual       |
| null_resource_id            | 1938533224326765545                                          | An ID generated by the null_resource                         | variables.tf |
| ResourceGroupARN            | arn:aws:resource-groups:eu-north-1:365853257337:group/SC-365853257337-pp-cwsc5kuvszhfg | The ARN of the associated Resource Group                     | variables.tf |
| simple_number               | 70                                                           | A simple number variable without validation and without default value | manual       |
| simple_string               | This is a test string                                        | A simple string variable without validation and without default value | manual       |
| validated_number            | 50                                                           | A number variable with range validation (1-100) and no default value | manual       |
| validated_string            | dsfsdfsdfsdf                                                 | A string variable with length validation (larger than 5) and no default value | manual       |


## Deployment

This module comes with a Makefile to help automate various tasks.

### Targets

You can exclude the .tfvars file using `EXCLUDE_TFVARS=true` when running the `make` command for the `package` and `validate-package` targets.

* `fmt`: Formats all Terraform files in the project.
* `validate`: Validates the Terraform module using `terraform fmt` and `terraform validate`.
* `package`: Packages the contents of the module into a `.tar.gz` file, excluding unnecessary files as specified in the `.gitignore` file.
* `validate-package`: Extracts the contents of the `.tar.gz` file and compares the structure and contents with the original module.
* `clean`: Deletes the packaged archive.

## Requirements

| Name                                                                      | Version  |
| ------------------------------------------------------------------------- | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_env"></a> [env](#requirement\_env)                   | 0.0.2    |
| <a name="requirement_null"></a> [null](#requirement\_null)                | ~> 3.0   |

## Providers

No providers.

## Modules

| Name                                                                    | Source                | Version |
| ----------------------------------------------------------------------- | --------------------- | ------- |
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ./modules/main_module | n/a     |

## Resources

No resources.

## Inputs

| Name                                                                                 | Description                                                                   | Type                                                                                                     | Default                                                                                                                                                                                       | Required |
| ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_complex_list"></a> [complex\_list](#input\_complex\_list)             | A complex list variable containing strings and numbers, with a default value  | `list(any)`                                                                                              | <pre>[<br>  "apple",<br>  2,<br>  "banana",<br>  4<br>]</pre>                                                                                                                                 |    no    |
| <a name="input_complex_object"></a> [complex\_object](#input\_complex\_object)       | A complex object variable with nested lists and maps, and a default value     | <pre>object({<br>    field1 = string<br>    field2 = list(any)<br>    field3 = map(string)<br>  })</pre> | <pre>{<br>  "field1": "default_string",<br>  "field2": [<br>    "item1",<br>    2,<br>    "item3"<br>  ],<br>  "field3": {<br>    "key1": "value1",<br>    "key2": "value2"<br>  }<br>}</pre> |    no    |
| <a name="input_default_number"></a> [default\_number](#input\_default\_number)       | A number variable with a default value and no validation                      | `number`                                                                                                 | `42`                                                                                                                                                                                          |    no    |
| <a name="input_default_string"></a> [default\_string](#input\_default\_string)       | A string variable with a default value and no validation                      | `string`                                                                                                 | `"Hello, World!"`                                                                                                                                                                             |    no    |
| <a name="input_env_var_names"></a> [env\_var\_names](#input\_env\_var\_names)        | A map of environment variable names to retrieve their values                  | `map(string)`                                                                                            | `{}`                                                                                                                                                                                          |    no    |
| <a name="input_simple_number"></a> [simple\_number](#input\_simple\_number)          | A simple number variable without validation and without default value         | `number`                                                                                                 | n/a                                                                                                                                                                                           |   yes    |
| <a name="input_simple_string"></a> [simple\_string](#input\_simple\_string)          | A simple string variable without validation and without default value         | `string`                                                                                                 | n/a                                                                                                                                                                                           |   yes    |
| <a name="input_validated_number"></a> [validated\_number](#input\_validated\_number) | A number variable with range validation (1-100) and no default value          | `number`                                                                                                 | n/a                                                                                                                                                                                           |   yes    |
| <a name="input_validated_string"></a> [validated\_string](#input\_validated\_string) | A string variable with length validation (larger than 5) and no default value | `string`                                                                                                 | n/a                                                                                                                                                                                           |   yes    |

## Outputs

| Name                                                                                                                      | Description                                                          |
| ------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| <a name="output_complex_list"></a> [complex\_list](#output\_complex\_list)                                                | The value of the complex\_list variable                              |
| <a name="output_complex_object"></a> [complex\_object](#output\_complex\_object)                                          | The value of the complex\_object variable                            |
| <a name="output_default_number"></a> [default\_number](#output\_default\_number)                                          | The value of the default\_number variable                            |
| <a name="output_default_string"></a> [default\_string](#output\_default\_string)                                          | The value of the default\_string variable                            |
| <a name="output_environment_variables"></a> [environment\_variables](#output\_environment\_variables)                     | Non-sensitive environment variables of the machine running Terraform |
| <a name="output_example_variables_sensitive"></a> [example\_variables\_sensitive](#output\_example\_variables\_sensitive) | Environment variables of the machine running Terraform               |
| <a name="output_null_resource_id"></a> [null\_resource\_id](#output\_null\_resource\_id)                                  | value of the null\_resource\_id output                               |
| <a name="output_simple_number"></a> [simple\_number](#output\_simple\_number)                                             | The value of the simple\_number variable                             |
| <a name="output_simple_string"></a> [simple\_string](#output\_simple\_string)                                             | The value of the simple\_string variable                             |
| <a name="output_validated_number"></a> [validated\_number](#output\_validated\_number)                                    | The value of the validated\_number variable                          |
| <a name="output_validated_string"></a> [validated\_string](#output\_validated\_string)                                    | The value of the validated\_string variable                          |
