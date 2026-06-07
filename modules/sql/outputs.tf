output "server_id" {
  value = azurerm_sql_server.this.id
}

output "database_id" {
  value = azurerm_sql_database.this.id
}

output "server_name" {
  value = azurerm_sql_server.this.name
}

output "database_name" {
  value = azurerm_sql_database.this.name
}
