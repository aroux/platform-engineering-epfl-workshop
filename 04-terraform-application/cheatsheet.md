# Terraform Application Cheatsheet

## Setup

```bash
export TF_VAR_github_owner="your-github-org"
export GITHUB_TOKEN="ghp_YOUR_TOKEN_HERE"
cd 04-terraform-application
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

## State Inspection

```bash
# List all managed resources
terraform state list

# Show details for a specific resource
terraform state show github_repository.this[\"epfl-ws-order-management/api\"]

# Print all outputs
terraform output

# Machine-readable outputs (for scripts)
terraform output -json
```

---

## File Layout

| File | Purpose |
|------|---------|
| `provisioning.yaml` | Source of truth (declarative config) |
| `providers.tf` | GitHub provider setup |
| `backend.tf` | State backend configuration |
| `variables.tf` | Input variables (`github_owner`) |
| `locals.tf` | YAML parsing and flattened lookup maps |
| `main.tf` | Resources: teams, repos, permissions, rulesets |
| `outputs.tf` | Outputs: team IDs, repo URLs, permissions |

---

## How It Works

1. `locals.tf` reads `provisioning.yaml` via `yamldecode(file(...))`
2. Nested loops flatten groups, repos, permissions, and rulesets into keyed maps
3. `main.tf` uses `for_each` on those maps to provision all resources

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

# 5. Edit provisioning.yaml, then:
terraform plan    # See the diff
terraform apply   # Apply it

# 6. Clean up
terraform destroy
```
