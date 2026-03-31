# -------------------------------------------------------
# Backend configuration
# -------------------------------------------------------

terraform {
  required_version = ">= 1.0"

  backend "local" {
    path = "terraform.tfstate"
  }
}
