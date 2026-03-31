# -------------------------------------------------------
# GitHub resources
# Provisions teams, repositories, and permissions from
# the declarative provisioning.yaml configuration
# -------------------------------------------------------

# --------------------------------------------------
# Teams (from groups)
# --------------------------------------------------

resource "github_team" "this" {
  for_each = local.groups

  name    = each.key
  privacy = "closed"
}

# --------------------------------------------------
# Team memberships
# --------------------------------------------------

resource "github_team_membership" "this" {
  for_each = local.team_memberships_map

  team_id  = github_team.this[each.value.team].id
  username = each.value.user
  role     = "member"
}

# --------------------------------------------------
# Repositories (prefixed with application name)
# --------------------------------------------------

resource "github_repository" "this" {
  for_each = local.repositories

  name        = "${each.value.app_name}-${each.value.name}"
  description = try(each.value.description, null)
  visibility  = each.value.visibility
  auto_init   = true

  has_issues   = true
  has_projects = true
}

# --------------------------------------------------
# Team permissions on repositories
# --------------------------------------------------

resource "github_team_repository" "this" {
  for_each = local.team_permissions_map

  team_id    = github_team.this[each.value.team].id
  repository = github_repository.this[each.value.repo_key].name
  permission = each.value.permission
}

# --------------------------------------------------
# Individual collaborator permissions on repositories
# --------------------------------------------------

resource "github_repository_collaborator" "this" {
  for_each = local.user_collaborators_map

  repository = github_repository.this[each.value.repo_key].name
  username   = each.value.user
  permission = each.value.permission
}

# --------------------------------------------------
# Repository rulesets
# --------------------------------------------------

resource "github_repository_ruleset" "this" {
  for_each = local.rulesets

  name        = each.value.name
  repository  = github_repository.this[each.value.repo_key].name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/${each.value.target_branch}"]
      exclude = []
    }
  }

  rules {
    dynamic "pull_request" {
      for_each = try(each.value.rules.pull_request, null) != null ? [each.value.rules.pull_request] : []
      content {
        required_approving_review_count   = try(pull_request.value.required_approving_review_count, 0)
        required_review_thread_resolution = try(pull_request.value.required_conversation_resolution, false)
        require_code_owner_review         = try(pull_request.value.required_review_from_code_owners, false)
      }
    }

    dynamic "copilot_code_review" {
      for_each = try(each.value.rules.automatic_copilot_review, null) != null ? [each.value.rules.automatic_copilot_review] : []
      content {
        review_on_push             = try(copilot_code_review.value.review_new_push, false)
        review_draft_pull_requests = try(copilot_code_review.value.review_draft_pull_request, false)
      }
    }
  }
}
