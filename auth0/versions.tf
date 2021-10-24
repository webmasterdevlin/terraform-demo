terraform {
  required_version = ">= 1.0.9"
  required_providers {
    auth0 = {
      source  = "alexkappa/auth0"
      version = ">= 0.21.0"
    }
  }
}
