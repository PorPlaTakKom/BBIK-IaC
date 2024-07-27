resource "azurerm_resource_group" "web-app" {
  name     = "rg-webapp-sea"
  location = "Southeast Asia"
}

resource "azurerm_resource_group" "web-api" {
  name     = "rg-webapi-sea"
  location = "Southeast Asia"
}

resource "azurerm_resource_group" "container" {
  name     = "rg-container-sea"
  location = "Southeast Asia"
}
