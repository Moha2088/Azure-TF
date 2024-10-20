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

resource "azurerm_monitor_metric_alert" "metric" {
  scopes              = [azurerm_storage_account.sa.id]
  name                = "alertcreatedbyterraform"
  description         = "Metric alert created by terraform"
  resource_group_name = azurerm_resource_group.rg.name

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    operator         = "GreaterThan"
    threshold        = "200"
    aggregation      = "Total"
  }
}

resource "azurerm_mssql_server" "ms_server" {
  name                         = "servercreatedbyterraform"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = "northeurope"
  version                      = "12.0"
  administrator_login          = "adminloginmo"
  administrator_login_password = "AzMohac12345s"
}

resource "azurerm_application_insights" "insights" {
  name                = "insightcreatedbyterraform"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  application_type    = "web"
}

resource "azurerm_service_plan" "serviceplan" {
  name                = "planceratedbyterraform"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "northeurope"
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_function_app" "function" {
  name                       = "functionbyterraform"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = "northeurope"
  service_plan_id            = azurerm_service_plan.serviceplan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key

  site_config {}
}