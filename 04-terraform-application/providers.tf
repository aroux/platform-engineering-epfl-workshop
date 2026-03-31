# -------------------------------------------------------
# Provider configuration
# Configures the GitHub provider for resource provisioning
# -------------------------------------------------------

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = var.github_owner
}
