resource "azurerm_linux_virtual_machine" "mysql" {
  name                = "database-vm"
  resource_group_name = azurerm_resource_group.web-api.name
  location            = azurerm_resource_group.web-api.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vm-vif.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  admin_password = "P@ssw0rd1234"

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.vm_key.public_key_openssh
  }

  depends_on = [ azurerm_resource_group.web-api, azurerm_virtual_network.vnet, tls_private_key.vm_key ]
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.mysql.public_ip_address
}