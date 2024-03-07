terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.8.2"
    }
  }
}

# provider "vault" {
# }
# data "vault_kv_secret_v2" "apiToken"{
#   mount = "kv-v2"
#   name  = "vcd_api"
# }
# Connect VMware vCloud Director Provider
provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_pass
  auth_type            = "api_token"
  api_token            = var.vcd_api
  org                  = "System"
  url                  = "https://${var.vcd_url}/api"
  max_retry_timeout    = var.vcd_max_retry_timeout
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}

data "vcd_catalog" "main-catalog" {
  org  = var.catalog_org
  name = var.catalog_name
}

data "vcd_catalog" "iso-catalog" {
  org  = var.catalog_org
  name = var.catalog_name
}

data "vcd_catalog_vapp_template" "PA-Template" {
  org        = var.catalog_org
  catalog_id = data.vcd_catalog.main-catalog.id
  name       = var.template_name
}

resource "vcd_catalog_media" "PA-Bootstrap" {
  org        = var.catalog_org
  catalog_id = data.vcd_catalog.iso-catalog.id

  name              = "${var.vm_name}.iso"
  description       = "PA Bootstrap"
  media_path        = "template.iso"
  upload_piece_size = 10
}

resource "vcd_vapp" "new-palo" {
  name = var.vm_name
  org  = var.org
  vdc  = var.vdc
}

resource "vcd_vapp_org_network" "vappOrgNetMan" {
  org  = var.org
  vdc  = var.vdc
  vapp_name = vcd_vapp.new-palo.name
  org_network_name = var.man_net_name

}
resource "vcd_vapp_org_network" "vappOrgNetInet" {
  org  = var.org
  vdc  = var.vdc
  vapp_name = vcd_vapp.new-palo.name
  org_network_name = var.inet_net_name
}
resource "vcd_vapp_org_network" "vappOrgNetDmz" {
  org  = var.org
  vdc  = var.vdc
  vapp_name = vcd_vapp.new-palo.name
  org_network_name = var.dmz_net_name
}
resource "vcd_vapp_org_network" "vappOrgNetInt" {
  org  = var.org
  vdc  = var.vdc
  vapp_name = vcd_vapp.new-palo.name
  org_network_name = var.int_net_name
}

resource "vcd_vapp_vm" "new-palo-vm" {
  org  = var.org
  vdc  = var.vdc
  vapp_name       = vcd_vapp.new-palo.name
  name            = var.vm_name
  computer_name   = var.vm_name
  description     = var.accountID
  vapp_template_id = data.vcd_catalog_vapp_template.PA-Template.id
  memory          = 6656
  cpus            = 2
  cpu_cores       = 2
  power_on        = false
  accept_all_eulas = true
  
  network {
    type               = "org"
    name               = vcd_vapp_org_network.vappOrgNetMan.org_network_name
    ip_allocation_mode = "MANUAL"
    ip                 = "${var.man_ip}"
    is_primary         = true
    adapter_type       = "VMXNET3"
  }
  network {
    type               = "org"
    name               = vcd_vapp_org_network.vappOrgNetInet.org_network_name
    ip_allocation_mode = "MANUAL"
    ip                 = "${var.inet_ip}"
    adapter_type       = "VMXNET3"
  }
  network {
    type               = "org"
    name               = vcd_vapp_org_network.vappOrgNetInt.org_network_name
    ip_allocation_mode = "MANUAL"
    ip                 = "${var.int_ip}"
    adapter_type       = "VMXNET3"
  }
  network {
    type               = "org"
    name               = vcd_vapp_org_network.vappOrgNetDmz.org_network_name
    ip_allocation_mode = "MANUAL"
    ip                 = "${var.dmz_ip}"
    adapter_type       = "VMXNET3"
  }
}

resource "vcd_inserted_media" "PA_Template" {
  org  = var.org
  vdc  = var.vdc
  catalog = data.vcd_catalog.iso-catalog.name
  name    = vcd_catalog_media.PA-Bootstrap.name

  vapp_name = vcd_vapp.new-palo.name
  vm_name   = vcd_vapp_vm.new-palo-vm.name

  eject_force = true
}