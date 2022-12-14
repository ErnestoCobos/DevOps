data "vultr_ssh_key" "my_ssh_key" {
  filter {
    name = "name"
    values = ["Cortana"]
  }
}

resource "vultr_instance" "vpn_server" {
    plan = "vhp-1c-1gb-amd"  # 1024 MB RAM,25 GB NVMe,2.00 TB BW, $6.00
    region = "mex"
    app_id = 50 # Pritunl App
    ssh_key_ids = [data.vultr_ssh_key.my_ssh_key.id]
    backups = "enabled" # $1.20/month
    backups_schedule {
      type = "daily"
    }
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