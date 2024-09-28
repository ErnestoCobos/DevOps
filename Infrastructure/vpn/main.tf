data "vultr_ssh_key" "my_ssh_key" {
  filter {
    name = "name"
    values = ["Cortana"]
  }
}

resource "vultr_instance" "vpn_server" {
    plan = "vc2-1c-1gb"  # 1024 MB RAM,25 GB NVMe,2.00 TB BW, $5.00
    region = "mex"
    image_id = "pritunl"
    ssh_key_ids = [data.vultr_ssh_key.my_ssh_key.id]
    ddos_protection = true
    enable_ipv6 = true 
    activation_email = true
    hostname = var.hostname
    label = var.label
    tags = var.tags
}

resource "vultr_reverse_ipv4" "ipv4_address" {
    instance_id = "${vultr_instance.vpn_server.id}"
    ip = "${vultr_instance.vpn_server.main_ip}"
    reverse = var.hostname
}

resource "vultr_reverse_ipv6" "ipv6_address" {
    instance_id = "${vultr_instance.vpn_server.id}"
    ip = "${vultr_instance.vpn_server.v6_main_ip}"
    reverse = var.hostname
}