output "IP" {
  value = azurerm_linux_virtual_machine.LinuxVM.public_ip_address
}

output "Host_ID" {
  value = azurerm_linux_virtual_machine.LinuxVM.dedicated_host_id
}
output "NIC_ID" {
  value = azurerm_network_interface.StaticPublicNIC.id
}