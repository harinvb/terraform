output "ip_addresses" {
  value = module.VM.*.IP
}

output "v-net_name" {
  value = module.v-net.virtual_network_name
}

output "subnet_name" {
  value = module.subnet.subnet-name
}