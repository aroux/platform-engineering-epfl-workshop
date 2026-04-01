# platform-engineering-epfl-workshop
Repository for the EPFL workshop about Platform Engineering.

## Prerequesites
An environment supporting devcontainers. Either GitHub Codespaces or Visual Studio Code with devcontainer plugin and Docker.

## GitHub Personal Access Token
The GitHub Personal Access Token (PAT) provided by GitHub Codespaces doesn't grant the required permissions for the workshop.

You can generate a PAT by doing the following:
1. Go to **Settings → Developer settings → Personal access tokens → Tokens (classic)**
2. Click **Generate new token (classic)**
3. Add a name + expiration
4. Select scope: **`repo`** (full repo control) and **`delete_repo`** 
5. Generate and copy the token

Then you can use it by exporting this env variable:
```bash
export GITHUB_TOKEN="ghp_YOUR_TOKEN_HERE"
```
