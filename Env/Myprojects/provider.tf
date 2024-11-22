terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.10.0"
    }
  }



# backend "azurerm" {
  #   resource_group_name  = "Backend-RG01"          
  #   storage_account_name = "st0122322344354554"      
  #   container_name       = "tfstate"                
  #   key                  = "vnet.tfstate" 
  # }

}

provider "azurerm" {
  subscription_id = "85094bcc-b735-4ba5-9b2c-fdb8be03cae1"
  features {}
}




