# Platform Repo Cheatsheet

## Setup

```bash
export GITHUB_OWNER="your-github-org"
export GITHUB_TOKEN="ghp_YOUR_TOKEN_HERE"
cd 05-platform-repo
```

---

## Python CLI (uv)

| Command | What it does |
|---------|--------------|
| `uv run python -m src.cli --help` | Show available CLI commands |
| `uv run python -m src.cli yaml-to-json <yaml>` | Phase 1: validate YAML and export JSON |
| `uv run python -m src.cli json-to-tfvars <json>` | Phase 2: generate terraform.tfvars.json |
| `uv sync` | Install dependencies from pyproject.toml |

Run from the `python/` directory.

---

## Running Tests

```bash
cd python

# Run all tests
uv run pytest tests/ -v

# Run only model validation tests
uv run pytest tests/test_models.py -v

# Run only tfvars generation tests
uv run pytest tests/test_tfvars.py -v

# Run a specific test class
uv run pytest tests/test_models.py::TestRepoNameChars -v
```

---

## Full Pipeline

```bash
# Plan only (default)
./provision.sh

# Plan and apply
./provision.sh apply
```

The script runs three phases:
1. YAML → Pydantic validation → `provisioning.json`
2. JSON → Pydantic validation → `terraform/terraform.tfvars.json`
3. `terraform init` + `plan` (or `apply`)

---

## File Layout

| Path | Purpose |
|------|---------|
| `provisioning.yaml` | Source of truth (declarative config) |
| `provision.sh` | Orchestration script (all 3 phases) |
| `python/pyproject.toml` | Python project config and dependencies |
| `python/src/models.py` | Pydantic data models with validations |
| `python/src/mapper.py` | Config → tfvars transformation logic |
| `python/src/cli.py` | Typer CLI (yaml-to-json, json-to-tfvars) |
| `python/tests/` | Pytest test suite |
| `python/tests/fixtures/` | YAML test fixtures |
| `terraform/main.tf` | GitHub resources (teams, repos, rulesets) |
| `terraform/variables.tf` | Input variables (populated from tfvars) |
| `terraform/providers.tf` | GitHub provider configuration |

---

## Quick Demo Flow

```bash
# 1. Run the full pipeline (plan only)
./provision.sh

# 2. Apply changes
./provision.sh apply

# 3. Inspect Terraform state
cd terraform
terraform state list
terraform output

# 4. Edit provisioning.yaml, then re-run
cd ..
./provision.sh

# 5. Clean up
cd terraform
terraform destroy
```
