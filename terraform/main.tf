provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "main_rg" {
  name = "main_rg"
  location = "East Us"
}

resource "azurerm_network_security_group" "main_sg" {
  name = "main_sg"
  resource_group_name = azurerm_resource_group.main_rg.name
  location = azurerm_resource_group.main_rg.location
}

resource "azurerm_virtual_network" "main_vnet" {
  name = "main_vnet"
  resource_group_name = azurerm_resource_group.main_rg.name
  location = azurerm_resource_group.main_rg.location
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "main_sub" {
  name = "main_sub"
  resource_group_name = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes = ["10.0.2.0/24"]
}


module "vm1" {
  source = "./modules/vm"
  vm_name = "vm1"
  sub_id = azurerm_subnet.main_sub.id
  nic_name = "main_nic"
  pub_ip_name = "main_pub_ip"
}










