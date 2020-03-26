variable "location" {
  description = "(Required) Location of the AKV to be created"   
}

variable "resource_group_name" {
  description = "(Required) Resource group name of the AKV to be created"    
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

variable "akv_config" {
  description = "(Required) Key Vault Configuration Object"
}

variable "convention" {
  description = "(Required) Naming convention method to use"  
}

variable "prefix" {
  description = "(Optional) You can use a prefix to the name of the resource"
  type        = string
  default = ""
}

variable "postfix" {
  description = "(Optional) You can use a postfix to the name of the resource"
  type        = string
  default = ""
}

variable "max_length" {
  description = "(Optional) You can speficy a maximum length to the name of the resource"
  type        = string
  default = ""
}
