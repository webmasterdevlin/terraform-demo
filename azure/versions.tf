# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# Terraform 0.12.0 has fixed the issues with
# expressions, type system, error handling,
# iteration, conditionals, terraform state,
# testing, workflow, and modules
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.82.0"
    }
  }
}
