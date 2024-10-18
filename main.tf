resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name = "createdbyterraform"
}

resource "azurerm_storage_account" "sa" {
  location = "northeurope"
  name = "acccreatedbyterraform"
  account_tier = "Standard"
  account_replication_type = "LRS"
  resource_group_name = azurerm_resource_group.rg.name
}