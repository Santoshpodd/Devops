terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.11.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
   subscription_id = "85094bcc-b735-4ba5-9b2c-fdb8be03cae1"
  features {}
}