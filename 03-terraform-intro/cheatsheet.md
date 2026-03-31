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

## State Inspection

```bash
# List all managed resources
terraform state list

# Show details for a specific resource
terraform state show github_repository.demo

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

## Dependency Graph

```bash
# Text output
terraform graph
```

---

## Testing

```bash
# Run unit tests (mock provider, no credentials needed)
terraform test
```

---

## File Layout

| File | Purpose |
|------|---------|
| `backend.tf` | State backend configuration |
| `providers.tf` | GitHub provider setup |
| `variables.tf` | Input variables |
| `01-main.tf` | Resources: repo, branch protection, labels |
| `02-locals.tf` | Locals: JSON parsing, derived values |
| `outputs.tf` | Outputs: URLs, labels |
| `repo_topics.json` | External config data |

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

# 5. Make a change in 01-main.tf, then:
terraform plan    # See the diff
terraform apply   # Apply it

# 6. Clean up
terraform destroy
```
