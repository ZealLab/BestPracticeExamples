# This file contains the variables for the subnet module.
# Variables are used to parameterize the module, making it more reusable.

# The 'variable' block is used to define a new variable.
# This variable defines the name of the subnet.
variable "name" {
  # A description of the variable.
  description = "(Required) The name of the subnet. Changing this forces a new resource to be created."
}

# This variable defines the name of the resource group in which to create the subnet.
variable "resource_group_name" {
  # A description of the variable.
  description = "(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created."
}

# This variable defines the name of the virtual network in which to create the subnet.
variable "virtual_network_name" {
  # A description of the variable.
  description = "(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
}

# This variable defines the address prefixes for the subnet.
variable "address_prefixes" {
  # The type of the variable. In this case, it is a list of strings.
  type        = list(string)
  # A description of the variable.
  description = "(Required) The address prefix to use for the subnet."
}

# This variable defines the service endpoints to associate with the subnet.
variable "service_endpoints" {
  # The type of the variable.
  type    = list(string)
  # The default value for the variable.
  default = null
  # A description of the variable.
  description = <<DESCRIPTION
    (Optional) The list of Service endpoints to associate with the subnet.
    Possible values include:
      - Microsoft.AzureActiveDirectory
      - Microsoft.AzureCosmosDB
      - Microsoft.ContainerRegistry
      - Microsoft.EventHub
      - Microsoft.KeyVault
      - Microsoft.ServiceBus
      - Microsoft.Sql
      - Microsoft.Storage
      - Microsoft.Web
  DESCRIPTION
}

# This variable defines the subnet delegation.
variable "subnet_delegation" {
  # The type of the variable. In this case, it is a list of objects.
  type = list(object(
    {
      name            = string
      service_name    = string
      service_actions = list(string)
    }
  ))
  # The default value for the variable.
  default = []
  # A description of the variable.
  description = <<DESCRIPTION
    (Optional) A delegation block supports the following:
    * name (Required) A name for this delegation.
    * service_delegation (Required) A service_delegation block as defined below.
        A service_delegation block supports the following:
            - name (service_name) - (Required) The name of service to delegate to. Possible values include:
              - Microsoft.BareMetal/AzureVMware
              - Microsoft.BareMetal/CrayServers
              - Microsoft.Batch/batchAccounts
              - Microsoft.ContainerInstance/containerGroups
              - Microsoft.Databricks/workspaces
              - Microsoft.DBforPostgreSQL/serversv2
              - Microsoft.HardwareSecurityModules/dedicatedHSMs
              - Microsoft.Logic/integrationServiceEnvironments
              - Microsoft.Netapp/volumes
              - Microsoft.ServiceFabricMesh/networks
              - Microsoft.Sql/managedInstances
              - Microsoft.Sql/servers
              - Microsoft.StreamAnalytics/streamingJobs
              - Microsoft.Web/hostingEnvironments
              - Microsoft.Web/serverFarms
            - actions (service_actions) - (Optional) A list of Actions which should be delegated. Possible values include:
              - Microsoft.Network/networkinterfaces/*
              - Microsoft.Network/virtualNetworks/subnets/action
              - Microsoft.Network/virtualNetworks/subnets/join/action
              - Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action
              - Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action

    The list should contain a single map with the following shape
    {
      name            = string
      service_name    = string
      service_actions = string
    }
  DESCRIPTION
}

# This variable defines the ID of the Route Table to associate with the subnet.
variable "route_table_id" {
  # The default value for the variable.
  default = null
  # A description of the variable.
  description = "The ID of the Route Table to associate with the subnet."
}

# This variable determines whether to enable or disable network policies for the private endpoint on the subnet.
variable "private_endpoint_network_policies_enabled" {
  # The default value for the variable.
  default     = true
  # A description of the variable.
  description = <<DESCRIPTION
     (Optional) Enable or Disable network policies for the private endpoint on the subnet.
     Setting this to true will Enable the policy and setting this to false will Disable the policy.
     Defaults to true
  DESCRIPTION
}

# This variable determines whether to enable or disable network policies for the private link service on the subnet.
variable "private_link_service_network_policies_enabled" {
  # The default value for the variable.
  default = false
  # A description of the variable.
  description = <<DESCRIPTION
    (Optional) Enable or Disable network policies for the private link service on the subnet.
    Setting this to true will Enable the policy and setting this to false will Disable the policy.
    Defaults to false
  DESCRIPTION
}
