resource "azurerm_user_assigned_identity" "identity-aks" {
  name                = "identity-aks"
  resource_group_name = azurerm_resource_group.rg-spoke.name
  location            = azurerm_resource_group.rg-spoke.location
}

resource "azurerm_role_assignment" "private-dns-zone-contributor" {
  scope                = var.private_dns_zone_id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.identity-aks.principal_id
}

resource "azurerm_role_assignment" "network-contributor" {
  scope                = azurerm_virtual_network.vnet-spoke.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.identity-aks.principal_id
}