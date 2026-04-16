# Terraform Cheatsheet

## Setup

```bash
export TF_VAR_github_token="ghp_YOUR_TOKEN_HERE"
export TF_VAR_github_owner="your-github-username"
cd 03-terraform-intro
```

---

## Core Workflow

| Command | What it does |
|---------|--------------|
| `terraform init` | Download providers, set up backend (run once) |
| `terraform plan` | Preview changes without applying |
| `terraform apply` | Apply changes (creates/updates resources) |
| `terraform destroy` | Delete all managed resources |

---

## File Layout

| File | Purpose | You edit it? |
|------|---------|:---:|
| `provisioning.yaml` | Source of truth — declarative config | **Yes** |
| `backend.tf` | State backend configuration | No |
| `providers.tf` | GitHub provider setup | No |
| `variables.tf` | Input variables (`github_token`, `github_owner`) | No |
| `locals.tf` | YAML parsing and flattened lookup maps | No |
| `main.tf` | Resources: teams, repos, permissions, rulesets | No |
| `outputs.tf` | Values printed after apply | No |

---

---

## State Inspection

```bash
# List all managed resources
terraform state list

# Show details for a specific resource
terraform state show 'github_repository.my_repo' 

# Print all outputs
terraform output

# Machine-readable outputs (for scripts)
terraform output -json
```

---

## Drift Detection

```bash
# Compare desired state (.tf files) vs actual state (API)
terraform plan

# Fix drift by re-applying desired state
terraform apply
```

---

## Useful Resources

| Resource | Docs |
|----------|------|
| Repository | [github_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) |
| Collaborator | [github_repository_collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) |
| Team | [github_team](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) |
| Team membership | [github_team_membership](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) |
| Team repository | [github_team_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) |
| Repository ruleset | [github_repository_ruleset](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) |

Browse the full provider: [registry.terraform.io/providers/integrations/github](https://registry.terraform.io/providers/integrations/github/latest/docs)

---

## Quick Demo Flow

```bash
# 1. Initialize
terraform init

# 2. Preview what will be created
terraform plan

# 3. Create resources
terraform apply

# 4. Inspect state
terraform state list
terraform output

# 5. Edit provisioning.yaml (e.g. add a new repository), then:
terraform plan    # See the diff
terraform apply   # Apply it

# 6. Clean up
terraform destroy
```

## HCL Logic

A single hardcoded resource to get you started:

```hcl
resource "github_repository" "example" {
  name        = "my-repo"
  description = "A single hardcoded repository"
  visibility  = "private"
  auto_init   = true
}
```

To go from hardcoded blocks to loops over `local.config`, you'll need these HCL concepts:

| Pattern | What it does | Docs |
|---------|-------------|------|
| `for_each` | Create multiple resources from a map | [for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each) |
| `for` expressions | Transform lists/maps into new structures | [for expressions](https://developer.hashicorp.com/terraform/language/expressions/for) |
| `merge()` / `flatten()` | Combine nested maps/lists into flat structures | [merge](https://developer.hashicorp.com/terraform/language/functions/merge), [flatten](https://developer.hashicorp.com/terraform/language/functions/flatten) |
| `try()` | Provide defaults for optional YAML fields | [try](https://developer.hashicorp.com/terraform/language/functions/try) |
| `dynamic` blocks | Conditionally include nested blocks | [dynamic blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks) |

---

## Expected Outputs

From the example `provisioning.yaml`, Terraform will create:

| Resource | Key |
|----------|-----|
| Team | `epfl-ws-global-admins` |
| Team membership | `epfl-ws-global-admins/aroux` |
| Repository | `epfl-ws-order-management-api` (private) |
| Repository | `epfl-ws-order-management-frontend` (public) |
| Collaborator | `lanzrein` with `write` on both repos |
| Team permission | `epfl-ws-global-admins` with `admin` on both repos |
| Ruleset | `main` on `epfl-ws-order-management-frontend` |



