variable "simple_string" {
  description = "A simple string variable without validation and without default value"
  type        = string
}

variable "validated_string" {
  description = "A string variable with length validation (larger than 5) and no default value"
  type        = string
  validation {
    condition     = length(var.validated_string) >= 5
    error_message = "The validated_string variable must be at least 5 characters long."
  }
}

variable "default_string" {
  description = "A string variable with a default value and no validation"
  type        = string
  default     = "Hello, World!"
}

variable "simple_number" {
  description = "A simple number variable without validation and without default value"
  type        = number
}

variable "validated_number" {
  description = "A number variable with range validation (1-100) and no default value"
  type        = number
  validation {
    condition     = var.validated_number >= 1 && var.validated_number <= 100
    error_message = "The validated_number variable must be between 1 and 100."
  }
}

variable "default_number" {
  description = "A number variable with a default value and no validation"
  type        = number
  default     = 42
}

variable "complex_list" {
  description = "A complex list variable containing strings and numbers, with a default value"
  type        = list(any)
  default     = ["apple", 2, "banana", 4]
}

variable "complex_object" {
  description = "A complex object variable with nested lists and maps, and a default value"
  type = object({
    field1 = string
    field2 = list(any)
    field3 = map(string)
  })
  default = {
    field1 = "default_string"
    field2 = ["item1", 2, "item3"]
    field3 = {
      key1 = "value1"
      key2 = "value2"
    }
  }
}

variable "env_var_names" {
  description = "A map of environment variable names to retrieve their values"
  type        = map(string)
  default     = {}
}
