variable "resource-group-name" {
  default     = "rg_eastus_89125_1_1672239737332"
  description = "The prefix used for all resources in this example"
}

variable "location" {
  default     = "East US 2"
  description = "The Azure location where all resources in this example should be created"
}

variable "app-service-name" {
  default     = "terraform-app-service"
  description = "The name of the app service"
}
