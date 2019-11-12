resource "random_string" "kv_name" {
  length  = 23 - (length(var.prefix)+length(var.akv_config.name))
  special = false
  upper   = false
  number  = true
}

locals {
    kv_name = "${var.prefix}${var.akv_config.name}${random_string.kv_name.result}"
}

resource "azurerm_key_vault" "akv" {
    name                            = local.kv_name
    location                        = var.location
    resource_group_name             = var.rg
    tenant_id                       = data.azurerm_client_config.current.tenant_id
    tags                            = local.tags
    sku_name                        = var.akv_config.sku_name

    enabled_for_disk_encryption     = lookup(var.akv_config.akv_features, "enabled_for_disk_encryption", null)
    enabled_for_deployment          = lookup(var.akv_config.akv_features, "enabled_for_deployment", null)
    enabled_for_template_deployment = lookup(var.akv_config.akv_features, "enabled_for_template_deployment", null)

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
