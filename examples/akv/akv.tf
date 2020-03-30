provider "azurerm" {
   features {}
}

resource "azurerm_resource_group" "rg_test" {
  name     = local.resource_groups.test.name
  location = local.resource_groups.test.location
  tags     = local.tags
}


module "la_test" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "2.0.1"
  
    convention          = local.convention
    location            = local.location
    name                = local.name
    solution_plan_map   = local.solution_plan_map 
    prefix              = local.prefix
    resource_group_name = azurerm_resource_group.rg_test.name
    tags                = local.tags
}

module "diags_test" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "2.0.1"

  resource_group_name   = azurerm_resource_group.rg_test.name
  prefix                = local.prefix
  location              = local.location
  tags                  = local.tags
  convention            = local.convention
  name                  = local.name
}

module "akv_test" {
  source = "../../"
  
  convention               = local.convention
  akv_config               = local.akv_config
  resource_group_name      = azurerm_resource_group.rg_test.name
  location                 = local.location 
  tags                     = local.tags
  log_analytics_workspace  = module.la_test
  diagnostics_map          = module.diags_test.diagnostics_map
  diagnostics_settings     = local.akv_config.diagnostics_settings
}

