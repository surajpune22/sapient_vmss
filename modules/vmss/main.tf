provider "azurerm" {
  features {}
}

# Locals Block for custom data
locals {
bastion_host_custom_data = <<CUSTOM_DATA
#!/bin/sh
apt-get update
apt-get install nginx -y
CUSTOM_DATA  
}

resource "azurerm_public_ip" "lab2" {
  name                = "${var.resource_group_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  allocation_method   = "Static"
  domain_name_label   = var.resource_group_name
}

resource "azurerm_lb" "lab2" {
  name                = "${var.resource_group_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lab2.id
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
#  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lab2.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "lab2" {
  name                = "http-probe"
#  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lab2.id
  protocol            = "Http"
  request_path        = "/"
  port                = 80
}

resource "azurerm_lb_rule" "lbrulehttp" {
#  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lab2.id
  name                           = "LBRuleHTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.lab2.id
#  backend_address_pool_ids        = azurerm_lb_backend_address_pool.bpepool.id
}

resource "azurerm_lb_nat_pool" "lbnatpoolssh" {
  name                           = "ssh"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lab2.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_storage_account" "lab2" {
  name                     = "base876834"
  location                 = var.location
  resource_group_name      = "tfworkspaces-dev"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags

  depends_on = [
    
  ]
}

resource "azurerm_storage_container" "lab2" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.lab2.name
  container_access_type = "private"
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "${var.resource_group_name}-vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  upgrade_policy_mode = "Manual"
  overprovision       = false

  sku {
    name     = "Standard_DS1_V2"
    tier     = "Standard"
    capacity = var.capacity
  }

  os_profile {
    computer_name_prefix = "${var.resource_group_name}-vm"
    admin_username       = "sshadmin"
    admin_password       = "Password1234!"
    custom_data = base64encode(local.bastion_host_custom_data)
  }

  os_profile_linux_config {
    disable_password_authentication = false
    # admin_ssh_key {
    #     username = "adminuser"
    #     public_key = file("~/.ssh/personal/fs/id_rsa.pub")
    # }
  }

  storage_profile_os_disk {
    name           = "osDiskProfile"
    caching        = "ReadWrite"
    create_option  = "FromImage"
    vhd_containers = ["${azurerm_storage_account.lab2.primary_blob_endpoint}${azurerm_storage_container.lab2.name}"]
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpoolssh.id]
    }
  }
}