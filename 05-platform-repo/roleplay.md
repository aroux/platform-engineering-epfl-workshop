# Roleplay Scenarios: Why a Python Validation Layer?

---

## Scenario 1: The Terraform YAML Nightmare

**Setup the scene:**

> You're a platform engineer maintaining the Terraform codebase that provisions
> GitHub repositories, teams, and permissions. The provisioning YAML has grown —
> dozens of applications, hundreds of repos.
>
> A colleague asks you to add a new validation rule: repository names must not
> exceed 60 characters when prefixed with the application name. You open
> `locals.tf` and stare at the HCL. You need to parse YAML inside Terraform
> using `yamldecode()`, then loop through nested structures with `flatten()`,
> build maps with `for` expressions, and somehow produce a meaningful error
> message.
>
> Three hours later, you have a monstrosity of nested `for` expressions and
> `try()` calls. It works — barely. Your colleague reviews the PR:
>
> *"I have no idea what this does. Can you add comments?"*
>
> You add comments. Now the file is 200 lines long and the comments are longer
> than the logic. A week later, a new edge case breaks it. You're back in
> `locals.tf`, trying to debug a `flatten()` inside a `merge()` inside a `for`.

**The pain:**

> "HCL was designed for declaring infrastructure, not for parsing and
> validating complex data structures. I'm fighting the language."
>
> "Every time I add a validation rule in Terraform, it takes five times longer
> than it would in Python. And the next person who reads it will have no idea
> what's going on."
>
> "I spent a full day debugging a `for` expression that silently produced an
> empty map instead of throwing an error. Terraform doesn't tell you *why*
> something is empty."


---

## Scenario 2: The Cryptic Error

**Setup the scene:**

> Developers fill in the provisioning YAML for their projects and submit pull
> requests. CI runs `terraform plan` and fails. Every week, you get the same
> Slack messages: *"The pipeline failed. I don't understand the error."*
>
> Here's a collection of real errors developers have hit — and the simple YAML
> mistakes behind them.

**Example 1 — A typo in a group name:**

> ```
> Error: Invalid index
>
>   on main.tf line 42, in resource "github_team_repository" "this":
>   42:   team_id = github_team.this[each.value.team].id
>     |----------------
>     | each.value.team is "backend-devs"
>
> The given key does not identify an element in this collection value.
> ```
>
> The developer just wanted to give their team write access. The real problem?
> They wrote `backend-devs` instead of `backend-dev` in their YAML.

**Example 2 — A special character in a repository name:**

> ```
> Error: PUT https://api.github.com/repos/pictet/order-service/my repo
>        422 Unprocessable Entity
>
>   on main.tf line 18, in resource "github_repository" "this":
>   18:   name = each.value.name
>
> Validation Failed: {"resource":"Repository",
> "code":"custom","field":"name",
> "message":"name can only contain ASCII letters, digits,
> and the characters ., - and _"}
> ```
>
> The developer named their repo `my repo` (with a space). The error comes
> back as a raw GitHub API response wrapped in Terraform — a wall of JSON
> that most developers won't parse.

**Example 3 — A ruleset on a private repository:**

> ```
> Error: PUT https://api.github.com/repos/pictet/order-service-config/rulesets
>        404 Not Found
>
>   on main.tf line 87, in resource "github_repository_ruleset" "this":
>   87:   repository = github_repository.this[each.value.repo].name
>
> Resource not accessible by integration
> ```
>
> The developer added branch protection rules to a private repo. The GitHub
> API returns a `404 Not Found` — not because the repo doesn't exist, but
> because rulesets aren't available on private repos with this plan.
> The developer reads "Resource not accessible by integration" and assumes
> the GitHub token is misconfigured. They open a support ticket. Three
> people investigate before someone realizes it's a visibility issue.

**Example 4 — A repository name that's too long:**

> ```
> Error: PUT https://api.github.com/orgs/pictet/repos
>        422 Unprocessable Entity
>
>   on main.tf line 18, in resource "github_repository" "this":
>   18:   name = each.value.name
>
> Validation Failed: {"resource":"Repository",
> "code":"custom","field":"name",
> "message":"name is too long (maximum is 100 characters)"}
> ```
>
> The developer didn't realize Terraform prefixes the application name to
> their repo name. They wrote a 55-character repo name, the application
> name is 20 characters, and the final name `order-service-<long-name>`
> exceeds the limit. The error says "100 characters" (the GitHub API limit)
> but your organization's convention is 60 — so even if they trim to 100,
> the next validation will still fail.

**The pain:**

> "I shouldn't need to understand Terraform to fill in a YAML file. The errors
> talk about resources, indexes, collection values, and raw API responses —
> none of that means anything to me."
>
> "I wasted 30 minutes trying to decode a Terraform error that boiled down to
> a typo in a group name."
>
> "A 404 on a ruleset? I assumed the token was broken. Three people
> investigated before we realized it was just a private repo."
>
> "Every time CI fails, developers come to me because they can't interpret the
> errors. I've become a full-time Terraform translator."
