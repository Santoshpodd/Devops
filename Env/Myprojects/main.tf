variable "resource_group_name" {}
variable "virtual_networks" {}
variable "subnets" {}

module "RG" {
  source = "../../Modules/azurerm_resource_group"
  RG_map = var.resource_group_name

}

module "vnet" {
  source = "../../Modules/azurerm_virtual_network"
  vnet_map = var.virtual_networks
  depends_on = [ module.RG ]
}

module "subnets" {
  source = "../../Modules/azurerm_subnet"
  subnet_map = var.subnets
  depends_on = [ module.vnet ]
}


