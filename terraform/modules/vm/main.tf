resource "azurerm_public_ip" "main_pub_ip" {
  resource_group_name = var.vm_rg
  location = var.vm_location
  name = var.pub_ip_name
  allocation_method = "Dynamic"
}

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

resource "time_sleep" "waiting_for_pub_ip" {
  create_duration = "30s"
}
resource "null_resource" "pubip" {
  depends_on = [azurerm_public_ip.main_pub_ip,  time_sleep.waiting_for_pub_ip]
  provisioner "local-exec" {
    command = <<EOT
    if [ -z "${azurerm_public_ip.main_oub_ip.ip_address}]; then
      echo "error: coudn't find any pub ip" >&2
      exit 1
    fi
  EOT
  }
}

