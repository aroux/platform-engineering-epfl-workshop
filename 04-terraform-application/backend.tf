# -------------------------------------------------------
# Backend configuration
# Uses local state for simplicity
# -------------------------------------------------------

terraform {
  required_version = ">= 1.0"

  backend "local" {
    path = "terraform.tfstate"
  }
}
