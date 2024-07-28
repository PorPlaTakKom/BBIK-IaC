resource "azurerm_virtual_network" "vnet" {
  name                = "app-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vm-public-ip"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  allocation_method   = "Dynamic" 
}

resource "azurerm_network_interface" "vm-vif" {
  name                = "vm-nic"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_network_security_group" "allow_mysql" {
  name                = "mysql-nsg"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name

  security_rule {
    name                       = "allow_mysql"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.vm-vif.id
  network_security_group_id = azurerm_network_security_group.allow_mysql.id
}