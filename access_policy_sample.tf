## This is an example of acces policy definition.
## Deploy this file at blueprint level to match required set of permissions. 

## Full reference: https://www.terraform.io/docs/providers/azurerm/r/key_vault_access_policy.html  

# resource "azurerm_key_vault_access_policy" "developer" {
#   key_vault_id = azurerm_key_vault.akv.id

#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = var.logged_user_objectId

#   key_permissions = []

#   secret_permissions = [
#     "set",
#     "get",
#     "list",
#     "delete",
#   ]
# }