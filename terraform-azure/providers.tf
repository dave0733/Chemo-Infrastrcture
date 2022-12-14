terraform {
    required_version = ">=1.0"

    required_providers {
      azurerm = {
        source = "hasicorp/azurerm"
        version = "~>3.0"
      }
      random = {
        source = "hasicorp/random"
        version = "~>3.0"
      }
    }
}
provider "azurerm" {
  features{}
}