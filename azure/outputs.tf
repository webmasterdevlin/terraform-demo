output "app_service_name" {
  value       = azurerm_app_service.test.name
  description = "The name of App Service"
}

output "app_service_default_hostname" {
  value       = "https://${azurerm_app_service.test.default_site_hostname}"
  description = "The hostname of App Service"
}

output "sql_server_name" {
  value = azurerm_sql_server.test.name
}

output "sql_database_name" {
  value = azurerm_sql_database.test.name
}
