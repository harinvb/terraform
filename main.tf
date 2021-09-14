terraform {
  backend "azurerm" {
    container_name       = "terraform"
    storage_account_name = "csg100320015f749fb9"
    resource_group_name  = "cloud-shell-storage-centralindia"
    key                  = "terraformstates_dev.tfstates"
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "resource_group" {
  location = var.location
  name     = var.resource_group_name
}

module "v-net" {
  source              = "./Modules/v-net"
  network_name        = "${var.ProjectName}_V-net"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}

module "subnet" {
  source               = "./Modules/subnet"
  virtual_network_name = module.v-net.virtual_network_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  subnet_name          = "${var.ProjectName}_subnet"
}

module "VM" {
  count               = length(var.Instances)
  source              = "./Modules/LinuxVM"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  VM_name             = var.Instances[count.index]
  name                = "${var.Instances[count.index]}_NIC"
  subnet_id           = module.subnet.subnet_id
}
