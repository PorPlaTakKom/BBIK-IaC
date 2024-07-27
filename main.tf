terraform {
  cloud {
    organization = "Bluebik"

    workspaces {
      name = "DEV"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = "true"

  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Southeast Asia"
}

resource "azurerm_container_registry" "example" {
  name                = "azurebbikdev"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Basic"
  admin_enabled       = true
}
