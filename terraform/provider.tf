terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    time = {
      source = "hashicorp/time"
      version = "0.13.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "my-rg"
    storage_account_name = "mystoracc"
    container_name       = "tfstate"
    key                  = "prod/terraform.tfstate"
  }
}