[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-keyvault&repo=aztfmod/terraform-azurerm-caf-keyvault)
[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Deploys an Azure Key Vault

Creates an Azure Key Vault.

Supported features:

1. AKV name is generated randomly based on (prefix+name)+randomly generated string to ensure WW uniqueness (created on 24 chars, which is max name length of AKV name)
2. AKV main settings: enabled for deployment, disk encryption, template deployment
3. AKV SKU: Premium or Standard
4. AKV networks ACL

Non-supported features:

1. Support for AKV policies is kept outside of this module in order to preserve consistency of policies. Ie: for each AKV creation, you should set your access policy tailored to the specific purpose (see AKV sample policy file - access_policy_sample.tf)

Reference the module to a specific version (recommended):

```hcl
module "azurekevault" {
    source  = "aztfmod/caf-keyvault/azurerm"
    version = "0.x.y"

    prefix                            = var.prefix
    location                          = var.location
    resource_group_name               = var.resource_group_name
    akv_config                        = var.akv_config
    tags                              = var.tags
    diagnostics_settings              = var.ipdiags
    diagnostics_map                   = var.diagsmap
    log_analytics_workspace           = var.laworkspace
}
```

<!--- BEGIN_TF_DOCS --->
<!--- END_TF_DOCS --->


## Parameters

### akv_config

(Required) Key Vault Configuration Object"

```hcl
variable "akv_config" {
  description = "(Required) Key Vault Configuration Object"
}
```

Sample:

```hcl
akv_config = {
    name       = "myakv"

    akv_features = {
        enabled_for_disk_encryption = true
        enabled_for_deployment      = false
        enabled_for_template_deployment = true
        soft_delete_enabled = true
        purge_protection_enabled = true
    }
    #akv_features is optional

    sku_name = "premium"
    network_acls = {
         bypass = "AzureServices"
         default_action = "Deny"
    }
    #network_acls is optional
}
```


## log_analytics_workspace

(Required) Log Analytics workspace for AKV

```hcl
variable "log_analytics_workspace" {
  description = "(Required) Log Analytics workspace for AKV"
}
```

Example

```hcl
log_analytics_workspace = module.loganalytics.object
```

## diagnostics_map

(Required) Map with the diagnostics repository information"

```hcl
variable "diagnostics_map" {
 description = "(Required) Map with the diagnostics repository information"
}
```

Example

```hcl
  diagnostics_map = {
      diags_sa      = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/arnaud-hub-operations/providers/Microsoft.Storage/storageAccounts/opslogskumowxv"
      eh_id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/arnaud-hub-operations/providers/Microsoft.EventHub/namespaces/opslogskumowxv"
      eh_name       = "opslogskumowxv"
  }
```

### diagnostics_settings

(Required) Map with the diagnostics settings for AKV deployment.
See the required structure in the following example or in the diagnostics module documentation.

```hcl
variable "diagnostics_settings" {
 description = "(Required) Map with the diagnostics settings for AKV deployment"
}
```

Example

```hcl
diagnostics_settings = {
    log = [
                # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
                ["AuditEvent", true, true, 60],
        ]
    metric = [
                #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
                  ["AllMetrics", true, true, 60],
    ]
}
```
