variable "resource-group-name" {
  default     = "my-resource-group-1"
  description = "The prefix used for all resources in this example"
}

variable "location" {
  default     = "West Europe"
  description = "The Azure location where all resources in this example should be created"
}

variable "app-service-name" {
  default     = "webmasterdevlin-terraform-demo"
  description = "The name of the Web App"
}

variable "app-settings-value-x" {
  default     = "my-secret-value"
  description = "value for the app setting key"
}

variable "admin-login-devlin" {
  default     = "devlinduldulao"
  description = "Devlin's login name"
}

variable "admin-pass-devlin" {
  default     = "v3ry_Uniqu3Pa$$w0rd"
  description = "Devlin's password"
}


## Logging to Azure in Terraform Cloud
#############################################################################
# RUN THE FOLLOWING:
# $ az login
# $ az account list
# $ az account set --subscription="SUBSCRIPTION_ID"
# $ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
#
#  {
#    "appId": "00000000-0000-0000-0000-000000000000",
#    "displayName": "azure-cli-2021-06-05-10-41-15",
#    "name": "http://azure-cli-2021-06-05-10-41-15",
#    "password": "0000-0000-0000-0000-000000000000",
#    "tenant": "00000000-0000-0000-0000-000000000000"
#  }
#############################################################################

## Terraform Workspace
variable "subscription_id" {
  description = "This is the subscription id. Then TF_VAR_subscription_id in environment variables of Terraform Workspace."
  type        = string
}
variable "client_id" {
  description = "This is the appId. Then TF_VAR_client_id in environment variables of Terraform Workspace."
  type        = string
}
variable "client_secret" {
  description = "This is the password. Then TF_VAR_client_secret in environment variables of Terraform Workspace."
  type        = string
}
variable "tenant_id" {
  description = "This is the tenant. Then TF_VAR_tenant_id in environment variables of Terraform Workspace."
  type        = string
}

