# This file contains the main logic for the subnet module.
# This module creates a new Azure Subnet.

# The 'resource' block is used to create a new resource.
# This resource creates a new Azure Subnet.
resource "azurerm_subnet" "subnet" {
  # The name of the subnet. This is a required variable.
  name                 = var.name
  # The name of the resource group in which to create the subnet. This is a required variable.
  resource_group_name  = var.resource_group_name
  # The name of the virtual network in which to create the subnet. This is a required variable.
  virtual_network_name = var.virtual_network_name
  # The address prefixes for the subnet. This is a required variable.
  address_prefixes     = var.address_prefixes

  # The service endpoints to associate with the subnet. This is an optional variable.
  service_endpoints = var.service_endpoints

  # The 'dynamic' block is used to create multiple instances of a nested block.
  # In this case, it is used to create multiple 'delegation' blocks based on the 'subnet_delegation' variable.
  dynamic "delegation" {
    for_each = var.subnet_delegation
    content {
      name = delegation.value["name"]
      service_delegation {
        name    = delegation.value["service_name"]
        actions = delegation.value["service_actions"]
      }
    }
  }

  # Enable or Disable network policies for the private endpoint on the subnet. This is an optional variable.
  private_endpoint_network_policies_enabled     = var.private_endpoint_network_policies_enabled
  # Enable or Disable network policies for the private link service on the subnet. This is an optional variable.
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
}
