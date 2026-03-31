variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token with 'repo' and 'delete_repo' scopes"
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "GitHub username or organisation that will own the resources"
}
