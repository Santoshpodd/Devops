resource_group_name = {
  rg01 = {
    name    = "hcl-ci-rg01"
    location    = "centralindia"
  }
}

virtual_networks = {
  vnet1 = {
    name                = "hcl-ci-vnet1"
    location            = "eastus"
    resource_group_name = "hcl-ci-rg01"
    address_space       = ["10.0.0.0/16"]
  }
}


subnets = {
  snet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "hcl-ci-rg01"
    virtual_network_name = "hcl-ci-vnet1"
    address_prefixes     = ["10.0.1.0/24"]
  }
  snet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "hcl-ci-rg01"
    virtual_network_name = "hcl-ci-vnet1"
    address_prefixes     = ["10.0.2.0/24"]
  }
  snet3 = {
    name                 = "database-subnet"
    resource_group_name  = "hcl-ci-rg01"
    virtual_network_name = "hcl-ci-vnet1"
    address_prefixes     = ["10.0.3.0/24"]
  }
}