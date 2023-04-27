#output "rg_id" {
#value = azurerm_resource_group.rg-1.id  
#}



output "azurerm_resource_group_name" {
 description = "The name of the resource group"
 value       = azurerm_resource_group.lab2.name
}

output "vnet_module_location" {
 description = "The location of the VNet"
 value       = module.vnet.vnet_location
}

output "vnet_module_id" {
 description = "The ID of the VNet"
 value       = module.vnet.vnet_id
}

output "vnet_module_name" {
 description = "The name of the VNet"
 value       = module.vnet.vnet_name
}

output "vnet_module_address_space" {
 description = "The address space of the VNet"
 value       = module.vnet.vnet_address_space
}

output "vmss_frontend_ip_configuration" {
 value = module.vmss.frontend_ip_configuration
}

output "vmss_frontend_ip_address" {
 value = module.vmss.frontend_ip_address
}