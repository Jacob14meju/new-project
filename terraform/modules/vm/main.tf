resource "azurerm_network_interface" "main_nic" {
  name = var.nic_name
  resource_group_name = var.vm_rg
  location = var.vm_location
  ip_configuration {
    name = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = var.sub_id
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name = var.vm_name
  location = var.vm_location
  resource_group_name = var.vm_rg
  network_interface_ids = [azurerm_network_interface.main_nic.id]
  size = var.vm_size
  admin_username = var.vm_user
  admin_password = var.vm_pass
  disable_password_authentication = false
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
}