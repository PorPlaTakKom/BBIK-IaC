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

provider "tls" {}

resource "tls_private_key" "vm_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "private_key" {
  value = tls_private_key.vm_key.private_key_pem
  sensitive = true 
}