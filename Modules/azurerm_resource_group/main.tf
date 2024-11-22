resource "azurerm_resource_group" "RG" {
  for_each = var.RG_map
  name     = each.value.name
  location = each.value.location
}