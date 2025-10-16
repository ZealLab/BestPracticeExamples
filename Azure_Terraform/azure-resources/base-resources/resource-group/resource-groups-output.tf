# This file contains the outputs for the resource group module.
# Outputs are used to expose information about the resources created by the module.

# The 'output' block is used to define a new output.
# This output exposes the ID of the resource group.
output "id" {
  # The value of the output. In this case, it is the ID of the resource group created in the 'main.tf' file.
  value = azurerm_resource_group.resource_group.id
  # A description of the output.
  description = "The resource group ID."
}

# This output exposes the name of the resource group.
output "name" {
  # The value of the output.
  value = azurerm_resource_group.resource_group.name
  # A description of the output.
  description = "The resource group name. Can be used else where."
}

# This output exposes the location of the resource group.
output "location" {
  # The value of the output.
  value = azurerm_resource_group.resource_group.location
  # A description of the output.
  description = "The resource group location. Can be used else where."
}

# This output exposes information about the current Azure subscription.
output "subscription_info" {
  # The value of the output.
  value = data.azurerm_subscription.subscription
  # A description of the output.
  description = "Details about the current Subscription"
}
