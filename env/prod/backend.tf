terraform {
  backend "azurerm" {
    resource_group_name  = "PAY-UAT-EUS2-APP-RG"
    storage_account_name = "payuateus2appsa"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
