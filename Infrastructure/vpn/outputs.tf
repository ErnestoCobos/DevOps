output "ipv4_address" {
  value = "${vultr_instance.vpn_server.main_ip}"
}

output "ipv6_address" {
  value = "${vultr_instance.vpn_server.v6_main_ip}"
}