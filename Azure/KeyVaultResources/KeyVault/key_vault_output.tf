output "key_vault_id" {
  description = "key vault id"
  value = azurerm_key_vault.key_vault.id
}

output "key_vault_vault_uri" {
  description = "key vault uri"
  value = azurerm_key_vault.key_vault.vault_uri
}
