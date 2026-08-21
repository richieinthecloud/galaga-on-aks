# the beginning of our actual resources
# resource group, container registry, AKS cluster,
# managed identity, and role assignment

resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "Basic" # cheapest, more than enough for one image
  admin_enabled = false # using identity auth, not admin passwords
}

resource "azurerm_kubernetes_cluster" "aks" {
  name = "${var.prefix}-aks"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix = "${var.prefix}-aks"

  default_node_pool {
    name = "default"
    node_count = var.node_count
    vm_size = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull" # kubelet_identity is the identity of the nodes actually use to pull images
  principal_id = azurerm_kubernetes_cluster.aks.kublet_identity[0].object_id
  skip_service_principal_aad_check = true
}