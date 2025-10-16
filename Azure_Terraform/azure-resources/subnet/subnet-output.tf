# This file contains the outputs for the subnet module.
# Outputs are used to expose information about the resources created by the module.

# The 'output' block is used to define a new output.
# This output exposes the ID of the subnet.
output "id" {
  # The value of the output. In this case, it is the ID of the subnet created in the 'main.tf' file.
  value = azurerm_subnet.subnet.id
  # A description of the output.
  description = "The subnet ID."
}

# This output exposes the name of the subnet.
output "name" {
  # The value of the output.
  value = azurerm_subnet.subnet.name
  # A description of the output.
  description = "The name of the subnet."
}

# This output exposes the name of the resource group in which the subnet is created.
output "resource_group_name" {
  # The value of the output.
  value = azurerm_subnet.subnet.resource_group_name
  # A description of the output.
  description = "The name of the resource group in which the subnet is created in."
}

# This output exposes the name of the virtual network in which the subnet is created.
output "virtual_network_name" {
  # The value of the output.
  value = azurerm_subnet.subnet.virtual_network_name
  # A description of the output.
  description = "The name of the virtual network in which the subnet is created in"
}

# This output exposes the address prefixes of the subnet.
output "address_prefixes" {
  # The value of the output.
  value = azurerm_subnet.subnet.address_prefixes
  # A description of the output.
  description = "The address prefix for the subnet"
}
