variable "resource_group_location" {
  type        = string
  default     = "northeurope"
  description = "Location of the resource group"
}

variable "subscription_id" {
  type        = string
  description = "The subscription id for the Azure Account"
}

variable "tenant_id" {
  type        = string
  description = "Tenant id for the service principal"
}