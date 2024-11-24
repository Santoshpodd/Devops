# resource "azurerm_resource_group" "RG" {
#   name     = "Test-rg01"
#   location = "centralindia"
# }


resource "azurerm_public_ip" "PIP" {
  for_each = var.vm_map
  name               = each.value.PIP_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
}

# resource "azurerm_virtual_network" "vnet01" {
#   name                = "test-vnet01"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.RG.location
#   resource_group_name = azurerm_resource_group.RG.name
# }

# resource "azurerm_subnet" "subnet01" {
#   name                 = "test-subnet01"
#   resource_group_name  = azurerm_resource_group.RG.name
#   virtual_network_name = azurerm_virtual_network.vnet01.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

data "azurerm_virtual_network" "vnet" {
  for_each = var.vm_map
    name                = each.value.virtual_network_name
    resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "subnet" {
  for_each = var.vm_map
     name                 = each.value.subnet_name
     virtual_network_name = each.value.virtual_network_name
    resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "kv" {
  for_each = var.vm_map
     name                = each.value.kv_name
     resource_group_name = each.value.resource_group_name
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"

}

resource "azurerm_key_vault_secret" "username" {
  for_each = var.vm_map
  name         = "vmusername"
  value        = "Locadmin"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

resource "azurerm_key_vault_secret" "password" {
  for_each = var.vm_map
  name         = "${each.value.vm_name}-password"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

resource "azurerm_network_interface" "Nic" {

for_each = var.vm_map
  name                = "${each.value.vm_name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "IPConfig01"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.PIP[each.key].id
  }
}

# resource "azurerm_storage_account" "stg" {
#   name                     = "storageaccountname01"
#   resource_group_name      = azurerm_resource_group.RG.name
#   location                 = azurerm_resource_group.RG.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = {
#     environment = "staging"
#   }
# }

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vm_map
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = "adminuser"
  admin_password      = "Admin@123456789"
  disable_password_authentication = "false"
  network_interface_ids = [azurerm_network_interface.Nic[each.key].id]

 os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

