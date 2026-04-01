# Platform Repo Cheatsheet

## Setup

```bash
export GITHUB_OWNER="your-github-org"
export GITHUB_TOKEN="ghp_YOUR_TOKEN_HERE"
cd 02-python-scaling
```

## Expected outputs for this step
Define a yaml contract for creating:
* repositories
* organization team
* repositories permissions assignments (user and teams)
* branch protection with push ruleset

Create two repositories in your account:
* my_account/repo-a-public with branch protection on branch main
* my_account/repo-a-private

Create one team in your organization:
* my_organization/my-team

Assign the team as maintainer for all repos.