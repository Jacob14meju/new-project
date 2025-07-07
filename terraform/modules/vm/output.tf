output "pub_ip" {
  value = azurerm_public_ip.main_pub_ip.ip_address
  depends_on = [ null_resource.pubip ]
  description = "waiting for public ip"
}