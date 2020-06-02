resource "azurecaf_naming_convention" "caf_name_kv" {  
  name          = var.akv_config.name
  prefix        = var.prefix != "" ? var.prefix : null
  postfix       = var.postfix != "" ? var.postfix : null
  max_length    = var.max_length != "" ? var.max_length : null
  resource_type = "azurerm_key_vault"
  convention    = var.convention
}

resource "azurerm_key_vault" "akv" {
    name                            = azurecaf_naming_convention.caf_name_kv.result
    location                        = var.location
    resource_group_name             = var.resource_group_name
    tenant_id                       = data.azurerm_client_config.current.tenant_id
    tags                            = local.tags
    sku_name                        = var.akv_config.sku_name

    enabled_for_disk_encryption     = lookup(var.akv_config.akv_features, "enabled_for_disk_encryption", null)
    enabled_for_deployment          = lookup(var.akv_config.akv_features, "enabled_for_deployment", null)
    enabled_for_template_deployment = lookup(var.akv_config.akv_features, "enabled_for_template_deployment", null)
    soft_delete_enabled             = lookup(var.akv_config.akv_features, "soft_delete_enabled", null)
    purge_protection_enabled        = lookup(var.akv_config.akv_features, "purge_protection_enabled", null)


    dynamic "network_acls" {
    for_each = lookup(var.akv_config, "network_acls", {}) != {} ? [1] : []
    
    content {
      default_action              = lookup(var.akv_config.network_acls, "default_action", null)
      bypass                      = lookup(var.akv_config.network_acls, "bypass", null)
      ip_rules                    = lookup(var.akv_config.network_acls, "ip_rules", null)
      virtual_network_subnet_ids  = lookup(var.akv_config.network_acls, "virtual_network_subnet_ids", null)
    }
    }
}
