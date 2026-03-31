# -------------------------------------------------------
# Local values
# Parses provisioning.yaml and builds lookup structures
# -------------------------------------------------------

locals {
  config = yamldecode(file("${path.module}/provisioning.yaml"))

  # --------------------------------------------------
  # Groups → GitHub teams and memberships
  # --------------------------------------------------
  groups = { for g in local.config.groups : g.name => g.users }

  team_memberships = flatten([
    for group_name, users in local.groups : [
      for user in users : {
        team  = group_name
        user  = user
      }
    ]
  ])

  team_memberships_map = {
    for m in local.team_memberships : "${m.team}/${m.user}" => m
  }

  # --------------------------------------------------
  # Repositories – flatten across all applications
  # Key: "${app_name}/${repo_name}" for global uniqueness
  # --------------------------------------------------
  repositories = merge([
    for app in local.config.applications : {
      for repo in app.repositories : "${app.name}/${repo.name}" => merge(repo, {
        app_name = app.name
      })
    }
  ]...)

  # --------------------------------------------------
  # Permissions – expand into per-collaborator entries
  # YAML level names map to GitHub permission strings.
  # --------------------------------------------------
  permission_levels = {
    admin = "admin"
    write = "push"
  }

  # Individual user collaborators (one entry per user × repo, across all apps)
  user_collaborators_map = {
    for entry in flatten([
      for app in local.config.applications : [
        for level, perms in app.permissions : [
          for user in try(perms.users, []) : [
            for repo in app.repositories : {
              key        = "${app.name}/${repo.name}/${user}"
              repo_key   = "${app.name}/${repo.name}"
              user       = user
              permission = local.permission_levels[level]
            }
          ]
        ]
      ]
    ]) : entry.key => entry
  }

  # Group (team) permissions on repositories, across all apps
  team_permissions_map = {
    for entry in flatten([
      for app in local.config.applications : [
        for level, perms in app.permissions : [
          for group_name in try(perms.groups, []) : [
            for repo in app.repositories : {
              key        = "${app.name}/${repo.name}/${group_name}"
              repo_key   = "${app.name}/${repo.name}"
              team       = group_name
              permission = local.permission_levels[level]
            }
          ]
        ]
      ]
    ]) : entry.key => entry
  }

  # --------------------------------------------------
  # Repository rulesets – flatten across all apps/repos
  # Key: "${app_name}/${repo_name}/${ruleset_name}"
  # --------------------------------------------------
  rulesets = merge([
    for app in local.config.applications : merge([
      for repo in app.repositories : {
        for rs in try(repo.rule_set, []) : "${app.name}/${repo.name}/${rs.name}" => merge(rs, {
          repo_key = "${app.name}/${repo.name}"
        })
      }
    ]...)
  ]...)
}
