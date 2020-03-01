terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dev" {
  name     = "azuredaypolandrg"
  location = "westus"
}

resource "azurerm_app_service_plan" "dev" {
  name                = "azuredaypoland-appserviceplan"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "dev" {
  name                = "azuredaypoland-terraform"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  app_service_plan_id = azurerm_app_service_plan.dev.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "this-is-secret"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.dev.fully_qualified_domain_name} Database=${azurerm_sql_database.dev.name};User ID=${azurerm_sql_server.dev.administrator_login};Password=${azurerm_sql_server.dev.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_sql_server" "dev" {
  name                         = "azuredaypoland-sqlserver"
  resource_group_name          = azurerm_resource_group.dev.name
  location                     = azurerm_resource_group.dev.location
  version                      = "12.0"
  administrator_login          = "devlin"
  administrator_login_password = "I$uniq3p@ssw0rd2020"
}

resource "azurerm_sql_database" "dev" {
  name                = "azuredaypoland-sqldatabase"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  server_name         = azurerm_sql_server.dev.name

  tags = {
    environment = "production"
  }
}
