output "object" {
  value = azurerm_key_vault.akv
  description = "returns the full Azure Key Vault Object"
}

output "name" {
  value = azurerm_key_vault.akv.name
  description = "returns the name of Azure Key Vault"
}

output "id" {
  value = azurerm_key_vault.akv.id
  description = "returns the ID of Azure Key Vault"
}

output "vault_uri" {
  value = azurerm_key_vault.akv.vault_uri
  description = "returns the vault URI of Azure Key Vault"
}