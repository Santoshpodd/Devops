resource "azurerm_resource_group" "RG" {
  for_each = var.RG_details
  name     = each.value.name
  location = each.value.location
}