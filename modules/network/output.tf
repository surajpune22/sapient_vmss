output "network_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.az_network.id
}


output "subnet_id_02" {
  description = "The id of the subnet 02"
  value = azurerm_subnet.az_subnet_02.id 
}