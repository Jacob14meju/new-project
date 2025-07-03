#output "public_ip_addrres" {
 ## value = azurerm_public_ip.main_pub_ip.ip_address
 # depends_on = [time_sleep.wait_for_pub_ip]
 # description = "public ip addrres"
#}