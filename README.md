# platform-engineering-epfl-workshop
Repository for the EPFL workshop about Platform Engineering.

## Prerequesites
An environment supporting devcontainers. Either GitHub Codespaces or Visual Studio Code with devcontainer plugin and Docker.

### Organization 

Create a new free organization here : https://github.com/account/organizations/new 

Name it as you wish and add other team members in it. 

#### Accepting invitations

You can see your pending invitations in the settings page here : https://github.com/settings/organizations

#### Deleting the organization


Once the workshop is finished, we recommend you clear up everything and delete the organization : 

1. Go to your organization page. 
2. Navigate to ** Settings -> General ** 
3. Scroll all the way down and select `Delete this organization`


### GitHub Personal Access Token
The GitHub Personal Access Token (PAT) provided by GitHub Codespaces doesn't grant the required permissions for the workshop.

You can generate a PAT by doing the following:
1. Go to [**Settings → Developer settings → Personal access tokens → Tokens (classic)**](https://github.com/settings/tokens)
2. Click **Generate new token (classic)**
3. Add a name + expiration
4. Select scope: **`repo`** (full repo control) and **`delete_repo`** 
5. Generate and copy the token

Then you can use it by exporting this env variable:
```bash
export GITHUB_TOKEN="ghp_YOUR_TOKEN_HERE"
```
