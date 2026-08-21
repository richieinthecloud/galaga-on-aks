variable "prefix" {
    description = "Short name prefix for resources"
    type = string
    default = "galaga"
}

variable "location" {
  description = "Azure region to deploy into."
  type = string
  default = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group to create."
  type = string
  default = "galaga-rg"
}

variable "acr_name" {
  description = "Globally-unique ACR name (letters and numbers only, 5-50 characters.)"
  type = string
  default = "galagaacrrac09011994"
}

variable "node_count" {
  description = "Number of worker VMs (nodes) in the AKS pool."
  type = number
  default = 2 # no single point of failure
}

variable "node_vm_size" {
  description = "VM size for AKS nodes."
  type = string
  default = "Standard_B2s" # small and cheap. Excellent for demo game
}