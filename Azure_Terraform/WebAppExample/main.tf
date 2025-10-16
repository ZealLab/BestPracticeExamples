# This is the main terraform file for the web app example.
# It creates a resource group, a virtual network, a subnet, a public IP, a network security group, a network interface, and a virtual machine.
# This example is designed to be a simple, easy-to-understand demonstration of how to use Terraform to create a basic web application infrastructure in Azure.

# A resource group is a container that holds related resources for an Azure solution.
# The resource group includes those resources that you want to manage as a group.
# You decide which resources belong in a resource group based on what makes the most sense for your organization.
resource "azurerm_resource_group" "rg" {
  # The name of the resource group.
  name     = "WebAppExample-RG"
  # The location of the resource group.
  location = "East US"
}

# A virtual network (VNet) is the fundamental building block for your private network in Azure.
# A VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks.
resource "azurerm_virtual_network" "vnet" {
  # The name of the virtual network.
  name                = "WebAppExample-VNet"
  # The address space of the virtual network. This is the range of IP addresses that will be used by the VNet.
  address_space       = ["10.0.0.0/16"]
  # The location of the virtual network. It must be in the same location as the resource group.
  location            = azurerm_resource_group.rg.location
  # The name of the resource group in which to create the virtual network.
  resource_group_name = azurerm_resource_group.rg.name
}

# A subnet is a range of IP addresses in your VNet.
# You can divide a VNet into multiple subnets for organization and security.
resource "azurerm_subnet" "subnet" {
  # The name of the subnet.
  name                 = "WebAppExample-Subnet"
  # The name of the resource group in which to create the subnet.
  resource_group_name  = azurerm_resource_group.rg.name
  # The name of the virtual network in which to create the subnet.
  virtual_network_name = azurerm_virtual_network.vnet.name
  # The address prefix for the subnet. This is the range of IP addresses that will be used by the subnet.
  address_prefixes     = ["10.0.1.0/24"]
}

# A public IP address is a resource that you can create to have a static public IP address that you can use to access your Azure resources from the internet.
resource "azurerm_public_ip" "pip" {
  # The name of the public IP address.
  name                = "WebAppExample-PIP"
  # The location of the public IP address. It must be in the same location as the resource group.
  location            = azurerm_resource_group.rg.location
  # The name of the resource group in which to create the public IP address.
  resource_group_name = azurerm_resource_group.rg.name
  # The allocation method for the public IP address. Static means that the IP address will not change.
  allocation_method   = "Static"
}

# A network security group (NSG) contains a list of security rules that allow or deny network traffic to resources connected to Azure Virtual Networks (VNet).
# NSGs can be associated with subnets, individual VMs (classic), or individual network interfaces (NIC) attached to VMs (Resource Manager).
resource "azurerm_network_security_group" "nsg" {
  # The name of the network security group.
  name                = "WebAppExample-NSG"
  # The location of the network security group. It must be in the same location as the resource group.
  location            = azurerm_resource_group.rg.location
  # The name of the resource group in which to create the network security group.
  resource_group_name = azurerm_resource_group.rg.name

  # A security rule is a rule that allows or denies network traffic.
  # This security rule allows inbound traffic on port 22 (SSH).
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # This security rule allows inbound traffic on port 80 (HTTP).
  security_rule {
    name                       = "HTTP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# A network interface (NIC) enables an Azure Virtual Machine to communicate with internet, Azure, and on-premises resources.
resource "azurerm_network_interface" "nic" {
  # The name of the network interface.
  name                = "WebAppExample-NIC"
  # The location of the network interface. It must be in the same location as the resource group.
  location            = azurerm_resource_group.rg.location
  # The name of the resource group in which to create the network interface.
  resource_group_name = azurerm_resource_group.rg.name

  # An IP configuration is a configuration for a network interface that assigns an IP address to the NIC.
  ip_configuration {
    name                          = "WebAppExample-IPConfig"
    # The ID of the subnet to which to connect the network interface.
    subnet_id                     = azurerm_subnet.subnet.id
    # The private IP address allocation method. Dynamic means that the IP address will be assigned automatically.
    private_ip_address_allocation = "Dynamic"
    # The ID of the public IP address to associate with the network interface.
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# This resource associates a network security group with a network interface.
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  # The ID of the network interface.
  network_interface_id      = azurerm_network_interface.nic.id
  # The ID of the network security group.
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# A virtual machine (VM) is a computer file, typically called an image, that behaves like an actual computer.
# In other words, a virtual machine is a computer within a computer.
resource "azurerm_linux_virtual_machine" "vm" {
  # The name of the virtual machine.
  name                = "WebAppExample-VM"
  # The name of the resource group in which to create the virtual machine.
  resource_group_name = azurerm_resource_group.rg.name
  # The location of the virtual machine. It must be in the same location as the resource group.
  location            = azurerm_resource_group.rg.location
  # The size of the virtual machine.
  size                = "Standard_B1s"
  # The admin username for the virtual machine.
  admin_username      = "adminuser"
  # A list of network interface IDs to associate with the virtual machine.
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  # An admin SSH key is a public key that is used to authenticate with the virtual machine.
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  # An OS disk is a disk that is used to store the operating system of the virtual machine.
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # A source image reference is a reference to an image that is used to create the virtual machine.
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # Custom data is a script that is run on the virtual machine after it is created.
  # This script installs nginx and creates a simple index.html file.
  custom_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    echo "Hello World from $(hostname -f)" > /var/www/html/index.html
    EOF
}