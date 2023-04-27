provider "azurerm" {
    features {

    } 
}

#resource "azurerm_resource_group" "rg-1" {
#  name = var.rgname
#  location = var.location
#}

#module "network" {
#  source  = "./modules/network"
#  rgname = var.rgname
#  location = var.location
#}

#module "vmss" {
#  source = "./modules/vmss"
#  location = var.location
#  prefix = var.prefix
#}


locals {
  resource_group_name = "${var.application}-${var.environment}"
  vnet_name           = "${var.application}-${var.environment}-vnet"
  subnet_name         = "${var.application}-${var.environment}-subnet"
  saname              = "${var.application}${var.environment}"
}

resource "azurerm_resource_group" "lab2" {
  name     = local.resource_group_name
  location = var.location
  tags     = tomap({"type" = "resource"})
}

module "vnet" {
  source              = "./modules/vnet"
  location            = var.location
  resource_group_name = local.resource_group_name
  vnet_name           = local.vnet_name
  address_space       = var.address_space

  tags = tomap({"type" = "network"})
}

module "subnets" {
  source              = "./modules/subnet"
  location            = var.location
  resource_group_name = local.resource_group_name
  vnet_name           = module.vnet.vnet_name

  subnets = [
    {
      name   = local.subnet_name
      prefix = var.subnet
    }
  ]

  tags = tomap({"type" = "network"})
}

module "vmss" {
  source              = "./modules/vmss"
  location            = var.location
  capacity            = var.capacity
  saname              = local.saname
  subnet_id           = module.subnets.vnet_subnets
  resource_group_name = local.resource_group_name
  prefix = var.prefix

  tags = tomap({"type" = "vmss"})
}