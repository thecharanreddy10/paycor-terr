terraform {
  backend "azurerm" {
    resource_group_name  = "PMI-QA-USE-SHR-RG"
    storage_account_name = "pmiqausemigsa"
    container_name       = "tfstate"
    key                  = "qa.terraform.tfstate"
  }
}
