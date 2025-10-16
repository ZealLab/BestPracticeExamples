# This is the main file for the ExampleSubscription.
# It calls the modules that create the resources in the subscription.

############## Resource Groups in Subscription ##############

# This module creates the 'example-rg' resource group and its resources.
# The source of the module is the 'example-rg' directory in the same directory as this file.
# To use this module, you need to provide values for the variables defined in the 'example-rg-variables.tf' file.
# For example:
# module "example-rg" {
#   source = "./example-rg"
#
#   vnet_rg                                      = "MyVNet-RG"
#   vnet_name                                    = "MyVNet"
#   vm_diagnostics_storage_primary_blob_endpoint = "https://mystorageaccount.blob.core.windows.net/"
#   admin_password                               = "MySecurePassword"
#   subnet_id                                    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/MyVNet-RG/providers/Microsoft.Network/virtualNetworks/MyVNet/subnets/MySubnet"
#   dsc_registration_url                         = "https://my-dsc-server.com/register"
#   dsc_registration_key                         = "MyDscRegistrationKey"
# }
module "example-rg" {
  source = "./example-rg"
}
