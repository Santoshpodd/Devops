resource_group_name = {
  rg01 = {
    name    = "hcl-ci-rg01"
    location    = "centralindia"
  }
}


virtual_networks = {
  vnet1 = {
    name                = "hcl-ci-vnet1"
    location            = "centralindia"
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
  # snet2 = {
  #   name                 = "backend-subnet"
  #   resource_group_name  = "hcl-ci-rg01"
  #   virtual_network_name = "hcl-ci-vnet1"
  #   address_prefixes     = ["10.0.2.0/24"]
  # }
  # snet3 = {
  #   name                 = "database-subnet"
  #   resource_group_name  = "hcl-ci-rg01"
  #   virtual_network_name = "hcl-ci-vnet1"
  #   address_prefixes     = ["10.0.3.0/24"]
  # }
 }

vm = {
  VM1 = {
    subnet_name = "frontend-subnet"
    virtual_network_name = "hcl-ci-vnet1"
    resource_group_name = "hcl-ci-rg01"
    location = "centralindia"
    vm_name = "KHASHVM01"
    size = "Standard_F2"
    PIP_name = "PIP0122324354"
    kv_name = "kvsdrtrt1233"

  }


 VM2 ={
    subnet_name = "frontend-subnet"
    virtual_network_name = "hcl-ci-vnet1"
    resource_group_name = "hcl-ci-rg01"
    location = "centralindia"
    vm_name = "AAMVM01"
    size = "Standard_F2"
    PIP_name = "PIP01223246743"
    kv_name = "kvsdrtrt1233"
    }



# #  VM3 ={
# #     subnet_name = ""
# #     virtual_network_name = ""
# #     resource_group_name = ""
# #     location = ""
# #     vm_name = ""
# #     size = ""
# #     PIP_name = ""
  #    kv_name = ""


}

kv_details = {
  kv1 ={
     kv_name = "kvsdrtrt1233"
     location = "centralindia"
     rg_name ="hcl-ci-rg01"

  }
}