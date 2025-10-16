# Ansible Web Server Example

This example demonstrates how to use Ansible to install and configure a web server (Nginx).

## Structure

*   `inventory.ini`: The Ansible inventory file.
*   `playbook.yaml`: The main playbook that applies the `webserver` role.
*   `roles/webserver/`: The role for configuring the web server.
    *   `tasks/main.yaml`: The tasks to install and configure Nginx.
    *   `handlers/main.yaml`: The handler to restart Nginx.
    *   `templates/index.html.j2`: The template for the Nginx index page.

## Best Practices

*   **Roles:** The configuration is organized into a role (`webserver`), which makes it reusable and easy to manage.
*   **Handlers:** Handlers are used to restart services only when necessary, which is more efficient.
*   **Templates:** Templates are used to generate configuration files with dynamic data.
*   **Idempotence:** The tasks are idempotent, meaning they can be run multiple times without changing the result after the first run.

## How to Use

1.  Install Ansible.
2.  Update the `inventory.ini` file with your server information.
3.  Run the playbook: `ansible-playbook -i inventory.ini playbook.yaml`
