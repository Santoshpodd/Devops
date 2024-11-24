variable "resource_group_name" {}
variable "virtual_networks" {}
variable "subnets" {}
variable "vm" {}
variable "kv_details" {}

module "RG" {
  source = "../../Modules/azurerm_resource_group"
  RG_details = var.resource_group_name

}

module "kv" {
  source = "../../Modules/azurerm_key_vault"
  kv_details = var.kv_details
  depends_on = [ module.RG ]
  
}

module "vnet" {
  source = "../../Modules/azurerm_virtual_network"
  vnet_details = var.virtual_networks
  depends_on = [ module.RG ]
}

module "subnets" {
  source = "../../Modules/azurerm_subnet"
  subnet_details = var.subnets
  depends_on = [ module.vnet ]
}

module "azurerm_linux_virtual_machine" {
   source = "../../Modules/azurerm_virtual_machine"
   vm_map = var.vm
   depends_on = [ module.RG,module.vnet,module.subnets,module.kv ]

}



