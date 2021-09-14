resource "azurerm_linux_virtual_machine" "LinuxVM" {
  admin_username        = "hari"
  admin_password        = "hari"
  location              = var.location
  name                  = var.VM_name
  network_interface_ids = [azurerm_network_interface.StaticPublicNIC.id]
  size                  = "Standard_B1s"
  resource_group_name   = var.resource_group_name
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  computer_name = replace(var.VM_name, "_", "")
  admin_ssh_key {
    public_key = file("~/.ssh/id_rsa.pub")
    username   = "hari"
  }
  depends_on = [
  azurerm_network_interface.StaticPublicNIC, azurerm_public_ip.PublicIP]
}
resource "azurerm_network_interface" "StaticPublicNIC" {
  location            = var.location
  name                = "${var.name}_NIC"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${replace(var.name, "_NIC", "")}_ip_Configuration"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.PublicIP.id
    subnet_id                     = var.subnet_id
  }
}
resource "azurerm_public_ip" "PublicIP" {
  allocation_method   = "Static"
  location            = var.location
  name                = "${replace(var.name, "_NIC", "")}_public_ip"
  resource_group_name = var.resource_group_name
}