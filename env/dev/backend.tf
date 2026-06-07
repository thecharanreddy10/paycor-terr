terraform {
  backend "azurerm" {
    resource_group_name  = "PMI-DEV-USE-SHR-RG"
    storage_account_name = "pmidevusemigsa"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
