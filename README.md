# Best Practice Examples

This repository is a curated collection of best practice examples for various technologies. The goal is to provide clear, concise, and educational templates that demonstrate how to use these technologies effectively.

## Technologies

This repository currently includes examples for:

*   [Ansible](#ansible)
*   [Azure Terraform](#azure-terraform)
*   [PowerShell DSC](#powershell-dsc)
*   [Modular PowerShell Application](#modular-powershell-application)

---

## Ansible

This example demonstrates how to use Ansible to install and configure a web server (Nginx).

### Structure

*   `inventory.ini`: The Ansible inventory file.
*   `playbook.yaml`: The main playbook that applies the `webserver` role.
*   `roles/webserver/`: The role for configuring the web server.
    *   `tasks/main.yaml`: The tasks to install and configure Nginx.
    *   `handlers/main.yaml`: The handler to restart Nginx.
    *   `templates/index.html.j2`: The template for the Nginx index page.

### Best Practices

*   **Roles:** The configuration is organized into a role (`webserver`), which makes it reusable and easy to manage.
*   **Handlers:** Handlers are used to restart services only when necessary, which is more efficient.
*   **Templates:** Templates are used to generate configuration files with dynamic data.
*   **Idempotence:** The tasks are idempotent, meaning they can be run multiple times without changing the result after the first run.

### How to Use

1.  Install Ansible.
2.  Update the `inventory.ini` file with your server information.
3.  Run the playbook: `ansible-playbook -i inventory.ini playbook.yaml`

---

## Azure Terraform

This example demonstrates how to use Terraform to create Azure resources.

### Structure

*   `azure-resources/`: This directory contains reusable Terraform modules for creating Azure resources.
    *   `base-resources/resource-group/`: A module for creating a resource group.
    *   `subnet/`: A module for creating a subnet.
*   `ExampleSubscription/`: This directory contains the main Terraform configuration for an example subscription.
    *   `ExampleSubscription-main.tf`: The main Terraform file for the subscription.
    *   `ExampleSubscription-providers.tf`: The provider configuration.
    *   `example-rg/`: A directory for a specific resource group.

### Best Practices

*   **Modules:** The use of modules (`azure-resources/`) promotes reusability and modularity.
*   **Variables and Outputs:** The use of variables and outputs allows for easy customization and composition of modules.
*   **State Management:** Terraform manages the state of the infrastructure, which allows for tracking changes and collaboration.

### How to Use

1.  Install Terraform.
2.  Configure your Azure credentials.
3.  Navigate to the `ExampleSubscription` directory.
4.  Run `terraform init` to initialize the configuration.
5.  Run `terraform plan` to see the changes that will be applied.
6.  Run `terraform apply` to create the resources.

---

## PowerShell DSC

This example demonstrates how to use PowerShell Desired State Configuration (DSC) to configure a server.

### Structure

*   `customModules/`: This directory contains custom DSC resources.
    *   `customBaseServer/`: A resource for basic server configuration.
    *   `customChocoInstalls/`: A resource for installing packages with Chocolatey.
    *   `customSecurity/`: A resource for security-related configuration.
*   `Example_Application/`: This directory contains the DSC configuration for an example application.
    *   `Example_Application.ps1`: The DSC configuration script.
    *   `Example_Application.psd1`: The data file for the configuration.

### Best Practices

*   **Custom Resources:** The use of custom resources allows for creating reusable and modular DSC configurations.
*   **Configuration Data:** The use of a configuration data file (`.psd1`) separates the configuration from the logic.
*   **Idempotence:** DSC configurations are idempotent by nature.

### How to Use

1.  Install the custom DSC modules.
2.  Run the `Example_Application.ps1` script to generate the MOF file.
3.  Apply the configuration using `Start-DscConfiguration`.

---

## Modular PowerShell Application

This example demonstrates how to create a modular PowerShell application.

### Structure

*   `Get-Example_Application.ps1`: The main script for the application.
*   `Modules/`: This directory contains the application's modules.
    *   `moduleA.psm1`: The first module.
    *   `moduleB.psm1`: The second module.

### Best Practices

*   **Modules:** The application is broken down into modules, which makes it easy to manage and reuse code.
*   **Functions:** Each module contains functions that perform specific tasks.
*   **Separation of Concerns:** The main script is responsible for orchestrating the modules, while the modules are responsible for the implementation details.

### How to Use

1.  Run the `Get-Example_Application.ps1` script.

---

## CI/CD

A great next step for this project is to add a Continuous Integration/Continuous Deployment (CI/CD) pipeline. This will automate the process of testing and validating the code, ensuring that the examples are always in a good state.

### Tools

There are many tools available for CI/CD, such as:

*   **GitHub Actions:** A popular choice for projects hosted on GitHub.
*   **Azure DevOps:** A comprehensive suite of tools for building and deploying software.
*   **Jenkins:** A flexible and extensible open-source automation server.

### Pipeline Steps

A basic CI/CD pipeline for this project could include the following steps:

*   **Linting:** Check the code for style and formatting issues.
*   **Validation:** Validate the syntax of the Ansible, Terraform, and DSC code.
*   **Testing:** Run tests to ensure that the code is working as expected.

By adding a CI/CD pipeline, you can improve the quality of the code and make it easier to maintain the project over time.

---

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the terms of the LICENSE file.
