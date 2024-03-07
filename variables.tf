# vCloud Director Connection Variables
variable "vcd_user" {
  description = "vCloud user"
  type        = string
  sensitive   = true
  default = "none"
}
variable "vcd_pass" {
  description = "vCloud pass"
  type        = string
  sensitive   = true
  default = "none"
}
variable "org" {
    description = "FWaaS org"
}
variable "vdc" {
    description = "FWaaS vdc"
}
variable "vcd_url" {
    description = "vCloud url"
}
variable "vcd_api" {
    description = "vCloud api token"
}
variable "vcd_max_retry_timeout" {
    description = "vCloud max retry timeout"
    default = "60"
}
variable "vcd_allow_unverified_ssl" {
    description = "vCloud allow unverified ssl"
}
# catalog vars
variable "catalog_org" {
    description = "Catalog org"
}
variable "catalog_name" {
    description = "catalog name"
}
variable "template_name" {
    description = "target template name"
}
# new VM vars
variable "vm_name" {
    description = "vApp and VM Name"
}
variable "man_net_name" {
    description = "management network name"
}
variable "man_ip" {
    description = "management IP"
    type        = string
}
variable "inet_net_name" {
    description = "Internet network name"
}
variable "inet_ip" {
    description = "Internet IP"
    type        = string
}
variable "dmz_net_name" {
    description = "DMZ network name"
}
variable "dmz_ip" {
    description = "DMZ IP"
    type        = string
}
variable "int_net_name" {
    description = "Internal network name"
}
variable "int_ip" {
    description = "Internal IP"
    type        = string
}
variable "accountID" {
    description = "Customer Account ID"
    type        = string
}