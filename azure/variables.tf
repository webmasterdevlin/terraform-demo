variable "resource-group-name" {
  default     = "my-resource-group-1"
  description = "The prefix used for all resources in this example"
}

variable "location" {
  default     = "West Europe"
  description = "The Azure location where all resources in this example should be created"
}

variable "app-service-name" {
  default     = "my-app-service-1"
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
