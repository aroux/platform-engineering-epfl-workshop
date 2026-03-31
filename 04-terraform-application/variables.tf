# -------------------------------------------------------
# Input variables
# Variables required to configure GitHub provisioning
# -------------------------------------------------------

variable "github_owner" {
  description = "GitHub organisation or user account that owns the resources"
  type        = string
}

variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token with 'repo' and 'delete_repo' scopes"
  sensitive   = true
}