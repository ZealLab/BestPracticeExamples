# This file contains the variables for the resource group module.
# Variables are used to parameterize the module, making it more reusable.

# The 'variable' block is used to define a new variable.
# This variable defines the name of the resource group.
variable "name" {
  # The type of the variable. In this case, it is a string.
  type = string
  # A description of the variable.
  description = "The name of the resource group. Must be unique on your Azure subscription."
}

# This variable defines the location of the resource group.
variable "location" {
  # The type of the variable.
  type    = string
  # The default value for the variable.
  default = "East US"
  # A description of the variable.
  description = "Geographic location of the Resource Group. Locations can be found at http://azure.microsoft.com/en-us/regions/"
}

# This variable defines the tags to apply to the resource group.
variable "tags" {
  # The type of the variable. In this case, it is a map of strings.
  type = map(string)
  # A description of the variable.
  description = <<DESCRIPTION
    A map of tags that will be applied to the resource group.
    Should include the following:
      - Department
      - EnvironmentType
      - ResourceOwner
      - ResourceOwnerManager
  DESCRIPTION
}

# This variable determines whether to apply a lock to the resource group.
variable "lock_resource" {
  # The type of the variable.
  type    = bool
  # The default value for the variable.
  default = false
  # A description of the variable.
  description = "Enable or disable the resource lock."
}

# This variable determines the type of lock to apply to the resource group.
variable "read_only" {
  # The type of the variable.
  type    = bool
  # The default value for the variable.
  default = false
  # A description of the variable.
  description = "Set the resource lock to read-only."
}