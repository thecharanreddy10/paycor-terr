terraform {
  backend "azurerm" {
    resource_group_name  = "PMI-PRD-USE-SHR-RG"
    storage_account_name = "pmiprdusemigsa"
    container_name       = "tfstate"
    key                  = "qa.terraform.tfstate"
  }
}
