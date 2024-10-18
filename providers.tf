terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>4.6.0"
    }
  }
}

provider "azurerm" {
    features { }

    subscription_id = "c7643f84-b30f-4d99-a8c3-8aab4a70a942"
}