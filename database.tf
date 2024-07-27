resource "azurerm_mssql_server" "mysql" {
  name                         = "mssqlserver"
  resource_group_name          = "rg-webapi-sea"
  location                     = "Southeast Asia"
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "P@ssW0rd"
  minimum_tls_version          = "1.2"

  depends_on = [ azurerm_resource_group.web-api ]
}
