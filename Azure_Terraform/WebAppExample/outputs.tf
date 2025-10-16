# This file contains the outputs for the web app example.

output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}
