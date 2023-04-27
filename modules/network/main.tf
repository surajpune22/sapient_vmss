# Create a virtual network within the resource group
resource "azurerm_virtual_network" "az_network" {
  name                = "az_network_01"
  resource_group_name = var.rgname
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "az_subnet_01" {
  name                 = "subnet_01"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.az_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "az_subnet_02" {
  name                 = "subnet_02"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.az_network.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "azurerm_network_interface_01" {
  name                = "az-nic-01"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal-ip"
    subnet_id                     = azurerm_subnet.az_subnet_01.id
    private_ip_address_allocation = "Dynamic"
  }
}