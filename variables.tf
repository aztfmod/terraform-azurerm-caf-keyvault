variable "location" {
  description = "(Required) Location of the AKV to be created"   
}

variable "rg" {
  description = "(Required) Resource group of the AKV to be created"    
}

variable "tags" {
  description = "(Required) Tags to be applied to the AKV to be created"
  
}

variable "diagnostics_map" {
  description = "(Required) Storage account and Event Hub for AKV"  

}

variable "log_analytics_workspace" {
  description = "(Required) Log Analytics workspace for AKV"
  
}

variable "diagnostics_settings" {
 description = "(Required) Map with the diagnostics settings for AKV"
}

variable "prefix" {
  description = "(Optional) You can use a prefix to add to the list of resource groups you want to create"
}

variable "akv_config" {
  description = "(Required) Key Vault Configuration Object"
}

variable "convention" {
  description = "(Required) Naming convention method to use"  
}
