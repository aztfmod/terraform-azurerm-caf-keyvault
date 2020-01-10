module "diagnostics_akv" {
  source  = "aztfmod/caf-diagnostics/azurerm"
  version = "1.0.0"

    name                            = azurerm_key_vault.akv.name
    resource_id                     = azurerm_key_vault.akv.id
    log_analytics_workspace_id      = var.log_analytics_workspace.id
    diagnostics_map                 = var.diagnostics_map
    diag_object                     = var.diagnostics_settings
}