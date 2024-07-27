resource "azurerm_app_service_plan" "webapp" {
  name                = "bbik-app-service-plan"
  location            = "Southeast Asia"
  resource_group_name = "rg-webapp-sea"
  kind                = "Linux"
  reserved            = true
  
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service_plan" "webapi" {
  name                = "bbik-app-service-plan"
  location            = "Southeast Asia"
  resource_group_name = "rg-webapi-sea"
  kind                = "Linux"
  reserved            = true
  
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "bbik-web-app"
  location            = "Southeast Asia"
  resource_group_name = "rg-webapp-sea"
  app_service_plan_id = azurerm_app_service_plan.webapp.id

  site_config {
    linux_fx_version = "DOCKER|${var.acr_url}/bbikapp:latest"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${var.acr_url}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.acr_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.acr_password
  }
}

resource "azurerm_app_service" "webapi" {
  name                = "bbik-web-app"
  location            = "Southeast Asia"
  resource_group_name = "rg-webapi-sea"
  app_service_plan_id = azurerm_app_service_plan.webapi.id

  site_config {
    linux_fx_version = "DOCKER|${var.acr_url}/bbikapi:latest"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${var.acr_url}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.acr_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.acr_password
  }
}

output "app_service_webapp_hostname" {
  value = azurerm_app_service.webapp.default_site_hostname
}

output "app_service_webapi_hostname" {
  value = azurerm_app_service.webapi.default_site_hostname
}