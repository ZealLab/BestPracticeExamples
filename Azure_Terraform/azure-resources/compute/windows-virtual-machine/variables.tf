variable "vm_name" {
  description = "The name of the virtual machine."
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine."
}

variable "location" {
  description = "The location of the virtual machine."
}

variable "vm_size" {
  description = "The size of the virtual machine."
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
}

variable "admin_password" {
  description = "The admin password for the virtual machine."
  sensitive   = true
}

variable "subnet_id" {
  description = "The ID of the subnet to which to connect the virtual machine."
}

variable "os_disk_storage_account_type" {
  description = "The storage account type for the OS disk."
  default     = "Standard_LRS"
}
