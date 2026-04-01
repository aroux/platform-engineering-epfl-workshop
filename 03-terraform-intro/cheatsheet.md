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

## The Pattern

```
Write a block  -->  terraform plan  -->  terraform apply  -->  repeat
```

---

## Useful Resources

The GitHub Terraform provider documentation has examples and argument
references for every resource type you'll need:

| Resource | Docs |
|----------|------|
| Repository | [github_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) |
| Collaborator | [github_repository_collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) |
| Branch protection | [github_branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) |

Browse the full provider: [registry.terraform.io/providers/integrations/github](https://registry.terraform.io/providers/integrations/github/latest/docs)

---

## State Inspection

```bash
# List all managed resources
terraform state list

# Show details for a specific resource
terraform state show github_repository.golden_retrievers

# Print all outputs
terraform output
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

## File Layout

| File | Purpose | You edit it? |
|------|---------|:---:|
| `backend.tf` | State backend configuration | No |
| `providers.tf` | GitHub provider setup | No |
| `variables.tf` | Input variables | No |
| `xxx.tf` | **Your resources** | **Yes** |
| `outputs.tf` | Values printed after apply | Yes |

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

# 5. Make a change in a file xxx.tf, then:
terraform plan    # See the diff
terraform apply   # Apply it

# 6. Clean up
terraform destroy
```


## Expected outputs for this step
Create two repositories in your account:
* my_account/repo-a-public
* my_account/repo-b-public