resource "azurerm_mssql_server" "mysql" {
  name                         = "mssqlserver"
  resource_group_name          = "rg-webapi-sea"
  location                     = "Southeast Asia"
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"
}
