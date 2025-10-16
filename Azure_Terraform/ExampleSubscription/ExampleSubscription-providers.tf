# This file contains the provider configuration for the ExampleSubscription.
# Providers are plugins that Terraform uses to interact with cloud providers, SaaS providers, and other APIs.

# The 'terraform' block contains settings for Terraform itself.
terraform {
    # The 'required_providers' block specifies the providers that are required by the configuration.
    required_providers {
        # This block specifies the 'azuread' provider.
        azuread = {
            # The source of the provider. This is the official HashiCorp Azure AD provider.
            source  = "hashicorp/azuread"
            # The version of the provider to use. The '=' operator means that exactly this version must be used.
            version = "=2.38.0"
        }
        # This block specifies the 'azurerm' provider.
        azurerm = {
            # The source of the provider. This is the official HashiCorp Azure RM provider.
            source  = "hashicorp/azurerm"
            # The version of the provider to use.
            version = "=3.53.0"
        }
    }
}
