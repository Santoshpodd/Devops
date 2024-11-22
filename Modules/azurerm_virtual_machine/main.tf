# resource "azurerm_resource_group" "RG" {
#   name     = "Test-rg01"
#   location = "centralindia"
# }


resource "azurerm_public_ip" "PIP" {
  name                = "testpip01"
  resource_group_name = "HCL-CI-RG01"
  location            = "centralindia"
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

resource "azurerm_network_interface" "Nic" {
  name                = "niccard01"
  location            = "centralindia"
  resource_group_name = "HCL-CI-RG01"

  ip_configuration {
    name                          = "IPConfig01"
    subnet_id                     = azurerm_subnet.subnet01.id  #need to be put subnetid when from existing id, 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.PIP.id
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
  name                = "test-01"
  resource_group_name = "HCL-CI-RG01"
  location            = "centralindia"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Admin@123456789"
  network_interface_ids = [azurerm_network_interface.Nic.id]

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

