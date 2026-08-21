# These outputs will be fed into the Docker/Kubectl commands in our next step

output "acr_login_server" {
  description = "The ACR hostname you push images to."
  value = azurerm_container_registry.act.login_server
}

output "acr_name" {
    description = "ACR name (used with 'az acr login')."
    value = azurerm_container_registry.acr.name
}

output "resource_group_name" {
  description = "Resource group containing everything for this project!"
  value = azurerm_resource_group.name
}

output "aks_cluster_name" {
  description = "AKS cluster name (used with 'az aks get-credentials)."
  value = azurerm_kubernetes_cluster.aks.name
}