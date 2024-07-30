resource "azurerm_container_registry" "acr" {
  name                = "azurebbikdev"
  resource_group_name = azurerm_resource_group.container.name
  location            = azurerm_resource_group.container.location
  sku                 = "Basic"
  admin_enabled       = true
} 
