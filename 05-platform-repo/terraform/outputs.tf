# -------------------------------------------------------
# Outputs
# -------------------------------------------------------

output "team_ids" {
  description = "Map of team name to team ID"
  value       = { for k, t in github_team.this : k => t.id }
}

output "repository_urls" {
  description = "Map of app/repo key to HTML URL"
  value       = { for k, r in github_repository.this : k => r.html_url }
}

output "repository_full_names" {
  description = "Map of app/repo key to full name (owner/repo)"
  value       = { for k, r in github_repository.this : k => r.full_name }
}

output "collaborators" {
  description = "Map of collaborator assignments"
  value       = { for k, c in github_repository_collaborator.this : k => c.username }
}

output "team_permissions" {
  description = "Map of team-repository permission assignments"
  value       = { for k, tp in github_team_repository.this : k => tp.permission }
}
