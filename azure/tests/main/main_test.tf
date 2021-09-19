terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}


########### Arrange #############

variable "subscription_id" {
  type        = string
  description = "This is the subscription id. Then TF_VAR_subscription_id in environment variables of Terraform Workspace."
  default     = ""
}
variable "client_id" {
  type        = string
  description = "This is the appId. Then TF_VAR_client_id in environment variables of Terraform Workspace."
  default     = ""
}
variable "client_secret" {
  type        = string
  description = "This is the password. Then TF_VAR_client_secret in environment variables of Terraform Workspace."
  default     = ""
}
variable "tenant_id" {
  type        = string
  description = "This is the tenant. Then TF_VAR_tenant_id in environment variables of Terraform Workspace."
  default     = ""
}

locals {
  app-service-name = "webmasterdevlin-terraform-test"
}

module "main" {
  source = "../.."

  # Terraform Tests is still in experimental mode. Credentials must be provided here.
  # ARM_ and TF_VAR_ do not work yet in experimental mode.
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  # Replace with your own values
  app-service-name = local.app-service-name
}


########### Act and Assert #############

resource "test_assertions" "app-service-name" {

  component = "app-service-name"

  check "name" {
    description = "app-service-name should match ${local.app-service-name}"
    condition   = module.main.app_service_name == local.app-service-name
  }
}


