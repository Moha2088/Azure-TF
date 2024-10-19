resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "createdbyterraform"
}

resource "azurerm_storage_account" "sa" {
  location                 = "northeurope"
  name                     = "acccreatedbyterraform"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.rg.name
}

resource "azurerm_key_vault" "vault" {
  location            = "northeurope"
  name                = "vaultcreatedbyterraform"
  tenant_id           = var.tenant_id
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
}