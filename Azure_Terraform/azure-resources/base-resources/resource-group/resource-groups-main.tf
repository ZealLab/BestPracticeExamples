# This file contains the main logic for the resource group module.
# This module creates a resource group and optionally applies a lock to it.

# The 'data' block is used to get information about existing resources.
# This data source gets information about the current Azure subscription.
data "azurerm_subscription" "subscription" {}

# The 'resource' block is used to create a new resource.
# This resource creates a new Azure Resource Group.
resource "azurerm_resource_group" "resource_group" {
    # The name of the resource group. This is a required variable.
    name     = var.name
    # The location of the resource group. This is a required variable.
    location = var.location
    # The tags to apply to the resource group. This is an optional variable.
    tags = var.tags
    # The 'lifecycle' block is used to customize the behavior of the resource.
    # 'ignore_changes' tells Terraform to ignore changes to the specified properties.
    lifecycle {
        ignore_changes = [
            tags
        ]
    }
}

# This resource creates a new Azure Management Lock.
# A management lock can be used to prevent accidental deletion or modification of a resource.
resource "azurerm_management_lock" "resource_group_lock" {
  # The 'count' meta-argument is used to create multiple instances of a resource.
  # In this case, it is used to conditionally create the lock based on the 'lock_resource' variable.
  count = var.lock_resource ? 1 : 0

  # The name of the lock.
  name       = "${var.name}-lock"
  # The scope of the lock. In this case, it is the resource group created above.
  scope      = azurerm_resource_group.resource_group.id
  # The lock level. 'CanNotDelete' prevents deletion, while 'ReadOnly' prevents any modification.
  lock_level = var.read_only ? "CanNotDelete" : "ReadOnly"
  # A description of the lock.
  notes      = "Locked by Terraform"
}