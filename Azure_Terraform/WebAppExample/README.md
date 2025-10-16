# Azure Web App Example

This example demonstrates how to use Terraform to create a simple web application infrastructure in Azure.

## Infrastructure

This example creates the following resources:

*   **Azure Resource Group:** A container that holds related resources for an Azure solution.
*   **Azure Virtual Network:** The fundamental building block for your private network in Azure.
*   **Azure Subnet:** A range of IP addresses in your VNet.
*   **Azure Public IP:** A public IP address to access the virtual machine from the internet.
*   **Azure Network Security Group:** A firewall to control inbound and outbound traffic to your VM.
*   **Azure Network Interface:** Enables an Azure Virtual Machine to communicate with internet, Azure, and on-premises resources.
*   **Azure Virtual Machine:** A Linux VM to host the web server.

## How to Use

1.  **Configure your Azure credentials.**
2.  **Initialize Terraform:**
    ```
    terraform init
    ```
3.  **Create an SSH key pair:**
    ```
    ssh-keygen -t rsa -b 2048
    ```
4.  **Apply the Terraform configuration:**
    ```
    terraform apply
    ```
5.  **Access the web server:**
    Open a web browser and navigate to the `public_ip` output by the `terraform apply` command.

## Outputs

*   `public_ip`: The public IP address of the web server.
