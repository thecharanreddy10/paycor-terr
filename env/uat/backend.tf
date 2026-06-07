terraform {
  backend "azurerm" {
    resource_group_name  = "PMI-UAT-USE-SHR-RG"
    storage_account_name = "pmiuatusemigsa"
    container_name       = "tfstate"
    key                  = "uat.terraform.tfstate"
  }
}
