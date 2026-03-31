# -----------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------

output "repository_url" {
  description = "HTML URL of the created repository"
  value       = github_repository.demo.html_url
}

output "repository_full_name" {
  description = "Full name of the repository (owner/name)"
  value       = github_repository.demo.full_name
}

output "repository_ssh_clone_url" {
  description = "SSH clone URL"
  value       = github_repository.demo.ssh_clone_url
}

output "branch_protection_pattern" {
  description = "Branch pattern that is protected"
  value       = github_branch_protection.main.pattern
}

output "issue_labels" {
  description = "Map of managed issue labels and their colours"
  value       = { for k, v in github_issue_label.managed : v.name => v.color }
}

output "common_tags" {
  description = "Common tags map computed in locals"
  value       = local.common_tags
}
