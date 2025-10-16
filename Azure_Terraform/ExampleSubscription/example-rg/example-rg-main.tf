# This is the main file for the 'example-rg' module.
# It calls other modules to create the resources in the resource group.

# This module creates the resource group.
# The source of the module is the 'resource-group' module in the 'azure-resources/base-resources' directory.
module "resource_group" {
    source = "../../azure-resources/base-resources/resource-group"

    # The name of the resource group.
    name = "example-rg"
    # The location of the resource group. This is a variable defined in the 'example-rg-variables.tf' file.
    location = var.location

    # The tags to apply to the resource group.
    tags = {
        Department = "Development"
        EnvironmentType = "DEV"
        ResourceOwner = "billybob@contoso.com"
        ResourceOwnerManager = "bobbybill@contoso.com"
    }
}

# This module creates a subnet.
# The source of the module is the 'subnet' module in the 'azure-resources' directory.
module "subnet" {
    source = "../../azure-resources/subnet"

    # The name of the subnet.
    name                 = "ads-cdx-hj-prod-subnet"
    # The name of the resource group in which to create the subnet.
    resource_group_name  = var.vnet_rg
    # The name of the virtual network in which to create the subnet.
    virtual_network_name = var.vnet_name
    # The address prefixes for the subnet.
    address_prefixes     = ["172.26.225.64/28"]
}

# This module creates a Windows virtual machine.
# The source of the module is a local module.
module "example-machine" {
    source = "../../azure-resources/compute/windows-virtual-machine"

    # The name of the virtual machine.
    vm_name             = "example-machine"
    # The name of the resource group in which to create the virtual machine.
    resource_group_name = module.resource_group.name
    # The location of the virtual machine.
    location            = module.resource_group.location

    # The admin username for the virtual machine.
    admin_username = "devops"
    # The admin password for the virtual machine.
    admin_password = var.admin_password

    # The ID of the subnet to which to connect the virtual machine.
    subnet_id = module.subnet.id
}