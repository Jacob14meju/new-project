resource "azurerm_public_ip" "main_pub_ip" {
  resource_group_name = var.rg_name
  location = var.loc
  name = var.pub_ip_name
  allocation_method = "Dynamic"
}